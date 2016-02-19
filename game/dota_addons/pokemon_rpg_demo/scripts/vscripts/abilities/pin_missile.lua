--PP 20
--Power 25
--Accuracy 95%
--Type BUG
--Category Physical
--hits the target 2-5 times
function PinMissileStart( keys )
	keys.missileCount = 0
	keys.numberOfMissiles = 0
	
	local roll = RandomFloat(0,1)
	--There is a 37.5% chance that it will hit 2 times, a 37.5% chance that it will hit 3 times, a 12.5% chance that it will hit 4 times, and a 12.5% chance that it will hit 5 times. 
	if roll < .375 then
		keys.numberOfMissiles = 2
	elseif roll >= .375 and roll < .75 then
		keys.numberOfMissiles = 3
	elseif roll >= .75 and roll < .875 then
		keys.numberOfMissiles = 4
	elseif roll >= .875 then
		keys.numberOfMissiles = 5
	end
	
	Fire( keys )
end

function Fire( keys )
	local caster = keys.caster
	local ability = keys.ability
	local speed = ability:GetLevelSpecialValueFor("speed", (ability:GetLevel() - 1))
	local width = ability:GetLevelSpecialValueFor("width", (ability:GetLevel() - 1))
	local range = ability:GetLevelSpecialValueFor("range", (ability:GetLevel() - 1))
	local vision = ability:GetLevelSpecialValueFor("vision", (ability:GetLevel() - 1))
	local casterOrigin = caster:GetAbsOrigin()
	
	caster:AddNewModifier(unit,nil,"modifier_stunned",{duration = .35})
	
	local targetPos = keys.target_points[1]
	local direction = targetPos - casterOrigin
	direction = direction / direction:Length2D()

	keys.missileCount = keys.missileCount + 1
	
	if keys.missileCount > keys.numberOfMissiles then
		return
	end
	
	caster:Stop()
	caster:StartGesture(ACT_DOTA_ATTACK)
	
	EmitSoundOn("Hero_Enchantress.Impetus", caster)
	
	Timers:CreateTimer(.35, function()
			ProjectileManager:CreateLinearProjectile( {
			Ability				= ability,
			EffectName			= "particles/custom_particles/poison_sting.vpcf",
			vSpawnOrigin		= casterOrigin,
			fDistance			= range,
			fStartRadius		= width,
			fEndRadius			= width,
			Source				= caster,
			bHasFrontalCone		= false,
			bReplaceExisting	= false,
			iUnitTargetTeam		= DOTA_UNIT_TARGET_TEAM_ENEMY,
			iUnitTargetFlags	= DOTA_UNIT_TARGET_FLAG_NONE,
			iUnitTargetType		= DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_CREEP + DOTA_UNIT_TARGET_MECHANICAL,
		--	fExpireTime			= ,
			bDeleteOnHit		= true,
			vVelocity			= speed * direction,
			bProvidesVision		= true,
			iVisionRadius		= vision,
			iVisionTeamNumber	= caster:GetTeamNumber(),
		} )
			
		Fire( keys )
	end)
end

function OnProjectileHit( keys )
	local caster = keys.caster
	local target = keys.target
	local ability = keys.ability
	local pokemon = target.pokemon
	
	if pokemon ~= nil then
		PokeHelper:CalculatePokemonDamage(ability, caster, target, "BUG")
	end
end