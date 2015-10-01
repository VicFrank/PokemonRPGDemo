-- This is the entry-point to your game mode and should be used primarily to precache models/particles/sounds/etc

require('internal/util')
require('gamemode')

function Precache( context )
--[[
  This function is used to precache resources/units/items/abilities that will be needed
  for sure in your game and that will not be precached by hero selection.  When a hero
  is selected from the hero selection screen, the game will precache that hero's assets,
  any equipped cosmetics, and perform the data-driven precaching defined in that hero's
  precache{} block, as well as the precache{} block for any equipped abilities.

  See GameMode:PostLoadPrecache() in gamemode.lua for more information
  ]]

  DebugPrint("[BAREBONES] Performing pre-load precache")

  PrecacheUnitByNameSync("bulbasaur", context)
  PrecacheUnitByNameSync("ivysaur", context)
  PrecacheUnitByNameSync("venusaur", context)
  PrecacheUnitByNameSync("squirtle", context)
  PrecacheUnitByNameSync("wartortle", context)
  PrecacheUnitByNameSync("blastoise", context)
  
  PrecacheItemByNameSync("item_poke_ball", context)
  PrecacheItemByNameSync("tackle", context)
  PrecacheItemByNameSync("tail_whip", context)
  PrecacheItemByNameSync("withdraw", context)
  PrecacheItemByNameSync("bubble", context)
  PrecacheItemByNameSync("bite", context)
  PrecacheItemByNameSync("growl", context)
  PrecacheItemByNameSync("roar", context)
  PrecacheItemByNameSync("leech_seed", context)
  PrecacheItemByNameSync("razor_leaf", context)
  PrecacheItemByNameSync("ember", context)
  PrecacheItemByNameSync("dragon_rage", context)
  PrecacheItemByNameSync("poison_powder", context)
  PrecacheItemByNameSync("sleep_powder", context)
  PrecacheItemByNameSync("smokescreen", context)
  PrecacheItemByNameSync("scratch", context)
  PrecacheItemByNameSync("scary_face", context)
  PrecacheItemByNameSync("rapid_spin", context)
  PrecacheItemByNameSync("take_down", context)
  PrecacheItemByNameSync("vine_whip", context)
  PrecacheItemByNameSync("water_pulse", context)
  PrecacheItemByNameSync("double_edge", context)
  PrecacheItemByNameSync("agility", context)
  PrecacheItemByNameSync("crunch", context)
  PrecacheItemByNameSync("protect", context)
  PrecacheItemByNameSync("gust", context)
  PrecacheItemByNameSync("quick_attack", context)
  PrecacheItemByNameSync("sand_attack", context)
  PrecacheItemByNameSync("focus_energy", context)
  PrecacheItemByNameSync("hyper_fang", context)
  PrecacheItemByNameSync("super_fang", context)
  PrecacheItemByNameSync("roost", context)
  PrecacheItemByNameSync("iron_defense", context)
  PrecacheItemByNameSync("fire_fang", context)
  PrecacheItemByNameSync("ice_fang", context)
  PrecacheItemByNameSync("thunder_fang", context)
  PrecacheItemByNameSync("slash", context)
  PrecacheItemByNameSync("growth", context)
  PrecacheItemByNameSync("synthesis", context)
  
end

-- Create the game mode when we activate
function Activate()
  GameRules.GameMode = GameMode()
  GameRules.GameMode:InitGameMode()
end