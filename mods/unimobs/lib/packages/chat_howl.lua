---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.chat_howl = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.chat_howl.init()

    return {
        description = "Howl at the moon",
        depends = "shared_petz_lycanthropy",
    }

end

function unilib.pkg.chat_howl.exec()

    core.register_chatcommand("howl", {
        params = "",
        description = S("Howl at the moon"),
--      privs = {},

        func = function(pname, param)

            local player = core.get_player_by_name(pname)
            if player then

                if unilib.pkg.shared_petz_lycanthropy.is_werewolf(player) then

                    unimobs.kitz_api.make_sound(
                        "pos",
                        player:get_pos(),
                        "unilib_mob_monster_werewolf_howl",
                        unimobs.petz_setting.max_hear_distance
                    )

                else

                    return false, S("You are not a werewolf!")

                end

            else

                return false, S("@1 is not online!", pname)

            end

        end,
    })

end
