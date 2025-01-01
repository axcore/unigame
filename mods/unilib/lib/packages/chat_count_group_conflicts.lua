---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.chat_count_group_conflicts = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.chat_count_group_conflicts.init()

    return {
        description = "Chat command /count_group_conflicts",
        notes = "Checks for recipe conflicts (taking groups into account), and displays the" ..
                " total number found",
        depends = "shared_chat_conflicts",
    }

end

function unilib.pkg.chat_count_group_conflicts.exec()

    core.register_chatcommand("count_group_conflicts", {
        params = "",
        description = S(
            "Checks for recipe conflicts (taking groups into account), and displays the total" ..
            " number found"
        ),
        privs = {unilib_tools = true},

        func = function(name, param)

            local conflict_count =
                    unilib.pkg.shared_chat_conflicts.check_recipe_conflicts(name, false, true)

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
