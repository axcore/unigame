---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.chat_dump_achievement = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function do_dump_achievement(pname, param)

    -- Basic checks
    if not unilib.setting.awards_enable_flag then
        return false, S("Player awards are not enabled in settings")
    end

    -- Filter achievements
    local achievement_list = {}
    for achievement_name, data_table in pairs(unilib.global.awards_achievement_table) do

        if param == "" or
                string.find(achievement_name, param) or
                string.find(data_table.title, param) then
            table.insert(achievement_list, achievement_name)
        end

    end

    if #achievement_list == 0 then

        if param == "" then
            return false, S("No achievement awards are registered")
        else
            return false, S("No achievement awards match the pattern \"@1\"", param)
        end

    end

    -- Show the list of filtered achievements
    if param == "" then
        unilib.utils.chat_send_player(pname, S("List of achievement awards"))
    else
        unilib.utils.chat_send_player(pname, S("List of matching achievement awards"))
    end

    table.sort(achievement_list)

    for _, achievement_name in ipairs(achievement_list) do

        local data_table = unilib.global.awards_achievement_table[achievement_name]

        local extra = ""
        if data_table.secret_flag then
            extra = " [SECRET]"
        end

        unilib.utils.chat_send_player(pname, achievement_name .. extra)
        unilib.utils.chat_send_player(pname, "   Title: " .. data_table.title)
        unilib.utils.chat_send_player(pname, "   Description: " .. data_table.description)
        unilib.utils.chat_send_player(pname, "   Score: " .. data_table.score)

        unilib.utils.chat_send_player(pname, "   Trigger:")
        unilib.utils.chat_send_player(
            pname, "      Prototype: " .. data_table.trigger_table.prototype
        )
        unilib.utils.chat_send_player(
            pname, "      Target: " .. data_table.trigger_table.target
        )

        if data_table.trigger_table.filter_list ~= nil and
                #data_table.trigger_table.filter_list > 0 then

            unilib.utils.chat_send_player(pname, "      Filter list:")
            for _, item in ipairs(data_table.trigger_table.filter_list) do
                unilib.utils.chat_send_player(pname, "         " .. item)
            end

        end

        if data_table.trigger_table.item_list ~= nil and
                #data_table.trigger_table.item_list > 0 then

            unilib.utils.chat_send_player(pname, "      Item list:")
            for _, item in ipairs(data_table.trigger_table.item_list) do
                unilib.utils.chat_send_player(pname, "         " .. item)
            end

        end

        if #data_table.vocation_list > 0 then

            unilib.utils.chat_send_player(pname, "   Vocations:")
            for _, item in ipairs(data_table.vocation_list) do
                unilib.utils.chat_send_player(pname, "      " .. item)
            end

        end

        if #data_table.prize_list > 0 then

            unilib.utils.chat_send_player(pname, "   Prizes:")
            for _, item in ipairs(data_table.prize_list) do
                unilib.utils.chat_send_player(pname, "      " .. item)
            end

        end

        if #data_table.requires_list > 0 then

            unilib.utils.chat_send_player(pname, "   Requires:")
            for _, item in ipairs(data_table.requires_list) do
                unilib.utils.chat_send_player(pname, "      " .. item)
            end

        end

    end

    unilib.utils.chat_send_player(
        pname, S("End of list (matching achievements found: @1)", #achievement_list)
    )

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.chat_dump_achievement.init()

    return {
        description = "Chat command /dump_achievement",
        notes = "Dumps data for achievements with a matching name or title",
    }

end

function unilib.pkg.chat_dump_achievement.exec()

    core.register_chatcommand("dump_achievement", {
        params = "<pattern>",
        description = S(
            "Dumps data for any achievement whose name or title matches the pattern"
        ),
        privs = {unilib_admin = true},

        func = function(pname, param)
            return do_dump_achievement(pname, param)
        end,
    })

end
