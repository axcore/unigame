---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.chat_awards = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.chat_awards.init()

    return {
        description = "Chat command /awards",
        notes = "Shows player awards",
    }

end

function unilib.pkg.chat_awards.exec()

    core.register_chatcommand("awards", {
        params = "",
        description = S("Shows player awards"),

        func = function(pname, param)

            if not core.get_player_by_name(pname) then
                return false, unilib.constant.chat_offline_msg
            elseif not unilib.setting.awards_enable_flag then
                return false, S("Awards are currently disabled in settings")
            end

            unilib.awards.show_formspec(pname)

        end,
    })

end
