---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xdecor
-- Code:    BSD
-- Media:   WTFPL/CC BY-SA/CC BY 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.container_chest_obsidian = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.xdecor.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.container_chest_obsidian.init()

    return {
        description = "Obsidian chest",
        notes = "Obsidian chests placed anywhere in the world have access to the same inventory",
        depends = {"container_chest_ordinary", "stone_obsidian"},
        optional = "shared_screwdriver",
    }

end

function unilib.pkg.container_chest_obsidian.exec()

    local def_table = {
        description = S("Obsidian Chest"),
        tiles = {
            "unilib_container_chest_obsidian_top.png",
            "unilib_container_chest_obsidian_top.png",
            "unilib_container_chest_obsidian_side.png",
            "unilib_container_chest_obsidian_side.png",
            "unilib_container_chest_obsidian_side.png",
            "unilib_container_chest_obsidian_front.png"
        },
        groups = {choppy = 1, cracky = 1},
        sounds = unilib.global.sound_table.stone,

        -- N.B. is_ground_content = false not in original code
        is_ground_content = false,
        paramtype2 = "facedir",

        -- N.B. No .on_blast() in original code
        on_blast = function() end,

        on_construct = function(pos)

            local meta = core.get_meta(pos)
            meta:set_string(
                "formspec",
                "size[8,9]" ..
                "list[current_player;chest_obsidian;0,0;8,4;]" ..
                "list[current_player;main;0,5;8,4;]" ..
                "listring[current_player;chest_obsidian]" ..
                "listring[current_player;main]" ..
                unilib.misc.get_hotbar_bg(0,5)
            )
            meta:set_string("infotext", S("Obsidian Chest"))

        end,

        --[[
        on_metadata_inventory_move = function(
            pos, from_list, from_index, to_list, to_index, count, player
        )
            -- N.B. This callback and its log message not in original code
            unilib.utils.log(
                "action",
                player:get_player_name() .. " moves items in obsidian chest at " ..
                        core.pos_to_string(pos)
            )

        end,

        on_metadata_inventory_put = function(pos, listname, index, stack, player)

            -- N.B. This callback and its log message not in original code
            unilib.utils.log(
                "action",
                player:get_player_name() .. " moves items to obsidian chest at " ..
                        core.pos_to_string(pos)
            )

        end,

        on_metadata_inventory_take = function(pos, listname, index, stack, player)

            -- N.B. This callback and its log message not in original code
            unilib.utils.log(
                "action",
                player:get_player_name() .. " takes items from obsidian chest at " ..
                        core.pos_to_string(pos)
            )

        end,
        ]]--
    }

    unilib.utils.set_inventory_action_loggers(def_table, "obsidian chest")
    unilib.register_node(
        -- From xdecor:enderchest
        "unilib:container_chest_obsidian", "xdecor:enderchest", mode, def_table
    )

    unilib.register_craft({
        output = "unilib:container_chest_obsidian",
        recipe = {
            {"", "unilib:stone_obsidian", ""},
            {"unilib:stone_obsidian", "unilib:container_chest_ordinary", "unilib:stone_obsidian"},
            {"", "unilib:stone_obsidian", ""},
        },
    })
    if unilib.global.pkg_executed_table["shared_screwdriver"] ~= nil then

        unilib.override_item("unilib:container_chest_obsidian", {
            on_rotate = unilib.pkg.shared_screwdriver.rotate_simple,
        })

    end

    core.register_on_joinplayer(function(player)

        local inv = player:get_inventory()
        inv:set_size("chest_obsidian", 8 * 4)

    end)

end
