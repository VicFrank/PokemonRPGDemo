--PP 20
--Power 60
--Accuracy 100%
--Type FLYING
--Category Physical
function QuickAttack( keys )
	local caster = keys.caster
	local target = keys.target
	local ability = keys.ability
	local damage_radius = ability:GetLevelSpecialValueFor("damage_radius", (ability:GetLevel() - 1))
	
	--teleport the caster to the target
	caster:SetAbsOrigin(target:GetAbsOrigin())
	FindClearSpaceForUnit(caster, target:GetAbsOrigin(), true)
	caster:SetForwardVector((target:GetAbsOrigin() - caster:GetAbsOrigin()):Normalized())
	
	local direction = caster:GetForwardVector()
	local center = caster:GetAbsOrigin() + direction * damage_radius
	
	caster:Stop()
	caster:StartGesture(ACT_DOTA_ATTACK)
	
	Timers:CreateTimer(.5, function()
		local searchArea = FindUnitsInRadius( caster:GetTeam(), center, nil, damage_radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_ALL, 0, 0, false )
		for _,v in pairs(searchArea) do
			EmitSoundOn("Hero_NyxAssassin.attack", v)
			PokeHelper:CalculatePokemonDamage(ability, caster, v, "FLYING")
		end
	end)
end