function PokemonCenterHeal( trigger )
	Notifications:RPGTextBox(trigger.activator:GetPlayerID(), {text="We've restored your Pokemon to full health!", duration=3, buttons=false, code=200, dialogueTree=""})
	
	for i=0,5 do
		if trigger.activator:GetItemInSlot(i) ~= nil then
			local item = trigger.activator:GetItemInSlot(i)
			local pokemon = item.pokemon
			if pokemon ~= nil then
				pokemon:ClearStatus()
				pokemon:SetCurrentHP(pokemon:GetMaxHP())
			end
		end
	end
	
	CustomGameEventManager:Send_ServerToPlayer(trigger.activator:GetPlayerOwner(), "update_health", {} )
end

function Teleport( trigger, location_entity_name )
	local teleportLocation = Entities:FindByName( nil, location_entity_name ):GetAbsOrigin()
	FindClearSpaceForUnit(trigger.activator, teleportLocation, false)
	trigger.activator:Stop()
	PlayerResource:SetCameraTarget(trigger.activator:GetPlayerID(), trigger.activator)
	Timers:CreateTimer(0.1, function()
		PlayerResource:SetCameraTarget(trigger.activator:GetPlayerID(), nil)
	end)
end

-----------------------------------------------------------
--	Teleport Triggers:
-----------------------------------------------------------
function Teleport1( trigger )
	Teleport( trigger, "viridian_forest_start_teleport" )
	ViridianForest( trigger )
end

function Teleport2( trigger )
	Teleport( trigger, "route_2_end_teleport" )
	Route2( trigger )
end

function Teleport3( trigger )
	Teleport( trigger, "route_2_end_north_teleport" )
	Route2( trigger )
end

function Teleport4( trigger )
	Teleport( trigger, "viridian_forest_end_teleport" )
	ViridianForest( trigger )
end

function TeleportPokemonCenter( trigger )
	Teleport( trigger, "pokemon_center_teleport" )
end

function ExitPokemonCenter( trigger )
	local trainer = trigger.activator
	
	if PokeHelper:GetNextUseablePokemon( trainer ) ~= nil then
		if trainer.respawn == "pallet_town" then
			Teleport( trigger, "pallet_town_teleport" )
			PalletTown( trigger )
		elseif trainer.respawn == "viridian_city" then
			Teleport( trigger, "viridian_city_teleport" )
			ViridianCity( trigger )
		elseif trainer.respawn == "pewter_city" then
			Teleport( trigger, "pewter_city_teleport" )
			PewterCity( trigger )
		else
			print("Not a Valid Respawn: " .. trainer.respawn)
			Teleport( trigger, "pallet_town_teleport" )
		end
	else 
		Notifications:RPGTextBox(trainer:GetPlayerID(), {text="Heal your Pokemon before you leave.", duration=3, buttons=false, code=200, dialogueTree=""})
	end
end

-----------------------------------------------------------
--	Location Triggers:
-----------------------------------------------------------

function PalletTown( trigger )
	local trainer = trigger.activator
	
	if trainer.location ~= "pallet_town" then
		Notifications:RPGTextBox(trainer:GetPlayerID(), {text="Pallet Town", duration=1, buttons=false, code=0, dialogueTree=""})
		trainer.location = "pallet_town"
		trainer.respawn = "pallet_town"
	end
end

function Route1( trigger )
	local trainer = trigger.activator
	
	if trainer.location ~= "route_1" then
		Notifications:RPGTextBox(trainer:GetPlayerID(), {text="Route 1", duration=1, buttons=false, code=0, dialogueTree=""})
		trainer.location = "route_1"
	end
end

function ViridianCity( trigger )
	local trainer = trigger.activator
	
	if trainer.location ~= "viridian_city" then
		Notifications:RPGTextBox(trainer:GetPlayerID(), {text="Viridian City", duration=1, buttons=false, code=0, dialogueTree=""})
		trainer.location = "viridian_city"
		trainer.respawn = "viridian_city"
	end
end

function ViridianForest( trigger )
	local trainer = trigger.activator
	
	if trainer.location ~= "viridian_forest" then
		Notifications:RPGTextBox(trainer:GetPlayerID(), {text="Viridian Forest", duration=1, buttons=false, code=0, dialogueTree=""})
		trainer.location = "viridian_forest"
	end
end

function Route2( trigger )
	local trainer = trigger.activator
	
	if trainer.location ~= "route_2" then
		Notifications:RPGTextBox(trainer:GetPlayerID(), {text="Route 2", duration=1, buttons=false, code=0, dialogueTree=""})
		trainer.location = "route_2"
	end
end

function Route22( trigger )
	local trainer = trigger.activator
	
	if trainer.location ~= "route_22" then
		Notifications:RPGTextBox(trainer:GetPlayerID(), {text="Route 22", duration=1, buttons=false, code=0, dialogueTree=""})
		trainer.location = "route_22"
	end
end

function PewterCity( trigger )
	local trainer = trigger.activator
	
	if trainer.location ~= "pewter_city" then
		Notifications:RPGTextBox(trainer:GetPlayerID(), {text="Pewter City", duration=1, buttons=false, code=0, dialogueTree=""})
		trainer.location = "pewter_city"
		trainer.respawn = "pewter_city"
	end
end