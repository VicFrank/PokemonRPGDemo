--PP 35
--Power 40
--Accuracy 100%
--Type NORMAL
--Category Physical
function Pound( keys )
	local caster = keys.caster
	local target = keys.target
	local pokemon = caster.pokemon
	local ability = keys.ability
	local damage_radius = ability:GetLevelSpecialValueFor("damage_radius", (ability:GetLevel() - 1))
	local direction = caster:GetForwardVector()
	local center = caster:GetAbsOrigin() + direction * damage_radius

	if pokemon ~= nil then
		caster:Stop()
		caster:StartGesture(ACT_DOTA_ATTACK)
		
		Timers:CreateTimer(.3, function()
			EmitSoundOn("Hero_DragonKnight.DragonTail.Target", target)
			PokeHelper:CalculatePokemonDamage(ability, caster, target, "NORMAL")
		end)
	end
end