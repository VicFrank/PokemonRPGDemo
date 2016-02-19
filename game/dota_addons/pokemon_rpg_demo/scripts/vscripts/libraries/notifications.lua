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

  if table.unit ~= nil then
    CustomGameEventManager:Send_ServerToPlayer(player, "rpg_textbox", {text=table.text, duration=table.duration, buttons=table.buttons, code=table.code, dialogueTree=table.dialogueTree, unit=table.unit} )
  else
	CustomGameEventManager:Send_ServerToPlayer(player, "rpg_textbox", {text=table.text, duration=table.duration, buttons=table.buttons, code=table.code, dialogueTree=table.dialogueTree} )
  end
end

function Notifications:DisplayError(pid, message)
  local player = PlayerResource:GetPlayer(pid)
  if player then
    CustomGameEventManager:Send_ServerToPlayer(player, "cont_create_error_message", {message=message})
  end
end