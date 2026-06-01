---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.chat_check_vocations = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function get_level_score(level_list)

    local mini_table = level_list[#level_list]
    return mini_table.score

end

local function get_achievement_score(vocation_name)

    local score = 0

    for _, achievement_name in ipairs(unilib.awards.get_achievements_by_vocation(vocation_name)) do

        local data_table = unilib.global.awards_achievement_table[achievement_name]
        score = score + data_table.score

    end

    return score

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.chat_check_vocations.init()

    return {
        description = "Chat command /check_vocations",
        notes = "Checks that all levels in a vocation can be unlocked",
    }

end

function unilib.pkg.chat_check_vocations.exec()

    core.register_chatcommand("check_vocations", {
        params = "",
        description = S("Checks that all levels in a vocation can be unlocked"),
        privs = {unilib_admin = true},

        func = function(pname, param)

            unilib.utils.chat_send_player(pname, S("List of vocations"))

            local unlockable_count = 0

            for _, vocation_name in ipairs(
                unilib.utils.sort_table(unilib.global.awards_vocation_table)
            ) do

                local data_table = unilib.global.awards_vocation_table[vocation_name]
                local level_score = get_level_score(data_table.level_list)
                local achievement_score = get_achievement_score(vocation_name)

                local extra = ""
                if level_score > achievement_score then

                    extra = " [UNLOCKABLE]"
                    unlockable_count = unlockable_count + 1

                end

                unilib.utils.chat_send_player(pname, "   " .. vocation_name .. extra)
                unilib.utils.chat_send_player(pname, "      Levels:" .. #data_table.level_list)
                unilib.utils.chat_send_player(pname, "      Total score:" .. level_score)
                unilib.utils.chat_send_player(
                    pname, "      Combined achievement score:" .. achievement_score
                )

            end

            unilib.utils.chat_send_player(
                pname, S("End of list (unlockable vocations found: @1)", unlockable_count)
            )

        end,
    })

end
