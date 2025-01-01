---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.plant_palm_mangrove = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.plant_palm_mangrove.init()

    return {
        description = "Mangrove palm",
        notes = "An unusual plant with a 1-block \"trunk\" and long leaves",
    }

end

function unilib.pkg.plant_palm_mangrove.exec()

    unilib.register_node(
        -- From australia:mangrove_palm_trunk
        "unilib:plant_palm_mangrove_trunk",
        "australia:mangrove_palm_trunk",
        mode,
        {
            description = unilib.utils.annotate(S("Mangrove Palm Trunk"), "Nypa fruticans"),
            tiles = {
                "unilib_plant_palm_mangrove_trunk.png",
                "unilib_dirt_mud_mangrove.png",
                "unilib_plant_palm_mangrove_trunk.png",
            },
            -- N.B. removed flora = 1 to prevent nonsensical spreading
            groups = {attached_node = 1, choppy = 2, flammable = 2, oddly_breakable_by_hand = 1},
            sounds = unilib.global.sound_table.wood,

            -- N.B. removed inventory/wield images so the node appears in 3d in player's inventory
--          inventory_image = "unilib_plant_palm_mangrove_trunk.png",
            paramtype = "light",
            paramtype2 = "facedir",
            selection_box = {
                type = "fixed",
                fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
            },
--          wield_image = "unilib_plant_palm_mangrove_trunk.png",

            on_place = core.rotate_node,
        }
    )
    -- (not compatible with flowerpots)

    unilib.register_node(
        -- From australia:mangrove_palm_leaf_bot
        "unilib:plant_palm_mangrove_leaf_bottom",
        "australia:mangrove_palm_leaf_bot",
        mode,
        {
            description = unilib.utils.annotate(S("Mangrove Palm Leaf"), "Nypa fruticans"),
            tiles = {"unilib_plant_palm_mangrove_leaf_bottom.png"},
            -- N.B. removed flora = 1 to prevent nonsensical spreading
            groups = {attached_node = 1, flammable = 2, snappy = 3},
            sounds = unilib.global.sound_table.leaves,

            drawtype = "nodebox",
            inventory_image = "unilib_plant_palm_mangrove_leaf_bottom.png",
            nodebox = {
                type = "fixed",
                fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
            },
            paramtype = "light",
            paramtype2 = "facedir",
            selection_box = {
                type = "fixed",
                fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
            },
            use_texture_alpha = "clip",
            wield_image = "unilib_plant_palm_mangrove_leaf_bottom.png",
        }
    )

    unilib.register_node(
        -- From australia:mangrove_palm_leaf_top
        "unilib:plant_palm_mangrove_leaf_top",
        "australia:mangrove_palm_leaf_top",
        mode,
        {
            description = unilib.utils.annotate(S("Mangrove Palm Leaf"), "Nypa fruticans"),
            tiles = {"unilib_plant_palm_mangrove_leaf_top.png"},
            -- N.B. removed flora = 1 to prevent nonsensical spreading
            groups = {attached_node = 1, flammable = 2, snappy = 3},
            sounds = unilib.global.sound_table.leaves,

            drawtype = "nodebox",
            inventory_image = "unilib_plant_palm_mangrove_leaf_top.png",
            nodebox = {
                type = "fixed",
                fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
            },
            paramtype = "light",
            paramtype2 = "facedir",
            selection_box = {
                type = "fixed",
                fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
            },
            use_texture_alpha = "clip",
            wield_image = "unilib_plant_palm_mangrove_leaf_top.png",
        }
    )

    unilib.register_decoration_generic("australia_plant_palm_mangrove", {
        -- From australia/biome_mangroves.lua
        deco_type = "schematic",
        schematic = unilib.core.path_mod .. "/mts/unilib_plant_palm_mangrove.mts",

        fill_ratio = 0.3,
        flags = "force_placement",
        sidelen = 80,
    })

end
