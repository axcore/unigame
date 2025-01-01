---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- tools_wear.lua
--      Handle tool wear
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

-- (From sickles/api.lua)
local repair_warning = unilib.constant.max_tool_wear * 0.9   -- Original factor was 0.917...

---------------------------------------------------------------------------------------------------
-- Handle tool wear
---------------------------------------------------------------------------------------------------

function unilib.tools._after_use(itemstack, user, node, digparams)

    -- Adapted from toolranks/init.lua

    if not unilib.utils.is_creative(user:get_player_name()) then

        local itemdef = itemstack:get_definition()
        if unilib.setting.tool_warn_break_flag and
                digparams.wear > 0 and
                itemstack:get_wear() > repair_warning then

            core.chat_send_player(user:get_player_name(), S("Your tool is about to break!"))
            core.sound_play("unilib_tool_breaks", {to_player = pname, gain = 2.0})

        end

        itemstack:add_wear(digparams.wear)

    end

    return itemstack

end
