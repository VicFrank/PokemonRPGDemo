"use strict";

var party = {name1:"",name2:"",name3:"",name4:"",name5:"",name6:"",
			health1:"",health2:"",health3:"",health4:"",health5:"",health6:"",
			level1:"",level2:"",level3:"",level4:"",level5:"",level6:"",
			maxHealth1:"",maxHealth2:"",maxHealth3:"",maxHealth4:"",maxHealth5:"",maxHealth6:""};

function CreatePokemon ( msg ) {
	UpdateStats( msg);
	ShowStats( );
}

function WithdrawPokemon ( msg ) {
	HideStats( );
}

function UpdateStats( msg ){
	var parentPanel = $('#StatsBox');
	var values = parentPanel.FindChildInLayoutFile( "StatsValues" );
	
	var level = values.FindChildInLayoutFile( "lvl" );
	var health = values.FindChildInLayoutFile( "hp" );
	var attack = values.FindChildInLayoutFile( "atk" );
	var defense = values.FindChildInLayoutFile( "def" );
	var spAttack = values.FindChildInLayoutFile( "satk" );
	var spDefense = values.FindChildInLayoutFile( "sdef" );
	var speed = values.FindChildInLayoutFile( "spd" );
	var experience = values.FindChildInLayoutFile( "xp" );
	var toNextLevel = values.FindChildInLayoutFile( "nextLevel" );
	
	level.text = "Lv. " + msg.level;
	health.text = msg.health + "/" + msg.maxHealth;
	attack.text = msg.attack;
	defense.text = msg.defense;
	spAttack.text = msg.spAttack;
	spDefense.text = msg.spDefense;
	speed.text = msg.speed;
	experience.text = msg.experience;
	toNextLevel.text = msg.toNextLevel;
	
	var labels = parentPanel.FindChildInLayoutFile( "StatsLabels" );
	var name = labels.FindChildInLayoutFile( "name" );
	
	name.text = msg.name;
}

function UpdateHealth( msg ){
	var parentPanel = $('#StatsBox');
	var values = parentPanel.FindChildInLayoutFile( "StatsValues" );
	var health = values.FindChildInLayoutFile( "hp" );
	
	health.text = msg.health + "/" + msg.maxHealth;
	UpdatePartyPanel( );
}

function UpdatePartyPanelData( msg ){
	party.name1 = msg.name1;
	party.name2 = msg.name2;
	party.name3 = msg.name3;
	party.name4 = msg.name4;
	party.name5 = msg.name5;
	party.name6 = msg.name6;

	party.health1 = msg.health1;
	party.health2 = msg.health2;
	party.health3 = msg.health3;
	party.health4 = msg.health4;
	party.health5 = msg.health5;
	party.health6 = msg.health6;
	
	party.maxHealth1 = msg.maxHealth1;
	party.maxHealth2 = msg.maxHealth2;
	party.maxHealth3 = msg.maxHealth3;
	party.maxHealth4 = msg.maxHealth4;
	party.maxHealth5 = msg.maxHealth5;
	party.maxHealth6 = msg.maxHealth6;

	party.level1 = msg.level1;
	party.level2 = msg.level2;
	party.level3 = msg.level3;
	party.level4 = msg.level4;
	party.level5 = msg.level5;
	party.level6 = msg.level6;
}

function UpdatePartyPanel( ){
	//ask the server for the updated pokemon values
	//this should just be a nettable
	GameEvents.SendCustomGameEventToServer( "update_party_panel_request", { "player_id" : Game.GetLocalPlayerInfo().player_id} );
	
	//wait a moment for a response
	$.Schedule(.1, function(){
		var parentPanel = $('#StatsBox');
		var names = parentPanel.FindChildInLayoutFile( "PartyPokemonLeft" );
		var values = parentPanel.FindChildInLayoutFile( "PartyPokemonRight" );
		
		var name1 = names.FindChildInLayoutFile( "partyName1" );
		var name2 = names.FindChildInLayoutFile( "partyName2" );
		var name3 = names.FindChildInLayoutFile( "partyName3" );
		var name4 = names.FindChildInLayoutFile( "partyName4" );
		var name5 = names.FindChildInLayoutFile( "partyName5" );
		var name6 = names.FindChildInLayoutFile( "partyName6" );
		
		var expAndHealth1 = values.FindChildInLayoutFile( "expAndHealth1" );
		var expAndHealth2 = values.FindChildInLayoutFile( "expAndHealth2" );
		var expAndHealth3 = values.FindChildInLayoutFile( "expAndHealth3" );
		var expAndHealth4 = values.FindChildInLayoutFile( "expAndHealth4" );
		var expAndHealth5 = values.FindChildInLayoutFile( "expAndHealth5" );
		var expAndHealth6 = values.FindChildInLayoutFile( "expAndHealth6" );
		
		var health1 = values.FindChildInLayoutFile( "partyHealth1" );
		var level1  = expAndHealth1.FindChildInLayoutFile( "level" );
		var health2 = values.FindChildInLayoutFile( "partyHealth2" );
		var level2  = expAndHealth2.FindChildInLayoutFile( "level" );
		var health3 = values.FindChildInLayoutFile( "partyHealth3" );
		var level3  = expAndHealth3.FindChildInLayoutFile( "level" );
		var health4 = values.FindChildInLayoutFile( "partyHealth4" );
		var level4  = expAndHealth4.FindChildInLayoutFile( "level" );
		var health5 = values.FindChildInLayoutFile( "partyHealth5" );
		var level5  = expAndHealth5.FindChildInLayoutFile( "level" );
		var health6 = values.FindChildInLayoutFile( "partyHealth6" );
		var level6  = expAndHealth6.FindChildInLayoutFile( "level" );
		
		var healthBar1 = expAndHealth1.FindChildInLayoutFile( "healthBar" );
		var healthBar2 = expAndHealth2.FindChildInLayoutFile( "healthBar" );
		var healthBar3 = expAndHealth3.FindChildInLayoutFile( "healthBar" );
		var healthBar4 = expAndHealth4.FindChildInLayoutFile( "healthBar" );
		var healthBar5 = expAndHealth5.FindChildInLayoutFile( "healthBar" );
		var healthBar6 = expAndHealth6.FindChildInLayoutFile( "healthBar" );
		
		name1.text = party.name1;
		name2.text = party.name2;
		name3.text = party.name3;
		name4.text = party.name4;
		name5.text = party.name5;
		name6.text = party.name6;
		
		if(party.name1 != ""){
			health1.text = party.health1 + "/" + party.maxHealth1;
			healthBar1.style.width = 100*party.health1/party.maxHealth1 + "px";
			level1.text = "Lv." + party.level1;
		} else{
			healthBar1.style.width = 0;
			health1.text = "";
			level1.text = "";
		}
		if(party.name2 != ""){
			health2.text = party.health2 + "/" + party.maxHealth2;
			healthBar2.style.width = 100*party.health2/party.maxHealth2 + "px";
			level2.text = "Lv." + party.level2;
		} else{
			health2.text = "";
			level2.text = "";
			healthBar2.style.width = 0 + "px";
		}
		if(party.name3 != ""){
			health3.text = party.health3 + "/" + party.maxHealth3;
			level3.text = "Lv." + party.level3;
			healthBar3.style.width = 100*party.health3/party.maxHealth3 + "px";
		} else{
			health3.text = "";
			level3.text = "";
			healthBar3.style.width = 0 + "px";
		}
		if(party.name4 != ""){
			health4.text = party.health4 + "/" + party.maxHealth4;
			level4.text = "Lv." + party.level4;
			healthBar4.style.width = 100*party.health4/party.maxHealth4 + "px";
		} else{
			health4.text = "";
			level4.text = "";
			healthBar4.style.width = 0 + "px";
		}
		if(party.name5 != ""){
			health5.text = party.health5 + "/" + party.maxHealth5;
			level5.text = "Lv." + party.level5;
			healthBar5.style.width = 100*party.health5/party.maxHealth5 + "px";
		} else{
			health5.text = "";
			level5.text = "";
			healthBar5.style.width = 0 + "px";
		}
		if(party.name6 != ""){
			health6.text = party.health6 + "/" + party.maxHealth6;
			level6.text = "Lv." + party.level6;
			healthBar6.style.width = 100*party.health6/party.maxHealth6 + "px";
		} else{
			health6.text = "";
			level6.text = "";
			healthBar6.style.width = 0 + "px";
		}
	});
}

function ShowStats( ){
	var parentPanel = $('#StatsBox');
	var labels = parentPanel.FindChildInLayoutFile( "StatsLabels" );
	var values = parentPanel.FindChildInLayoutFile( "StatsValues" );
	labels.visible = true;
	values.visible = true;
	
	HideParty( );
}

function HideStats( ){
	var parentPanel = $('#StatsBox');
	var labels = parentPanel.FindChildInLayoutFile( "StatsLabels" );
	var values = parentPanel.FindChildInLayoutFile( "StatsValues" );
	labels.visible = false;
	values.visible = false;
}

function ShowParty( ){
	var parentPanel = $('#StatsBox');
	var names = parentPanel.FindChildInLayoutFile( "PartyPokemonLeft" );
	var values = parentPanel.FindChildInLayoutFile( "PartyPokemonRight" );
	names.visible = true;
	values.visible = true;
	
	UpdatePartyPanel( );
	HideStats( );
}

function HideParty( ){
	var parentPanel = $('#StatsBox');
	var names = parentPanel.FindChildInLayoutFile( "PartyPokemonLeft" );
	var values = parentPanel.FindChildInLayoutFile( "PartyPokemonRight" );
	names.visible = false;
	values.visible = false;
}

(function ( ) {
	GameEvents.Subscribe( "create_pokemon", CreatePokemon );
	GameEvents.Subscribe( "withdraw_pokemon", WithdrawPokemon );
	GameEvents.Subscribe( "update_health", UpdateHealth );
	GameEvents.Subscribe( "battle_ended", ShowParty );
	GameEvents.Subscribe( "dota_inventory_changed", UpdatePartyPanel );
	GameEvents.Subscribe( "dota_inventory_item_changed", UpdatePartyPanel );
	GameEvents.Subscribe( "update_party_panel_response", UpdatePartyPanelData );

	HideStats( );
})();