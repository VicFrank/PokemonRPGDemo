wild_pokemon_ai = require( "ai/ai_wild_pokemon" )
function Spawn( entityKeyValues )
	Timers:CreateTimer(.01,
    function()
		local pokemon = thisEntity.pokemon
		if pokemon:IsWild() then
			wild_pokemon_ai.Init( thisEntity )
		end
    end)
end