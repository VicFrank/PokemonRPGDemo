--PP 25
--Power 20
--Accuracy 100%
--Type BUG
--Category Special (magical)
--absorbs up to 50% of damage done (round up)
function LeechLife( keys )
	local caster = keys.caster
	local target = keys.target
	local ability = keys.ability
	local pokemon = target.pokemon
	local casterPokemon = caster.pokemon

	if pokemon ~= nil then
		local damage = PokeHelper:CalculatePokemonDamage(ability, caster, target, "BUG")
		local heal = math.ceil(damage / 2)
		
		if damage > pokemon:GetCurrentHP() then
			heal = pokemon:GetCurrentHP()
		end

		--don't revive dead pokemon
		if casterPokemon:GetCurrentHP() > 0 then
			casterPokemon:SetCurrentHP(casterPokemon:GetCurrentHP() + heal)
			caster:Heal(heal,caster)
		end
	end
end