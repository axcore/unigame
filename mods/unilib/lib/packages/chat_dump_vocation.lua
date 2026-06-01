---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.chat_dump_vocation = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function do_dump_vocation(pname, param)

    -- Basic checks
    if not unilib.setting.awards_enable_flag then
        return false, S("Player awards are not enabled in settings")
    end

    -- Filter vocations
    local vocation_list = {}
    for vocation_name, data_table in pairs(unilib.global.awards_vocation_table) do

        if param == "" or
                string.find(vocation_name, param) or
                string.find(data_table.title, param) then
            table.insert(vocation_list, vocation_name)
        end

    end

    if #vocation_list == 0 then

        if param == "" then
            return false, S("No vocation awards are registered")
        else
            return false, S("No vocation awards match the pattern \"@1\"", param)
        end

    end

    -- Show the list of filtered vocations
    if param == "" then
        unilib.utils.chat_send_player(pname, S("List of vocation awards"))
    else
        unilib.utils.chat_send_player(pname, S("List of matching vocation awards"))
    end

    table.sort(vocation_list)

    for _, vocation_name in ipairs(vocation_list) do

        local data_table = unilib.global.awards_vocation_table[vocation_name]

        local extra = ""
        if data_table.secret_flag then
            extra = " [SECRET]"
        end

        unilib.utils.chat_send_player(pname, vocation_name .. extra)
        unilib.utils.chat_send_player(pname, "   Title: " .. data_table.title)
        unilib.utils.chat_send_player(pname, "   Description: " .. data_table.description)

        unilib.utils.chat_send_player(pname, "   Levels: ")
        for i, mini_table in ipairs(data_table.level_list) do

            unilib.utils.chat_send_player(
                pname, "      " .. i .. " " .. mini_table.title .. " (" .. mini_table.score .. ")"
            )

            if mini_table.prize_list ~= nil then

                for _, item in ipairs(mini_table.prize_list) do
                    unilib.utils.chat_send_player(pname, "         " .. item)
                end

            end

        end

        if #data_table.requires_list > 0 then

            unilib.utils.chat_send_player(pname, "   Requires: ")
            for _, item in ipairs(data_table.requires_list) do
                unilib.utils.chat_send_player(pname, "      " .. item)
            end

        end

        local achievement_list = unilib.awards.get_achievements_by_vocation(vocation_name)
        if #achievement_list > 0 then

            table.sort(achievement_list)

            unilib.utils.chat_send_player(pname, "   Achievements: ")
            for _, item in ipairs(achievement_list) do
                unilib.utils.chat_send_player(pname, "      " .. item)
            end

        end

    end

    unilib.utils.chat_send_player(
        pname, S("End of list (matching vocations found: @1)", #vocation_list)
    )

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.chat_dump_vocation.init()

    return {
        description = "Chat command /dump_vocation",
        notes = "Dumps data for vocations with a matching name or title",
    }

end

function unilib.pkg.chat_dump_vocation.exec()

    core.register_chatcommand("dump_vocation", {
        params = "<pattern>",
        description = S(
            "Dumps data for any vocation whose name or title matches the pattern"
        ),
        privs = {unilib_admin = true},

        func = function(pname, param)
            return do_dump_vocation(pname, param)
        end,
    })

end
