EXPORTS = {}

EXPORTS.Init = function( self )
	-- Defer the initialization to first tick, to allow spawners to set state.
	self.aiState = {
		hAggroTarget = nil,
		vSpawnLocation = self:GetAbsOrigin(),
		flAcquisitionRange = 2900,
		fOutOfCombatRange = 4000,
		nWalkingMoveSpeed = 160,
		nAggroMoveSpeed = 300,
		nLeashRange = 2000,
		silenced = false
	}
	self:SetContextThink( "init_think", function() 
		self.TrainerPokemonThink = TrainerPokemonThink
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
	    self:SetContextThink( "ai_base_creature.TrainerPokemonThink", Dynamic_Wrap( self, "TrainerPokemonThink" ), 0 )
	end, 0 )
end


function TrainerPokemonThink( self )
    if not self:IsAlive() then
    	return
    end
	if GameRules:IsGamePaused() or self:isCastingAbility() then
		return 0.1
	end
	self:OutOfRange()
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
					if self:IsAlive() and self:FindModifierByName("modifier_silenced_after_spell") == nil then
						self:CastSpellOnTarget()
					end
				end)
			return .4
		end
	end
	return self:RoamBetweenWaypoints()
end

return EXPORTS