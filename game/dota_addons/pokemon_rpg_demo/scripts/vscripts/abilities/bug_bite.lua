--PP 20
--Power 60
--Accuracy 100%
--Type BUG
--Category Physical (physical)
--eats the target's berry
function BugBite( keys )
	local caster = keys.caster
	local target = keys.target
	local target_location = target:GetAbsOrigin()
	local ability = keys.ability
	local pokemon = target.pokemon

	if pokemon ~= nil then
		PokeHelper:CalculatePokemonDamage(ability, caster, target, "BUG")
	end
end