EXPORTS = {}

EXPORTS.Init = function( self )
	-- Defer the initialization to first tick, to allow spawners to set state.
	self.aiState = {
		hAggroTarget = nil,
		vSpawnLocation = self:GetAbsOrigin(),
		flAcquisitionRange = 700,
		fOutOfCombatRange = 1600,
		nWalkingMoveSpeed = 160,
		nAggroMoveSpeed = 300,
		nLeashRange = 2000,
		silenced = false
	}
	self:SetContextThink( "init_think", function() 
		self.WildPokemonThink = WildPokemonThink
		self.FindAggro = FindAggro
		self.OutOfRange = OutOfRange
		self.MoveToAggroTarget = MoveToAggroTarget
		self.CastSpellOnTarget = CastSpellOnTarget
		self.RoamBetweenWaypoints = RoamBetweenWaypoints
		self.EvasiveManeuvers = EvasiveManeuvers
		self.isCastingAbility = isCastingAbility
		self.Leash = Leash
		self.tPlayerTrainers = FindUnitsInRadius(DOTA_TEAM_NEUTRALS, self:GetAbsOrigin(), nil, 2000, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_INVULNERABLE, 0, false)
		self.attackers = {}
		
		--find the unit's abilities
		self.aiState.abilityList = {}
		for i=0,3 do
			if self:GetAbilityByIndex(i) ~= nil then
				table.insert(self.aiState.abilityList,self:GetAbilityByIndex(i))
			end
		end

	    -- Generate nearby waypoints for this unit
	    local tWaypoints = {}
	    local nWaypointsPerRoamNode = 10
	    local nMinWaypointSearchDistance = 0
	    local nMaxWaypointSearchDistance = 2048

	    while #tWaypoints < nWaypointsPerRoamNode do
	    	local vWaypoint = self:GetAbsOrigin() + RandomVector( RandomFloat( nMinWaypointSearchDistance, nMaxWaypointSearchDistance ) )
	    	if GridNav:CanFindPath( self:GetAbsOrigin(), vWaypoint ) then
	    		table.insert( tWaypoints, vWaypoint )
	    	end
	    end
	    self.aiState.tWaypoints = tWaypoints
	    self:SetContextThink( "ai_base_creature.WildPokemonThink", Dynamic_Wrap( self, "WildPokemonThink" ), 0 )
	end, 0 )
end


function WildPokemonThink( self )
    if not self:IsAlive() then
    	return
    end
	if GameRules:IsGamePaused() or self:isCastingAbility() then
		return 0.1
	end
	self:OutOfRange()
	if (self:GetAbsOrigin() - self.aiState.vSpawnLocation):Length2D() > self.aiState.nLeashRange then
		self:Leash()
	end
	if self:FindAggro() then
		if self.aiState.silenced then
			return self:EvasiveManeuvers()
		elseif self:FindModifierByName("modifier_silenced_after_spell") ~= nil then
			self:MoveToAggroTarget()
			return .1
		else
			self:MoveToAggroTarget()
			--this timer is to give time for the unit to point towards the target, useful for notarget abilities like pounce
			Timers:CreateTimer(0.2,
				function()
					if self:IsAlive() and (self:FindModifierByName("modifier_silenced_after_spell") == nil) then
						self:CastSpellOnTarget()
					end
				end)
			return .3
		end
	end
	return self:RoamBetweenWaypoints()
end

--------------------------------------------------------------------------------
-- Leash
-- Start to return to the spawn
--------------------------------------------------------------------------------
function Leash( self )
	self:MoveToPosition( self.aiState.vSpawnLocation )
	return RandomFloat( 2, 3 )
end

--------------------------------------------------------------------------------
-- EvasiveManeuvers
-- While spells are on CD, attempt to avoid enemy spells while staying close by
--------------------------------------------------------------------------------
function EvasiveManeuvers( self )
	local distanceFromTarget = 200 --how far away from the target you want to be able to 'evade' to
	local evasiveTarget = self.aiState.hAggroTarget:GetAbsOrigin() + RandomVector( RandomFloat( 0, distanceFromTarget ) )
	self:MoveToPosition( evasiveTarget )
	return RandomFloat( .8, 1.2 )
end

--------------------------------------------------------------------------------
-- OutOfRange
-- If there is no nearby Trainer Pokemon, delete yourself and end the battle
--------------------------------------------------------------------------------
function OutOfRange( self )
	local closePokemon = FindUnitsInRadius(self:GetTeam(), self:GetAbsOrigin(), nil, self.aiState.fOutOfCombatRange, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_CREEP, 0, 0, false)
	if #closePokemon == 0 then
		self:AddNoDraw()
		self:ForceKill( false )
	end
end

--------------------------------------------------------------------------------
-- FindAggro
-- If there is a nearby Trainer Pokemon, pursue it
--------------------------------------------------------------------------------
function FindAggro( self )
	local aggroTargets = FindUnitsInRadius(self:GetTeam(), self:GetAbsOrigin(), nil, self.aiState.flAcquisitionRange, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_CREEP, 0, 0, false)
	for _,v in pairs(aggroTargets) do
		self.attackers[v.pokemon] = true
		if v.pokemon ~= nil then
			self.aiState.hAggroTarget = v
			self:SetBaseMoveSpeed( self.aiState.nAggroMoveSpeed )
		end
		return true
	end
	self:SetBaseMoveSpeed( self.aiState.nWalkingMoveSpeed )
	return false
end

--------------------------------------------------------------------------------
-- MoveToAggroTarget
-- Move towards the current position of the Aggro Target
--------------------------------------------------------------------------------
function MoveToAggroTarget( self )
	self:MoveToPositionAggressive( self.aiState.hAggroTarget:GetAbsOrigin() )
end

--------------------------------------------------------------------------------
-- CastSpellOnTarget
-- Uses a random ability, with the target as the focus
--------------------------------------------------------------------------------
function CastSpellOnTarget( self )
	local abilityList = self.aiState.abilityList
	local attempt = 0
	local nRandomIndex = RandomInt( 1, #abilityList )
	ability = abilityList[ nRandomIndex ]
	
	local i = nRandomIndex
	
	while ability == nil or not ability:IsCooldownReady() do
		i = i - 1
		if i < 1 then
			i = #abilityList
		end
		if i == nRandomIndex then
			return false
		end
		ability = abilityList[i]
	end
	
	local target = self.aiState.hAggroTarget
	
	if string.sub(getBinaryValues(ability:GetBehavior()),3,3) == "1" then
		--DOTA_ABILITY_BEHAVIOR_NO_TARGET
		self:CastAbilityNoTarget(ability, -1)
	elseif string.sub(getBinaryValues(ability:GetBehavior()),4,4) == "1" then
		--DOTA_ABILITY_BEHAVIOR_UNIT_TARGET
		self:CastAbilityOnTarget(target, ability, -1)
	elseif string.sub(getBinaryValues(ability:GetBehavior()),5,5) == "1" then
		--DOTA_ABILITY_BEHAVIOR_POINT
		self:CastAbilityOnPosition(target:GetAbsOrigin(), ability, -1)
	elseif string.sub(getBinaryValues(ability:GetBehavior()),6,6) == "1" then
		--DOTA_ABILITY_BEHAVIOR_AOE
		self:CastAbilityOnPosition(target:GetAbsOrigin(), ability, -1)
	end

	--don't cast a spell for another 3 seconds to simulate being silenced
	self.aiState.silenced = true
	Timers:CreateTimer(3,
		function()
		  self.aiState.silenced = false
		end)
	
	return true
end

--------------------------------------------------------------------------------
-- RoamBetweenWaypoints
--------------------------------------------------------------------------------
function RoamBetweenWaypoints( self )
	local gameTime = GameRules:GetGameTime()
	local aiState = self.aiState
	if aiState.vWaypoint ~= nil then
		local flRoamTimeLeft = aiState.flNextWaypointTime - gameTime
		if flRoamTimeLeft <= 0 then
			aiState.vWaypoint = nil
		end
	end
    if aiState.vWaypoint == nil then
        aiState.vWaypoint = aiState.tWaypoints[ RandomInt( 1, #aiState.tWaypoints ) ]
        aiState.flNextWaypointTime = gameTime + RandomFloat( 2, 4 )
    	self:MoveToPositionAggressive( aiState.vWaypoint )
    end
   	return RandomFloat( 0.5, 1.0 )
end


function getBinaryValues( decNumber )
    local backwards = ""

    while decNumber > 0 do
        local rem = decNumber % 2
        backwards = backwards .. rem
        decNumber = math.floor(decNumber / 2)
	end
	--return string.reverse(backwards)
	return backwards
end

function isCastingAbility( self )
	local abilityList = self.aiState.abilityList

	if (self:GetCurrentActiveAbility()) ~= nil then
		return true
	end
	
	for i=1,#abilityList do
		if abilityList[i]:IsInAbilityPhase() then
			return true
		end
	end
	
	return false
end

return EXPORTS
