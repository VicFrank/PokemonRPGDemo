--PP 25
--Power 50
--Accuracy 100%
--Type PSYCHIC
--Category SPECIAL
function Confusion( keys )
	local caster = keys.caster
	local target = keys.target
	local ability = keys.ability
	local debuff = ability:GetLevelSpecialValueFor("debuff", (ability:GetLevel() - 1))
	local debuffChance = ability:GetLevelSpecialValueFor("debuff_chance", (ability:GetLevel() - 1))
	local radius = ability:GetLevelSpecialValueFor("radius", (ability:GetLevel() - 1))
	local pokemon = target.pokemon
	
	local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_enigma/enigma_midnight_pulse.vpcf", PATTACH_WORLDORIGIN, caster)
	ParticleManager:SetParticleControl(particle, 0, target:GetAbsOrigin()) 
	ParticleManager:SetParticleControl(particle, 1, Vector(radius,0,0))
	
	Timers:CreateTimer(1, function()
		ParticleManager:DestroyParticle(particle, false)
	end)

	if pokemon ~= nil then
		PokeHelper:CalculatePokemonDamage(ability, caster, target, "PSYCHIC")
		if RandomFloat(0,100) < debuffChance then
			PokeHelper:ApplyModifier( target, "modifier_confusion" )
		end
	end
end