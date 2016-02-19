//code taken from dotacraft https://github.com/MNoya/DotaCraft/blob/98a4fc34212c7afd2b46769f4fcd317d681c23e3/content/dota_addons/dotacraft/panorama/scripts/unit_selection.js

"use strict";

function NewSelection ( args ) {
	var entIndex = args.ent_index;
	GameUI.SelectUnit(entIndex, false);
}

(function () {
	GameEvents.Subscribe( "new_selection", NewSelection);
})();