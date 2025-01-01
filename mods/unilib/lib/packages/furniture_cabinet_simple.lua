---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xdecor
-- Code:    BSD
-- Media:   WTFPL/CC BY-SA/CC BY 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.furniture_cabinet_simple = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.xdecor.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.furniture_cabinet_simple.init()

    return {
        description = "Simple wooden cabinet",
        depends = "trapdoor_wood_ordinary",
        optional = "shared_screwdriver",
    }

end

function unilib.pkg.furniture_cabinet_simple.exec()

    unilib.register_node("unilib:furniture_cabinet_simple", "xdecor:cabinet", mode, {
        -- From xdecor:cabinet
        description = S("Simple Wooden Cabinet"),
        tiles = {
            "unilib_furniture_cabinet_simple_side.png",
            "unilib_furniture_cabinet_simple_side.png",
            "unilib_furniture_cabinet_simple_side.png",
            "unilib_furniture_cabinet_simple_side.png",
            "unilib_furniture_cabinet_simple_side.png",
            "unilib_furniture_cabinet_simple_front.png",
        },
        groups = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 1},
        sounds = unilib.global.sound_table.wood,

        -- N.B. is_ground_content = false not in original code; added to match other furniture
        is_ground_content = false,
        paramtype2 = "facedir",
        use_texture_alpha = "opaque",
    })
    unilib.register_craft({
        -- From xdecor:cabinet
        output = "unilib:furniture_cabinet_simple",
        recipe = {
            {"group:wood", "group:wood", "group:wood"},
            {"unilib:trapdoor_wood_ordinary", "", "unilib:trapdoor_wood_ordinary"},
            {"group:wood", "group:wood", "group:wood"},
        },
    })
    if unilib.global.pkg_executed_table["shared_screwdriver"] ~= nil then

        unilib.override_item("unilib:furniture_cabinet_simple", {
            on_rotate = unilib.pkg.shared_screwdriver.rotate_simple,
        })

    end

    unilib.furniture.convert_to_container(
        "unilib:furniture_cabinet_simple",
        3,
        S("Simple Wooden Cabinet"),
        "simple cabinet"
    )

    unilib.register_node(
        -- From xdecor:cabinet_half
        "unilib:furniture_cabinet_simple_drawer_top",
        "xdecor:cabinet_half",
        mode,
        {
            description = unilib.utils.brackets(S("Simple Wooden Cabinet"), S("Top Drawer")),
            tiles = {
                "unilib_furniture_cabinet_simple_side.png",
                "unilib_furniture_cabinet_simple_side.png",
                "unilib_furniture_cabinet_simple_drawer_top_side.png",
                "unilib_furniture_cabinet_simple_drawer_top_side.png",
                "unilib_furniture_cabinet_simple_drawer_top_side.png",
                "unilib_furniture_cabinet_simple_drawer_top_front.png",
            },
            groups = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 1},
            sounds = unilib.global.sound_table.wood,

            drawtype = "nodebox",
            -- N.B. is_ground_content = false not in original code; added to match other furniture
            is_ground_content = false,
            node_box = {
                type = "fixed",
                fixed = {-0.5, 0, -0.5, 0.5, 0.5, 0.5},
            },
            paramtype = "light",
            paramtype2 = "facedir",
            use_texture_alpha = "opaque",
        }
    )
    unilib.register_craft({
        -- From xdecor:cabinet_half; tweaked the recipe to allow for top and bottom drawers
        output = "unilib:furniture_cabinet_simple_drawer_top 4",
        recipe = {
            {""},
            {"unilib:furniture_cabinet_simple"},
            {"unilib:furniture_cabinet_simple"},
        },
    })
    if unilib.global.pkg_executed_table["shared_screwdriver"] ~= nil then

        unilib.override_item("unilib:furniture_cabinet_simple_drawer_top", {
            on_rotate = unilib.pkg.shared_screwdriver.rotate_simple,
        })

    end

    unilib.furniture.convert_to_container(
        "unilib:furniture_cabinet_simple_drawer_top",
        1,
        unilib.utils.brackets(S("Simple Wooden Cabinet"), S("Top Drawer")),
        "simple cabinet drawer"
    )

    unilib.register_node("unilib:furniture_cabinet_simple_drawer_bottom", nil, mode, {
        -- Original to unilib, based on the "xdecor:cabinet_half" code above
        description = unilib.utils.brackets(S("Simple Wooden Cabinet"), S("Bottom Drawer")),
        tiles = {
            "unilib_furniture_cabinet_simple_side.png",
            "unilib_furniture_cabinet_simple_side.png",
            "unilib_furniture_cabinet_simple_drawer_bottom_side.png",
            "unilib_furniture_cabinet_simple_drawer_bottom_side.png",
            "unilib_furniture_cabinet_simple_drawer_bottom_side.png",
            "unilib_furniture_cabinet_simple_drawer_bottom_front.png",
        },
        groups = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 1},
        sounds = unilib.global.sound_table.wood,

        drawtype = "nodebox",
        -- N.B. is_ground_content = false not in original code; added to match other furniture
        is_ground_content = false,
        node_box = {
            type = "fixed",
            fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5},
        },
        paramtype = "light",
        paramtype2 = "facedir",
        use_texture_alpha = "opaque",
    })
    unilib.register_craft({
        -- Original to unilib, based on the "xdecor:cabinet_half" code above
        output = "unilib:furniture_cabinet_simple_drawer_bottom 4",
        recipe = {
            {"unilib:furniture_cabinet_simple"},
            {"unilib:furniture_cabinet_simple"},
            {""},
        },
    })
    if unilib.global.pkg_executed_table["shared_screwdriver"] ~= nil then

        unilib.override_item("unilib:furniture_cabinet_simple_drawer_bottom", {
            on_rotate = unilib.pkg.shared_screwdriver.rotate_simple,
        })

    end

    unilib.furniture.convert_to_container(
        "unilib:furniture_cabinet_simple_drawer_bottom",
        1,
        unilib.utils.brackets(S("Simple Wooden Cabinet"), S("Bottom Drawer")),
        "simple cabinet drawer"
    )

end
