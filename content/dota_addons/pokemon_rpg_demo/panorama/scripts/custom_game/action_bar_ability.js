"use strict";

var m_Ability = -1;

function SetAbility( ability )
{
	m_Ability = ability;
	
	var canUpgradeRet = Abilities.CanAbilityBeUpgraded( m_Ability );
	var canUpgrade = ( canUpgradeRet == AbilityLearnResult_t.ABILITY_CAN_BE_UPGRADED );
	
	$.GetContextPanel().SetHasClass( "no_ability", ( ability == -1 ) );

	UpdateAbility();
}

function UpdateAbility()
{
	var abilityButton = $( "#AbilityButton" );
	var abilityName = Abilities.GetAbilityName( m_Ability );

	$.GetContextPanel().SetHasClass( "is_passive", Abilities.IsPassive(m_Ability) );

	abilityButton.enabled = true;
	
	$( "#AbilityImage" ).abilityname = abilityName;
	$( "#AbilityImage" ).contextEntityIndex = m_Ability;
}

function AbilityShowTooltip()
{
	var abilityButton = $( "#AbilityButton" );
	var abilityName = Abilities.GetAbilityName( m_Ability );
	// If you don't have an entity, you can still show a tooltip that doesn't account for the entity
	$.DispatchEvent( "DOTAShowAbilityTooltip", abilityButton, abilityName );
}

function AbilityHideTooltip()
{
	var abilityButton = $( "#AbilityButton" );
	$.DispatchEvent( "DOTAHideAbilityTooltip", abilityButton );
}


function DeleteAbility()
{
	var abilityButton = $( "#AbilityButton" );
	//when the ability is selected
	var abilityName = Abilities.GetAbilityName( m_Ability );
	GameEvents.SendCustomGameEventToServer( "delete_ability", { "player_id" : Game.GetLocalPlayerInfo().player_id, "ability_to_delete" : abilityName } );
}

(function()
{
	$.GetContextPanel().SetAbility = SetAbility;
})();
