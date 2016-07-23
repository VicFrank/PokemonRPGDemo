//code taken from dotacraft https://github.com/MNoya/DotaCraft/blob/98a4fc34212c7afd2b46769f4fcd317d681c23e3/content/dota_addons/dotacraft/panorama/scripts/unit_selection.js

"use strict";

function NewSelection ( args ) {
	var entIndex = args.ent_index;
	GameUI.SelectUnit(entIndex, false);
}

function UnitSelected ( ) {
	var playerID = Game.GetLocalPlayerInfo().player_id;
	var queryUnit = Players.GetQueryUnit(playerID);
	var ability = Entities.GetAbility( queryUnit, 0 );
	var abilityName = Abilities.GetAbilityName( ability );

	//$.Msg( );

	if(abilityName == "npc_dialogue"){
		GameEvents.SendCustomGameEventToServer( "talkable_npc_selected", { "player_id" : Game.GetLocalPlayerInfo().player_id, "unit_entindex" : queryUnit } );
	}
}


(function () {
	GameEvents.Subscribe( "new_selection", NewSelection);

	//dota events
	GameEvents.Subscribe( "dota_player_update_query_unit", UnitSelected);
})();