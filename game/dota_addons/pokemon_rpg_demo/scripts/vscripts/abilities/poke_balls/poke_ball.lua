function Activate(keys)
	local caster = keys.caster
	local ability = keys.ability
	local currentAvatar = caster.pokemonAvatar
	local currentPokemon
	if currentAvatar ~= nil then
		currentPokemon = currentAvatar.pokemon
	end
	local pokemon = ability.pokemon
	local playerID = caster:GetPlayerID()
	
	--check the trainer's current pokemon
	--if it's the pokemon associated with this ball, return the pokemon
	if currentPokemon == pokemon then
		if caster.state == "Battle" then
			Notifications:DisplayError(playerID, "#dota_hud_error_unit_command_restricted")
		elseif caster.state == "PostBattle" then
			--you shouldn't be in a position where you CAN withdraw during PostBattle
			print("ERROR: Attempting to Withdraw during PostBattle. PokemonAvatar shouldn't even exist in this state. Something has gone terribly wrong.")
		else
			PokeHelper:Withdraw( caster )
		end
	--if there is no pokemon out, you're not in battle, throw an error
	elseif currentPokemon == nil then
		print("You can only send out pokemon while in battle")
		Notifications:DisplayError(playerID, "#dota_hud_error_unit_command_restricted")
	--otherwise, withdraw the current pokemon, then send this pokemon out in its place
	else
		if pokemon:GetCurrentHP() > 0 then
			local position = currentAvatar:GetAbsOrigin()
			ability:ApplyDataDrivenModifier(caster, currentAvatar, "summoning_sickness", {})
			--after 1 second, withdraw the pokemon and send out the next one
			Timers:CreateTimer(1.5,
				function()
					--make sure the pokemon hasn't fainted by the time we got here
					if currentAvatar == caster.pokemonAvatar then
						PokeHelper:Withdraw( caster )
						local pokemonAvatar = PokeHelper:CreatePokemonAtPosition( pokemon, position, caster, caster:GetTeam() )
						Selection:NewSelection( pokemonAvatar )
						ability:ApplyDataDrivenModifier(caster, pokemonAvatar, "summoning_sickness", {})
					end
				end)
		else
			print("The Pokemon is too weak to fight!")
			Notifications:DisplayError(playerID, "#dota_hud_error_unit_command_restricted")
		end
	end
end