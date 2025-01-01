---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- wield_light_bu.lua
--      Backups for shared functions in ../lib/effects/wield_light/wield_light_base.lua
---------------------------------------------------------------------------------------------------

local msg = "Shared function unavailable because \"wield_light\" effects disabled"

---------------------------------------------------------------------------------------------------
-- Shared function backups
---------------------------------------------------------------------------------------------------

function unilib.wield_light.register_lightable_node(...)
    unilib.utils.show_warning(msg, "unilib.wield_light.register_lightable_node")
end

function unilib.wield_light.register_shining_item(...)
    unilib.utils.show_warning(msg, "unilib.wield_light.register_shining_item")
end
