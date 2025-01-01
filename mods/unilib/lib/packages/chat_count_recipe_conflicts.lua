---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.chat_count_recipe_conflicts = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.chat_count_recipe_conflicts.init()

    return {
        description = "Chat command /count_recipe_conflicts",
        notes = "Checks for recipe conflicts, displaying the total number found",
        depends = "shared_chat_conflicts",
    }

end

function unilib.pkg.chat_count_recipe_conflicts.exec()

    core.register_chatcommand("count_recipe_conflicts", {
        params = "",
        description = S("Checks for recipe conflicts, displaying the total number found"),
        privs = {unilib_tools = true},

        func = function(name, param)

            local conflict_count =
                    unilib.pkg.shared_chat_conflicts.check_recipe_conflicts(name, false, false)

            if conflict_count > 0 then

                unilib.utils.chat_send_player(
                    name,
                    S("Craft recipe conflicts detected: @1", conflict_count)
                )

            else

                return true, S("No recipe conflicts found")

            end

        end,
    })

end
