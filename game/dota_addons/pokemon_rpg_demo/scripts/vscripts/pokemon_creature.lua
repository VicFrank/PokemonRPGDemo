wild_pokemon_ai = require( "ai/ai_wild_pokemon" )
trainer_pokemon_ai = require( "ai/trainer_pokemon_ai" )

function Spawn( entityKeyValues )
	Timers:CreateTimer(.01,
    function()
		local pokemon = thisEntity.pokemon
		if pokemon == nil then 
			return
		end
		if pokemon:IsWild() then
			wild_pokemon_ai.Init( thisEntity )
		elseif thisEntity:GetTeam() == DOTA_TEAM_NEUTRALS then
			trainer_pokemon_ai.Init( thisEntity )
		end
    end)
end