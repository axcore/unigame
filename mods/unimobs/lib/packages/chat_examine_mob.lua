---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unimobs
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.chat_examine_mob = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.unimobs.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.chat_examine_mob.init()

    return {
        description = "Chat commands /examine_mob",
        notes = "Shows details (including hidden ones) about matching petz-compatible mobs",
    }

end

function unilib.pkg.chat_examine_mob.exec()

    core.register_chatcommand("examine_mob", {
        params = "[pattern]",
        description = S(
            "Shows details (including hidden ones) about matching petz-compatible mobs"
        ),
        privs = {unilib_admin = true},

        func = function(pname, param)

            -- Compile a list of matching mobs
            local mob_list = {}
            for mob_type, data_table in pairs(unimobs.petz_global.mob_table) do

                if param == "" or
                        string.match(mob_type, param) or
                        string.match(data_table.mob_name, param) then
                    table.insert(mob_list, mob_type)
                end

            end

            if #mob_list == 0 then

                if param == "" then
                    return false, S("No petz-compatible mobs are loaded")
                else
                    return false, S("No petz-compatible mobs match the pattern \"@1\"", param)
                end

            end

            unilib.utils.chat_send_player(pname, S("List of petz-compatible mobs"))

            for _, mob_type in ipairs(mob_list) do

                local data_table = unimobs.petz_global.mob_table[mob_type]

                local repel_str = unimobs.petz_api.get_msetting(mob_type, "repel_item_first")
                if repel_str == "" then
                    repel_str = S("nothing")
                end

                local follow_str = unimobs.petz_api.get_msetting(mob_type, "follow_item_first")
                if follow_str == "" then
                    follow_str = S("nothing")
                end

                local feed_str = unimobs.petz_api.get_msetting(mob_type, "feed_item_first")
                if feed_str == "" then
                    feed_str = S("nothing")
                end

                local breed_str = unimobs.petz_api.get_msetting(mob_type, "breed_item_first")
                if breed_str == "" then
                    breed_str = S("nothing")
                end

                unilib.utils.chat_send_player(
                    pname,
                    "   " .. data_table.description .. "\n" ..
                            "   " .. data_table.mob_name .. "\n" ..
                            "      " .. S("Repel with @1", repel_str) .. "\n" ..
                            "      " .. S("Follows @1", follow_str) .. "\n" ..
                            "      " .. S("Feed with @1", feed_str) .. "\n" ..
                            "      " .. S("Breed with @1", breed_str)
                )

            end

            unilib.utils.chat_send_player(
                pname, S("End of list (matching mobs found: @1)", #mob_list)
            )

        end,
    })

end
