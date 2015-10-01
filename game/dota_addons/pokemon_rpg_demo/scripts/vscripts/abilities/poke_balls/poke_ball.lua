function Activate(keys)
	local caster = keys.caster
	local ability = keys.ability
	local target_point = keys.target_points[1]
	local currentAvatar = caster.pokemonAvatar
	local currentPokemon
	if currentAvatar ~= nil then
		currentPokemon = currentAvatar.pokemon
	end
	local pokemon = ability.pokemon
	
	--check the trainer's current pokemon
	--if it's the pokemon associated with this ball, return the pokemon
	if currentPokemon == pokemon then
		if caster.state == "In Battle" then
			print("You must have a pokemon out during battle!")
		else
			PokeHelper:Withdraw( caster )
		end
	--if there is no pokemon out, send this pokemon out
	elseif currentPokemon == nil then
		if pokemon:GetCurrentHP() > 0 then
			local pokemonAvatar = PokeHelper:CreatePokemonAtPosition( pokemon, target_point, caster, caster:GetTeam() )
			ability:ApplyDataDrivenModifier(caster, pokemonAvatar, "summoning_sickness", {})
		else
			print("This pokemon does not have the will to fight.")
		end
	--otherwise, withdraw the current pokemon, then send this pokemon out in its place
	else
		print(pokemon:GetCurrentHP())
		if pokemon:GetCurrentHP() > 0 then
			local position = currentAvatar:GetAbsOrigin()
			ability:ApplyDataDrivenModifier(caster, pokemonAvatar, "summoning_sickness", {})
			--after 1 second, withdraw the pokemon and send out the next one
			Timers:CreateTimer(1.5,
				function()
					--make sure the pokemon hasn't fainted by the time we got here
					if currentAvatar == caster.pokemonAvatar then
						PokeHelper:Withdraw( caster )
						local pokemonAvatar = PokeHelper:CreatePokemonAtPosition( pokemon, position, caster, caster:GetTeam() )
						ability:ApplyDataDrivenModifier(caster, pokemonAvatar, "summoning_sickness", {})
					end
				end)
		else
			print("This pokemon does not have the will to fight.")
		end
	end
end