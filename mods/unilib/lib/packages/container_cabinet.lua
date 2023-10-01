---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xdecor
-- Code:    BSD
-- Media:   WTFPL/CC BY-SA/CC BY 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.container_cabinet = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.xdecor.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function on_metadata_inventory_move(
    pos, from_list, from_index, to_list, to_index, count, player
)
    -- N.B. This callback and its log message not in original code
    unilib.log(
        "action",
        player:get_player_name() .. " moves stuff in cabinet at " .. minetest.pos_to_string(pos)
    )

end

local function on_metadata_inventory_put(pos, listname, index, stack, player)

    -- N.B. This callback and its log message not in original code
    unilib.log(
        "action",
        player:get_player_name() .. " moves stuff to cabinet at " .. minetest.pos_to_string(pos)
    )

end

local function on_metadata_inventory_take(pos, listname, index, stack, player)

    -- N.B. This callback and its log message not in original code
    unilib.log(
        "action",
        player:get_player_name() .. " takes stuff from cabinet at " .. minetest.pos_to_string(pos)
    )

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.container_cabinet.init()

    return {
        description = "Wooden cabinet",
        depends = "trapdoor_wood_ordinary",
        optional = "shared_screwdriver",
    }

end

function unilib.pkg.container_cabinet.exec()

    unilib.register_node("unilib:container_cabinet", "xdecor:cabinet", mode, {
        -- From xdecor:cabinet
        description = S("Wooden Cabinet"),
        tiles = {
            "unilib_container_cabinet_side.png",
            "unilib_container_cabinet_side.png",
            "unilib_container_cabinet_side.png",
            "unilib_container_cabinet_side.png",
            "unilib_container_cabinet_side.png",
            "unilib_container_cabinet_front.png",
        },
        groups = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 1},
        sounds = unilib.sound_table.wood,

        paramtype2 = "facedir",
        use_texture_alpha = "opaque",

        can_dig = function(pos)

            local meta = minetest.get_meta(pos)
            local inv = meta:get_inventory()
            return inv:is_empty("main")

        end,

        on_construct = function(pos)

            local meta = minetest.get_meta(pos)
            meta:set_string(
                "formspec",
                "size[8,8]" ..
                "list[context;main;0,0;8,3;]" ..
                "list[current_player;main;0,4;8,4;]" ..
                "listring[current_player;main]" ..
                "listring[context;main]"
            )
            meta:set_string("infotext", S("Wooden Cabinet"))
            local inv = meta:get_inventory()
            inv:set_size("main", 24)

        end,

        on_metadata_inventory_move = on_metadata_inventory_move,

        on_metadata_inventory_put = on_metadata_inventory_put,

        on_metadata_inventory_take = on_metadata_inventory_take,
    })
    unilib.register_craft({
        -- From xdecor:cabinet
        output = "unilib:container_cabinet",
        recipe = {
            {"group:wood", "group:wood", "group:wood"},
            {"unilib:trapdoor_wood_ordinary", "", "unilib:trapdoor_wood_ordinary"},
            {"group:wood", "group:wood", "group:wood"},
        },
    })
    if unilib.pkg_executed_table["shared_screwdriver"] ~= nil then

        unilib.override_item("unilib:container_cabinet", {
            on_rotate = unilib.pkg.shared_screwdriver.rotate_simple,
        })

    end

    unilib.register_node("unilib:container_cabinet_drawer_top", "xdecor:cabinet_half", mode, {
        -- From xdecor:cabinet_half
        description = unilib.brackets(S("Wooden Cabinet"), S("Top Drawer")),
        tiles = {
            "unilib_container_cabinet_side.png",
            "unilib_container_cabinet_side.png",
            "unilib_container_cabinet_drawer_top_side.png",
            "unilib_container_cabinet_drawer_top_side.png",
            "unilib_container_cabinet_drawer_top_side.png",
            "unilib_container_cabinet_drawer_top_front.png",
        },
        groups = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 1},
        sounds = unilib.sound_table.wood,

        drawtype = "nodebox",
        node_box = {
            type = "fixed",
            fixed = {-0.5, 0, -0.5, 0.5, 0.5, 0.5},
        },
        paramtype = "light",
        paramtype2 = "facedir",
        use_texture_alpha = "opaque",

        can_dig = function(pos)

            local meta = minetest.get_meta(pos)
            local inv = meta:get_inventory()
            return inv:is_empty("main")

        end,

        on_construct = function(pos)

            local meta = minetest.get_meta(pos)
            meta:set_string(
                "formspec",
                "size[8,6]" ..
                "list[context;main;0,0;8,1;]" ..
                "list[current_player;main;0,2;8,4;]" ..
                "listring[current_player;main]" ..
                "listring[context;main]"
            )
            meta:set_string("infotext", S("Wooden Cabinet (Top Drawer)"))
            local inv = meta:get_inventory()
            inv:set_size("main", 8)

        end,

        on_metadata_inventory_move = on_metadata_inventory_move,

        on_metadata_inventory_put = on_metadata_inventory_put,

        on_metadata_inventory_take = on_metadata_inventory_take,
    })
    unilib.register_craft({
        -- From xdecor:cabinet_half; tweaked the recipe to allow for top and bottom drawers
        output = "unilib:container_cabinet_drawer_top 4",
        recipe = {
            {""},
            {"unilib:container_cabinet"},
            {"unilib:container_cabinet"},
        },
    })
    if unilib.pkg_executed_table["shared_screwdriver"] ~= nil then

        unilib.override_item("unilib:container_cabinet_drawer_top", {
            on_rotate = unilib.pkg.shared_screwdriver.rotate_simple,
        })

    end

    unilib.register_node("unilib:container_cabinet_drawer_bottom", nil, mode, {
        -- Original to unilib, based on the "xdecor:cabinet_half" code above
        description = unilib.brackets(S("Wooden Cabinet"), S("Bottom Drawer")),
        tiles = {
            "unilib_container_cabinet_side.png",
            "unilib_container_cabinet_side.png",
            "unilib_container_cabinet_drawer_bottom_side.png",
            "unilib_container_cabinet_drawer_bottom_side.png",
            "unilib_container_cabinet_drawer_bottom_side.png",
            "unilib_container_cabinet_drawer_bottom_front.png",
        },
        groups = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 1},
        sounds = unilib.sound_table.wood,

        drawtype = "nodebox",
        node_box = {
            type = "fixed",
            fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5},
        },
        paramtype = "light",
        paramtype2 = "facedir",
        use_texture_alpha = "opaque",

        can_dig = function(pos)

            local meta = minetest.get_meta(pos)
            local inv = meta:get_inventory()
            return inv:is_empty("main")

        end,

        on_construct = function(pos)

            local meta = minetest.get_meta(pos)
            meta:set_string(
                "formspec",
                "size[8,6]" ..
                "list[context;main;0,0;8,1;]" ..
                "list[current_player;main;0,2;8,4;]" ..
                "listring[current_player;main]" ..
                "listring[context;main]"
            )
            meta:set_string("infotext", S("Wooden Cabinet (Bottom Drawer)"))
            local inv = meta:get_inventory()
            inv:set_size("main", 8)

        end,

        on_metadata_inventory_move = on_metadata_inventory_move,

        on_metadata_inventory_put = on_metadata_inventory_put,

        on_metadata_inventory_take = on_metadata_inventory_take,
    })
    unilib.register_craft({
        -- Original to unilib, based on the "xdecor:cabinet_half" code above
        output = "unilib:container_cabinet_drawer_bottom 4",
        recipe = {
            {"unilib:container_cabinet"},
            {"unilib:container_cabinet"},
            {""},
        },
    })
    if unilib.pkg_executed_table["shared_screwdriver"] ~= nil then

        unilib.override_item("unilib:container_cabinet_drawer_bottom", {
            on_rotate = unilib.pkg.shared_screwdriver.rotate_simple,
        })

    end

end
