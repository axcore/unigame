---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.chat_check_broken_recipes = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.chat_check_broken_recipes.init()

    return {
        description = "Chat command /check_broken_recipes",
        notes = "Checks for missing recipe ingredients, displaying detailed output",
        depends = "shared_chat_missing",
    }

end

function unilib.pkg.chat_check_broken_recipes.exec()

    core.register_chatcommand("check_broken_recipes", {
        params = "",
        description = S("Checks for missing recipe ingredients, displaying detailed output"),
        privs = {unilib_tools = true},

        func = function(name, param)

            local missing_count = unilib.pkg.shared_chat_missing.check_broken_recipes(name, true)

            if missing_count > 0 then

                unilib.utils.chat_send_player(
                    name,
                    S("Missing recipe ingredients detected: @1", missing_count)
                )

            else

                return true, S("No missing recipe ingredients found")

            end

        end,
    })

end
