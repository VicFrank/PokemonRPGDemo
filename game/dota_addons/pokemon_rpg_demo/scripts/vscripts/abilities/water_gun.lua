--PP 25
--Power 40
--Accuracy 100%
--Type WATER
--Category Special (magical)
function WaterGun( keys )
	local caster = keys.caster
	local target = keys.target
	local target_location = target:GetAbsOrigin()
	local ability = keys.ability
	local pokemon = target.pokemon

	if pokemon ~= nil then
		PokeHelper:CalculatePokemonDamage(ability, caster, target, "WATER")
	end
end