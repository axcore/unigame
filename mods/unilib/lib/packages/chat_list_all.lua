---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.chat_list_all = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.chat_list_all.init()

    return {
        description = "Chat command /list_all",
        notes = "Lists counts of everything",
    }

end

function unilib.pkg.chat_list_all.exec()

    core.register_chatcommand("list_all", {
        params = "",
        description = S("Lists counts of everything"),
        privs = {unilib_tools = true},

        func = function(name, param)

            unilib.utils.chat_send_player(name, S("Internal counts"))

            unilib.utils.chat_send_player(
                name, "   " .. S("Remixes") .. ": " .. #unilib.global.init_remix_list
            )

            unilib.utils.chat_send_player(
                name,
                "   " .. S("Packages") .. ": " ..
                        unilib.utils.get_table_size(unilib.global.pkg_table)
            )

            unilib.utils.chat_send_player(
                name,
                "   " .. S("Hidden items") .. ": " ..
                        unilib.utils.get_table_size(unilib.global.hidden_item_table)
            )

            unilib.utils.chat_send_player(name, S("External counts"))

            unilib.utils.chat_send_player(
                name,
                "   " .. S("ABMs") .. ": " .. unilib.utils.get_table_size(core.registered_abms)
            )

            unilib.utils.chat_send_player(
                name,
                "   " .. S("Biomes") .. ": " .. unilib.utils.get_table_size(core.registered_biomes)
            )

            unilib.utils.chat_send_player(
                name,
                "   " .. S("Craftitems") .. ": " ..
                        unilib.utils.get_table_size(core.registered_craftitems)
            )

            unilib.utils.chat_send_player(
                name,
                "   " .. S("Decorations") .. ": " ..
                        unilib.utils.get_table_size(core.registered_decorations)
            )

            unilib.utils.chat_send_player(
                name,
                "   " .. S("Entities") .. ": " ..
                        unilib.utils.get_table_size(core.registered_entities)
            )

            unilib.utils.chat_send_player(
                name,
                "   " .. S("LBMs") .. ": " .. unilib.utils.get_table_size(core.registered_lbms)
            )

            unilib.utils.chat_send_player(
                name,
                "   " .. S("Nodes") .. ": " .. unilib.utils.get_table_size(core.registered_nodes)
            )

            unilib.utils.chat_send_player(
                name,
                "   " .. S("Ore distributions") .. ": " ..
                        unilib.utils.get_table_size(core.registered_ores)
            )

            unilib.utils.chat_send_player(
                name,
                "   " .. S("Tools") .. ": " .. unilib.utils.get_table_size(core.registered_tools)
            )

            unilib.utils.chat_send_player(name, S("Type counts"))

            unilib.utils.chat_send_player(
                name,
                "   " .. S("Stones") .. ": " ..
                        unilib.utils.get_table_size(unilib.global.stone_table)
            )

            unilib.utils.chat_send_player(
                name,
                "   " .. S("Trees") .. ": " .. unilib.utils.get_table_size(unilib.global.tree_table)
            )

            unilib.utils.chat_send_player(
                name,
                "   " .. S("Buckets") .. ": " ..
                        unilib.utils.get_table_size(unilib.global.generic_bucket_table)
            )

            unilib.utils.chat_send_player(
                name,
                "   " .. S("Liquids") .. ": " ..
                        unilib.utils.get_table_size(unilib.global.generic_liquid_table)
            )

            unilib.utils.chat_send_player(
                name,
                "   " .. S("Metals") .. ": " ..
                        unilib.utils.get_table_size(unilib.global.metal_table)
            )

            unilib.utils.chat_send_player(
                name,
                "   " .. S("Non-metals") .. ": " ..
                        unilib.utils.get_table_size(unilib.global.non_metal_table)
            )

            unilib.utils.chat_send_player(
                name,
                "   " .. S("Minerals") .. ": " ..
                        unilib.utils.get_table_size(unilib.global.mineral_table)
            )

        end,
    })

end
