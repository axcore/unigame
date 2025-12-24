---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/kitz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.chat_clear_mobs = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.kitz.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.chat_clear_mobs.init()

    return {
        description = "Chat command /clear_mobs",
        notes = "Removes all untamed mobs (created by the specified mod) within a 100 block radius",
    }

end

function unilib.pkg.chat_clear_mobs.exec()

    core.register_chatcommand("clear_mobs", {
        params = "<mod>",
        description = S(
            "Removes all untamed mobs (created by the specified mod) within a 100 block radius"
        ),
        privs = {server = true},

        func = function(pname, param)

            local mod_name = string.match(param, "([%a%d_-]+)")
            if not mod_name then

                return false,
                S("In order to clear mobs, you must specify a mod name (e.g. \"unimobs\"")

            end

            local player_pos = core.get_player_by_name(pname):get_pos()
            if not player_pos then
                return false, unilib.constant.chat_offline_msg
            end

            unimobs.kitz_api.clear_mobs_in_range(player_pos, mod_name)
            -- N.B. No success message/return value in the original code
            return true, S("Mobs cleared within a 100-block radius")

        end,
    })

end
