NOTIFICATIONS_VERSION = "0.88"

--[[
  Based on the Panorama Notifications Library by BMD
]]

if Notifications == nil then
  Notifications = class({})
end

function Notifications:RPGTextBox(player, table)
  if type(player) == "number" then
    player = PlayerResource:GetPlayer(player)
  end

  if table.abilityList ~= nil then
    CustomGameEventManager:Send_ServerToPlayer(player, "rpg_textbox", {text=table.text, duration=table.duration, buttons=table.buttons, code=table.code, dialogueTree=table.dialogueTree, abilityList=table.abilityList} )
  else
	CustomGameEventManager:Send_ServerToPlayer(player, "rpg_textbox", {text=table.text, duration=table.duration, buttons=table.buttons, code=table.code, dialogueTree=table.dialogueTree} )
  end
end