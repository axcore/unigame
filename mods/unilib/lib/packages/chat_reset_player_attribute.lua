---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.chat_reset_player_attribute = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.chat_reset_player_attribute.init()

    return {
        description = "Chat command /reset_player_attribute",
        notes = "Resets the value of a player attribute",
    }

end

function unilib.pkg.chat_reset_player_attribute.exec()

    core.register_chatcommand("reset_player_attribute", {
        params = "<attribute>",
        description = S("Resets the value of a player attribute"),
        privs = {unilib_admin = true},

        func = function(name, param)

            local player = core.get_player_by_name(name)
            if not player then

                return false, unilib.constant.chat_offline_msg

            elseif not player.get_meta then

                return false, S("Player attribute table not available")

            else

                local param_list = unilib.utils.split_string_by_whitespace(param, true)
                if param_list[1] == nil or param_list[1] == "" then

                    return false,
                            S("You must specify a player attribute (try /show_player_attributes)")

                else

                    -- The function is expecting the "unilib:pattrib_" portion to be stripped off
                    name = unilib.core.name .. ":pattrib_"
                    if string.sub(param_list[1], 1, string.len(name)) == name then
                        param_list[1] = string.sub(param_list[1], string.len(name) + 1)
                    end

                    -- Ignore everything but the first parameter
                    unilib.utils.set_player_attribute(player, param_list[1], "")
                    return true, S("Reset player attribute: @1", "unilib:" .. param_list[1])

                end

            end

        end,
    })

end
