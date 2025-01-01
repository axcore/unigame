---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.chat_set_mod_attribute = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.chat_set_mod_attribute.init()

    return {
        description = "Chat command /set_mod_attribute",
        notes = "Sets the value of a mod attribute",
    }

end

function unilib.pkg.chat_set_mod_attribute.exec()

    core.register_chatcommand("set_mod_attribute", {
        params = "<attribute> [value]",
        description = S("Sets the value of a mod attribute"),
        privs = {unilib_admin = true},

        func = function(name, param)

            if not core.get_player_by_name(name) then
                return false, unilib.constant.chat_offline_msg
            end

            local param_list = unilib.utils.split_string_by_whitespace(param, true)
            if param_list[1] == nil or param_list[1] == "" then

                return false, S("You must specify a mod attribute (try /show_mod_attributes)")

            elseif param_list[2] == nil or param_list[2] == "" then

                return false, S("You must specify an attribute value (try /reset_mod_attribute)")

            else

                -- The function is expecting the "unilib:mattrib_" portion to be stripped off
                name = unilib.core.name .. ":mattrib_"
                if string.sub(param_list[1], 1, string.len(name)) == name then
                    param_list[1] = string.sub(param_list[1], string.len(name) + 1)
                end

                -- Ignore everything but the first two parameters
                unilib.utils.set_mod_attribute(param_list[1], param_list[2])

                return true, S(
                    "Set mod attribute: @1: @2",
                    "unilib:" .. param_list[1],
                    param_list[2]
                )

            end

        end,
    })

end
