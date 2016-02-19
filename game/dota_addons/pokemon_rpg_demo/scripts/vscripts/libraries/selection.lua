--code from Dotacraft https://github.com/MNoya/DotaCraft/blob/98a4fc34212c7afd2b46769f4fcd317d681c23e3/game/dota_addons/dotacraft/scripts/vscripts/mechanics/selection.lua
if Selection == nil then
  Selection = class({})
end

function Selection:NewSelection( unit )
    local player = unit:GetPlayerOwner()
    local ent_index = unit:GetEntityIndex()
    CustomGameEventManager:Send_ServerToPlayer(player, "new_selection", { ent_index = unit:GetEntityIndex() })
end