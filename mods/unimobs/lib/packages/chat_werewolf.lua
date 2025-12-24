---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.chat_werewolf = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.chat_werewolf.init()

    return {
        description = "Converts a player into a werewolf",
        depends = "shared_petz_lycanthropy",
    }

end

function unilib.pkg.chat_werewolf.exec()

    core.register_chatcommand("werewolf", {
        params = "<set|unset|cure|clan> <player>",
        description = S("Converts a player into a werewolf"),
        privs = {server = true},

        func = function(pname, param)

            local sub_cmd, target_name = string.match(param, "([%a%d_-]+) ([%a%d_-]+)")

            if sub_cmd ~= "set" and
                    sub_cmd ~= "unset" and
--                  sub_cmd ~= "reset" and       -- N.B. Not actually valid
                    sub_cmd ~= "clan" and
                    sub_cmd ~= "cure" then
                return false, S("Usage: /werewolf <set|unset|cure|clan> <player_name>")
            end

            if not target_name then
                return false, S("You must specify a valid player name")
            end

            local player = core.get_player_by_name(target_name)
            if not player then
                return false, S("@1 is not online!", target_name)
            end

            if sub_cmd == "set" then

                if unilib.pkg.shared_petz_lycanthropy.has_lycanthropy(player) then

                    return false,
                            S("@1 is already suffering from the Curse of Lycanthropy", target_name)

                else

                    unilib.pkg.shared_petz_lycanthropy.infect_player(player)
                    return true, S("@1 has been infected by the Curse of Lycanthropy!", target_name)

                end

            elseif sub_cmd == "unset" then

                unilib.pkg.shared_petz_lycanthropy.reset_infected_player(player)
                return true, S("The werewolf \"@1\" has assumed human form!", target_name)

            elseif sub_cmd == "cure" then

                if unilib.pkg.shared_petz_lycanthropy.has_lycanthropy(player) then

                    unilib.pkg.shared_petz_lycanthropy.cure_player(player)
                    return true, S("@1 has been cured of the Curse of Lycanthropy!", target_name)

                else

                    return false, S("@1 is not a werewolf!", target_name)

                end

            elseif sub_cmd == "clan" then

                if unilib.pkg.shared_petz_lycanthropy.has_lycanthropy(player) then

                    local clan_id = tonumber(
                        unilib.utils.get_player_attribute(player, "lycanthropy_werewolf_clan_id")
                    )
                    local clan_name =
                            unilib.pkg.shared_petz_lycanthropy.clan_list[clan_name].clan_name

                    return true, S("@1 belongs to the \"@2\" clan", target_name, clan_name)

                else

                    return false, S("@1 is not a werewolf!", target_name)

                end

            end

        end,
    })

end
