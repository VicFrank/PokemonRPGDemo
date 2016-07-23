function PokemonCenterHeal( trigger )
	Notifications:RPGTextBox(trigger.activator:GetPlayerID(), {text="We've restored your Pokemon to full health!", duration=3, buttons=false, code=200, dialogueTree=""})
	PokeHelper:PokemonCenterHeal( trigger.activator )
end

function Teleport( trainer, location_entity_name )
	local teleportLocation = Entities:FindByName( nil, location_entity_name ):GetAbsOrigin()

	FindClearSpaceForUnit(trainer, teleportLocation, false)
	trainer:Stop()

	PlayerResource:SetCameraTarget(trainer:GetPlayerID(), trainer)
	Timers:CreateTimer(0.1, function()
		PlayerResource:SetCameraTarget(trainer:GetPlayerID(), nil)
	end)
end

function NotAvailable( trigger )
	local trainer = trigger.activator
	
	Notifications:RPGTextBox(trigger.activator:GetPlayerID(), {text="This area is not available on this map.", duration=2, buttons=false, code=100, dialogueTree=""})
end

-----------------------------------------------------------
--	Teleport Triggers:
--  Because we can't pass function arguments (that I know of) from triggers, we need
--  to create a seperate function for every potential trigger. That means a function
--  for every time you enter a new location, and a function for every teleport.
--
--  Probably these functions could be renamed to something more clear (like
--	TeleportViridianForestStart) but that would involve updating every teleport trigger
--  entity in hammer. Still something that should be done.
-----------------------------------------------------------
function Teleport1( trigger )
	Teleport( trigger.activator, "viridian_forest_start_teleport" )
	ViridianForest( trigger )
end

function Teleport2( trigger )
	Teleport( trigger.activator, "route_2_end_teleport" )
	Route2( trigger )
end

function Teleport3( trigger )
	Teleport( trigger.activator, "route_2_end_north_teleport" )
	Route2( trigger )
end

function Teleport4( trigger )
	Teleport( trigger.activator, "viridian_forest_end_teleport" )
	ViridianForest( trigger )
end

function Teleport5( trigger )
	Teleport( trigger.activator, "route_22_entrance_teleport" )
	Route22( trigger )
end

function Teleport6( trigger )
	Teleport( trigger.activator, "viridian_city_west_teleport" )
	ViridianCity( trigger )
end

function Teleport7( trigger )
	Teleport( trigger.activator, "cerulean_west_teleport" )
	CeruleanCity( trigger )
end

function Teleport8( trigger )
	Teleport( trigger.activator, "route_4_east_teleport" )
	Route4( trigger )
end

function Teleport9( trigger )
	Teleport( trigger.activator, "mt_moon_east_teleport" )
	MtMoon( trigger )
end

function Teleport10( trigger )
	Teleport( trigger.activator, "mt_moon_west_teleport" )
	MtMoon( trigger )
end

function Teleport11( trigger )
	Teleport( trigger.activator, "route_3_teleport" )
	Route3( trigger )
end

function Teleport12( trigger )
	Teleport( trigger.activator, "route_4_west_teleport" )
	Route4( trigger )
end

function Teleport13( trigger )
	Teleport( trigger.activator, "mt_moon_b2_teleport" )
	MtMoon( trigger )
end

function Teleport14( trigger )
	Teleport( trigger.activator, "mt_moon_b1_teleport" )
	MtMoon( trigger )
end

function Teleport15( trigger )
	Teleport( trigger.activator, "pewter_gym_teleport" )
end

function Teleport16( trigger )
	Teleport( trigger.activator, "route_24_teleport" )
	Route24( trigger )
end

function Teleport17( trigger )
	Teleport( trigger.activator, "cerulean_north_1_teleport" )
	CeruleanCity( trigger )
end

function Teleport18( trigger )
	Teleport( trigger.activator, "cerulean_north_2_teleport" )
	CeruleanCity( trigger )
end

function Teleport19( trigger )
	Teleport( trigger.activator, "cerulean_gym_teleport" )
	CeruleanCity( trigger )
end

function Teleport20( trigger )
	Teleport( trigger.activator, "route_5_north_teleport1" )
	Route5( trigger )
end

function Teleport21( trigger )
	Teleport( trigger.activator, "route_5_north_teleport2" )
	Route5( trigger )
end

function Teleport22( trigger )
	Teleport( trigger.activator, "cerulean_south_teleport1" )
	CeruleanCity( trigger )
end

function Teleport23( trigger )
	Teleport( trigger.activator, "cerulean_south_teleport2" )
	CeruleanCity( trigger )
end

function Teleport24( trigger )
	Teleport( trigger.activator, "route_6_north_teleport" )
	Route6( trigger )
end

function Teleport25( trigger )
	Teleport( trigger.activator, "route_5_south_teleport" )
	Route5( trigger )
end

function Teleport26( trigger )
	Teleport( trigger.activator, "diglett_cave_south_entrance_teleport" )
	DiglettCave( trigger )
end

function Teleport27( trigger )
	Teleport( trigger.activator, "diglett_cave_south_exit_teleport" )
	VermilionCity( trigger )
end

function Teleport28( trigger )
	Teleport( trigger.activator, "diglett_cave_north_exit_teleport" )
	Route2( trigger )
end

function Teleport29( trigger )
	Teleport( trigger.activator, "diglett_cave_north_entrance_teleport" )
	DiglettCave( trigger )
end

function Teleport30( trigger )
	Teleport( trigger.activator, "route_11_west_teleport" )
	Route11( trigger )
end

function Teleport31( trigger )
	Teleport( trigger.activator, "vermilion_city_east_teleport" )
	VermilionCity( trigger )
end

function Teleport32( trigger )
	Teleport( trigger.activator, "ss_anne_entrance_teleport" )
	SS_Anne1F( trigger )
end

function Teleport33( trigger )
	Teleport( trigger.activator, "vermilion_city_south_teleport" )
	VermilionCity( trigger )
end

function Teleport34( trigger )
	Teleport( trigger.activator, "ss_anne_b1f_teleport" )
	SS_AnneB1F( trigger )
end

function Teleport35( trigger )
	Teleport( trigger.activator, "ss_anne_2f_south_west_teleport" )
	SS_Anne2F( trigger )
end

function Teleport36( trigger )
	Teleport( trigger.activator, "ss_anne_1f_east_teleport" )
	SS_Anne1F( trigger )
end

function Teleport37( trigger )
	Teleport( trigger.activator, "ss_anne_1f_west_teleport" )
	SS_Anne1F( trigger )
end

function Teleport38( trigger )
	Teleport( trigger.activator, "ss_anne_captain_teleport" )
end

function Teleport39( trigger )
	Teleport( trigger.activator, "ss_anne_deck_teleport" )
	SS_Anne3F( trigger )
end

function Teleport40( trigger )
	Teleport( trigger.activator, "ss_anne_2f_north_west_teleport" )
	SS_Anne2F( trigger )
end

function Teleport41( trigger )
	Teleport( trigger.activator, "ss_anne_2f_east_teleport" )
	SS_Anne2F( trigger )
end

function Teleport42( trigger )
	Teleport( trigger.activator, "vermilion_city_gym_teleport" )
end

function TeleportPalletTown( trigger )
	Teleport( trigger.activator, "pallet_town_teleport" )
	PalletTown( trigger )
end

function TeleportViridianCity( trigger )
	Teleport( trigger.activator, "viridian_city_teleport" )
	ViridianCity( trigger )
end

function TeleportPewterCity( trigger )
	Teleport( trigger.activator, "pewter_city_teleport" )
	PewterCity( trigger )
end

function TeleportMtMoon( trigger )
	Teleport( trigger.activator, "mt_moon_outside_teleport")
	MtMoon( trigger )
end

function TeleportCeruleanCity( trigger )
	Teleport( trigger.activator, "cerulean_city_teleport" )
	CeruleanCity( trigger )
end

function TeleportVermilionCity( trigger )
	Teleport( trigger.activator, "vermilion_city_teleport" )
	VermilionCity( trigger )
end

function TeleportPokemonCenter( trigger )
	Teleport( trigger.activator, "pokemon_center_teleport" )
end

function ExitPokemonCenter( trigger )
	local trainer = trigger.activator
	
	if PokeHelper:GetNextUseablePokemon( trainer ) ~= nil then
		if trainer.respawn == "pallet_town" then
			TeleportPalletTown( trigger )
		elseif trainer.respawn == "viridian_city" then
			TeleportViridianCity( trigger )
		elseif trainer.respawn == "pewter_city" then
			TeleportPewterCity( trigger )
		elseif trainer.respawn == "cerulean_city" then
			TeleportCeruleanCity( trigger )
		elseif trainer.respawn == "mt_moon" then
			TeleportMtMoon( trigger )
		elseif trainer.respawn == "vermilion_city" then
			TeleportVermilionCity( trigger )
		else
			print("Not a Valid Respawn: " .. trainer.respawn)
			TeleportPalletTown( trigger )
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

function Route3( trigger )
	local trainer = trigger.activator
	
	if trainer.location ~= "route_3" then
		Notifications:RPGTextBox(trainer:GetPlayerID(), {text="Route 3", duration=1, buttons=false, code=0, dialogueTree=""})
		trainer.location = "route_3"
	end
end

function Route4( trigger )
	local trainer = trigger.activator
	
	if trainer.location ~= "route_4" then
		Notifications:RPGTextBox(trainer:GetPlayerID(), {text="Route 4", duration=1, buttons=false, code=0, dialogueTree=""})
		trainer.location = "route_4"
	end
end

function Route5( trigger )
	local trainer = trigger.activator
	
	if trainer.location ~= "route_5" then
		Notifications:RPGTextBox(trainer:GetPlayerID(), {text="Route 5", duration=1, buttons=false, code=0, dialogueTree=""})
		trainer.location = "route_5"
	end
end

function Route6( trigger )
	local trainer = trigger.activator
	
	if trainer.location ~= "route_6" then
		Notifications:RPGTextBox(trainer:GetPlayerID(), {text="Route 6", duration=1, buttons=false, code=0, dialogueTree=""})
		trainer.location = "route_6"
	end
end

function Route11( trigger )
	local trainer = trigger.activator
	
	if trainer.location ~= "route_11" then
		Notifications:RPGTextBox(trainer:GetPlayerID(), {text="Route 11", duration=1, buttons=false, code=0, dialogueTree=""})
		trainer.location = "route_11"
	end
end

function Route22( trigger )
	local trainer = trigger.activator
	
	if trainer.location ~= "route_22" then
		Notifications:RPGTextBox(trainer:GetPlayerID(), {text="Route 22", duration=1, buttons=false, code=0, dialogueTree=""})
		trainer.location = "route_22"
	end
end

function Route24( trigger )
	local trainer = trigger.activator
	
	if trainer.location ~= "route_24" then
		Notifications:RPGTextBox(trainer:GetPlayerID(), {text="Route 24", duration=1, buttons=false, code=0, dialogueTree=""})
		trainer.location = "route_24"
	end
end

function Route25( trigger )
	local trainer = trigger.activator
	
	if trainer.location ~= "route_25" then
		Notifications:RPGTextBox(trainer:GetPlayerID(), {text="Route 25", duration=1, buttons=false, code=0, dialogueTree=""})
		trainer.location = "route_25"
	end
end

function DiglettCave( trigger )
	local trainer = trigger.activator
	
	if trainer.location ~= "diglett_cave" then
		Notifications:RPGTextBox(trainer:GetPlayerID(), {text="Diglett's Cave", duration=1, buttons=false, code=0, dialogueTree=""})
		trainer.location = "diglett_cave"
	end
end

function SS_Anne1F( trigger )
	local trainer = trigger.activator
	Notifications:RPGTextBox(trainer:GetPlayerID(), {text="S.S. Anne 1F", duration=1, buttons=false, code=0, dialogueTree=""})
end

function SS_Anne2F( trigger )
	local trainer = trigger.activator
	Notifications:RPGTextBox(trainer:GetPlayerID(), {text="S.S. Anne 2F", duration=1, buttons=false, code=0, dialogueTree=""})
end

function SS_Anne3F( trigger )
	local trainer = trigger.activator
	Notifications:RPGTextBox(trainer:GetPlayerID(), {text="S.S. Anne Deck", duration=1, buttons=false, code=0, dialogueTree=""})
end

function SS_AnneB1F( trigger )
	local trainer = trigger.activator
	Notifications:RPGTextBox(trainer:GetPlayerID(), {text="S.S. Anne B1F", duration=1, buttons=false, code=0, dialogueTree=""})
end

function MtMoon( trigger )
	local trainer = trigger.activator
	
	if trainer.location ~= "mt_moon" then
		Notifications:RPGTextBox(trainer:GetPlayerID(), {text="Mt. Moon", duration=1, buttons=false, code=0, dialogueTree=""})
		trainer.location = "mt_moon"
		trainer.respawn = "mt_moon"
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

function CeruleanCity( trigger )
	local trainer = trigger.activator
	
	if trainer.location ~= "cerulean_city" then
		Notifications:RPGTextBox(trainer:GetPlayerID(), {text="Cerulean City", duration=1, buttons=false, code=0, dialogueTree=""})
		trainer.location = "cerulean_city"
		trainer.respawn = "cerulean_city"
	end
end

function VermilionCity( trigger )
	local trainer = trigger.activator
	
	if trainer.location ~= "vermilion_city" then
		Notifications:RPGTextBox(trainer:GetPlayerID(), {text="Vermilion City", duration=1, buttons=false, code=0, dialogueTree=""})
		trainer.location = "vermilion_city"
		trainer.respawn = "vermilion_city"
	end
end