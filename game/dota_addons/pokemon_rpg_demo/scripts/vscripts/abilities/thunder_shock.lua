--PP 30
--Power 40
--Accuracy --
--Type ELECTRIC
--Category Special (magical)
--10% chance to paralyze
function ThunderShock( keys )
	local caster = keys.caster
	local target = keys.target
	local ability = keys.ability
	local pokemon = target.pokemon
	local debuffChance = ability:GetLevelSpecialValueFor("debuff_chance", (ability:GetLevel() - 1))
	
	local targetPosition = target:GetAbsOrigin()
	
	local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_zuus/zuus_lightning_bolt.vpcf", PATTACH_CUSTOMORIGIN, nil)
	ParticleManager:SetParticleControl(particle, 0, Vector(targetPosition.x,targetPosition.y,2000))
	ParticleManager:SetParticleControl(particle, 1, targetPosition) -- point landing
	ParticleManager:SetParticleControl(particle, 2, targetPosition) -- point origin

	if pokemon ~= nil then
		PokeHelper:CalculatePokemonDamage(ability, caster, target, "ELECTRIC")
		if RandomFloat(0,100) < debuffChance then
			PokeHelper:InflictStatus( target, "PARALYZED" )
		end
	end	
end