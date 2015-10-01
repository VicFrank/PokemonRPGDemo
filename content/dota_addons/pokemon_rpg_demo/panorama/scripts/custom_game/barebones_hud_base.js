var currentTextBox;
var lastTextBox;
var buttonSelection = "";

var m_AbilityPanels = []; // created up to a high-water mark, but reused when selection changes

function AddTextBox(msg) {
	var thisTextBox = {text:msg.text, duration:msg.duration, buttons:msg.buttons, code:msg.code, dialogueTree:msg.dialogueTree, nextTextBox:null, abilityList:null}
	if(msg.abilityList != null)
		thisTextBox.abilityList = msg.abilityList;
	$.Msg ( thisTextBox.text );
	//add this text box to the queue
	//if there is currently no text box, make this the current textbox and activate it
	if (currentTextBox == null){
		currentTextBox = thisTextBox;
		lastTextBox = thisTextBox;
		UpdateTextBox(thisTextBox);
		ShowTextBox();
	}
	else{
		//otherwise, add this text box to the queue
		lastTextBox.nextTextBox = thisTextBox;
		lastTextBox = thisTextBox;
	}
}

function UpdateTextBox(msg) {
	var parentPanel = $('#RPGBox');
	var TextPanel = parentPanel.FindChildInLayoutFile( "DialogueText" );
	
	TextPanel.text = msg.text;
	
	if(msg.buttons)
		ShowButtons();
	else
		HideButtons();
	
	//some codes have a unique state, check docs for information
	if(msg.code == 104)
		ShowAbilityPanel();
	else
		HideAbilityPanel();
	//duration of -1 means panel does not change after a period of time
	if(msg.duration != -1){
		$.Schedule(msg.duration, function(){
			//if the current msg hasn't been resolved already
			if(currentTextBox == msg){
				GoToNextTextBox();
			}
		});
	}
}

function GoToNextTextBox(){
	var nextNode = currentTextBox.nextTextBox;
	if(nextNode == null)
		HideTextBox();
	else if(nextNode.dialogueTree != buttonSelection){
		//"" to "" if there is no dialogue tree "yes" to "yes" or "no" to "no" if there is
		//if the button selection does not match the current dialogue tree, then we skip this branch of the tree
		currentTextBox = nextNode;
		GoToNextTextBox();
		//go back to the default "" after we've exhausted all the yes/no branch
		if(nextNode.dialogueTree == "")
			buttonSelection = "";
	}
	else{
		currentTextBox = nextNode;
		UpdateTextBox(nextNode);
	}
}

function ButtonPressed( button ){
	//button is 'yes' or 'no'
	buttonSelection = button;
	GoToNextTextBox();
}

function ShowTextBox( ){
	var parentPanel = $('#RPGBox');
	parentPanel.visible = true;
}

function HideTextBox( ){
	var parentPanel = $('#RPGBox');
	parentPanel.visible= false;
	//this should only be called when the queue is empty, so clear the nodes as well
	currentTextBox = null;
	lastTextBox = null;
}

function ShowButtons( ){
	var parentPanel = $('#RPGBox');
	var YesButton = parentPanel.FindChildInLayoutFile( "ButtonYes" );
	var NoButton = parentPanel.FindChildInLayoutFile( "ButtonNo" );
	YesButton.visible = true;
	NoButton.visible = true;
}

function HideButtons( ){
	var parentPanel = $('#RPGBox');
	var YesButton = parentPanel.FindChildInLayoutFile( "ButtonYes" );
	var NoButton = parentPanel.FindChildInLayoutFile( "ButtonNo" );
	YesButton.visible = false;
	NoButton.visible = false;
}

function ShowAbilityPanel( ){
	var abilityListPanel = $( "#ability_list" );
	abilityListPanel.visible = true;
	UpdateAbilityPanel();
}

function HideAbilityPanel( ){
	var abilityListPanel = $( "#ability_list" );
	abilityListPanel.visible = false;
}

function UpdateAbilityPanel( ){
	var abilityListPanel = $( "#ability_list" );
	if ( !abilityListPanel )
		return;

	var abilityList = currentTextBox.abilityList;

	// update all the panels
	var nUsedPanels = 0;
	for ( var i = 0; i < abilityList.length; ++i )
	{
		var ability = abilityList[i];
		
		if ( ability == -1 )
			continue;

		if ( !Abilities.IsDisplayedAbility(ability) )
			continue;
		
		if ( nUsedPanels >= m_AbilityPanels.length )
		{
			// create a new panel
			var abilityPanel = $.CreatePanel( "Panel", abilityListPanel, "" );
			abilityPanel.BLoadLayout( "file://{resources}/layout/custom_game/action_bar_ability.xml", false, false );
			m_AbilityPanels.push( abilityPanel );
		}

		// update the panel for the current unit / ability
		var abilityPanel = m_AbilityPanels[ nUsedPanels ];
		abilityPanel.data().SetAbility( ability );
		
		nUsedPanels++;
	}

	// clear any remaining panels
	for ( var i = nUsedPanels; i < m_AbilityPanels.length; ++i )
	{
		var abilityPanel = m_AbilityPanels[ i ];
		abilityPanel.data().SetAbility( -1, -1 );
	}
}
 
function InitializePanels(){
	HideTextBox();
	HideButtons();
	HideAbilityPanel();
}

//ShowAbilityPanel();
//HideButtons();

(function () {
  GameEvents.Subscribe( "rpg_textbox", AddTextBox );
  $.GetContextPanel().data().GoToNextTextBox = GoToNextTextBox;
  
  InitializePanels(); // initial update
})();


