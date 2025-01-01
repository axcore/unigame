---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.bush_exotic = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.bush_exotic.init()

    return {
        description = "Exotic bush",
        notes = "This package was created because the minetest_game and farlands versions of the" ..
                " two basic bushes had similar (but not identical) textures; the farlands bushes" ..
                " are therefore named \"exotic\"",
        optional = {
            -- If the "ore_farlands_bush_exotic" package is not loaded, then the shared package will
            --      use an ABM to place leaves-with-fruit nodes instead
            "abm_farlands_bushes_trees",
            "fruit_berry_exotic",
            -- Create fruit-as-node variants for use in schematics
            "shared_farlands_fruit",
            -- Also allow crafting bush stem into exotic tree wood
            "tree_exotic",
        },
    }

end

function unilib.pkg.bush_exotic.exec()

    -- (Using same level as the equivalent bush in default)
    local burnlevel = 2
    -- (no sci_name)

    unilib.register_bush_stem({
        -- From farlands, default:bush_stem. Creates unilib:bush_exotic_stem
        part_name = "exotic",
        orig_name = nil,

        replace_mode = mode,
        common_group = 2,
        description = S("Exotic Bush Stem"),
        select_table = {-7 / 16, -0.5, -7 / 16, 7 / 16, 0.5, 7 / 16},
    })
    if unilib.global.pkg_executed_table["tree_exotic"] ~= nil then

        unilib.register_craft({
            -- From farlands, default:bush_stem
            output = "unilib:tree_exotic_wood",
            recipe = {
                {"unilib:bush_exotic_stem"},
            },
        })

    end
    unilib.register_craft({
        -- Original to unilib
        type = "fuel",
        recipe = "unilib:bush_exotic_stem",
        burntime = unilib.global.bush_burn_table.stem[burnlevel],
    })

    unilib.register_bush_leaves({
        -- From farlands, default:bush_leaves. Creates unilib:bush_exotic_leaves
        part_name = "exotic",
        orig_name = nil,

        replace_mode = mode,
        description = S("Exotic Bush Leaves"),
        img_list = {"unilib_tree_exotic_leaves_simple.png"},
    })
    -- (unilib.register_leafdecay() occurs below)

    unilib.register_node("unilib:bush_exotic_leaves_with_berry", "fruit:leaves_with_berry", mode, {
        -- From farlands, fruit:leaves_with_berry
        description = S("Exotic Bush Leaves with Berries"),
        tiles = {"unilib_tree_exotic_leaves_simple.png^unilib_fruit_berry_exotic_overlay.png"},
        groups = {leaves = 1, not_in_creative_inventory = 1, snappy = 3},
        sounds = unilib.global.sound_table.leaves,

        drawtype = "allfaces_optional",
        drop = "unilib:bush_exotic_leaves",
        paramtype = "light",
        special_tiles = {
            "unilib_tree_exotic_leaves_simple.png^unilib_fruit_berry_exotic_overlay.png",
        },

        on_destruct = function(pos)
            core.add_item(pos, "unilib:fruit_berry_exotic")
        end,

        on_rightclick = function(pos)
            core.set_node(pos, {name = "unilib:bush_exotic_leaves"})
        end,
    })

    if unilib.global.pkg_executed_table["shared_farlands_fruit"] ~= nil then

        -- Create the fruit-as-node variant for use in schematics, unilib:fruit_berry_exotic_node
        unilib.pkg.shared_farlands_fruit.create_fruit_nodes("berry", "food_berry")

    end

    unilib.register_leafdecay({
        -- From farlands, default:bush_leaves
        trunk_type = "exotic",
        trunks = {"unilib:bush_exotic_stem"},
        leaves = {"unilib:bush_exotic_leaves", "unilib:bush_exotic_leaves_with_berry"},
        -- N.B. required if the "shared_farlands_fruit" package is loaded
        others = {"unilib:fruit_berry_exotic_node"},
        radius = 2,
    })

    unilib.register_bush_sapling({
        -- From farlands, default:bush_sapling. Creates unilib:bush_exotic_sapling
        part_name = "exotic",
        orig_name = nil,

        replace_mode = mode,
        common_group = 2,
        description = S("Exotic Bush Sapling"),
        max_volume = 2,
        maxp_table = {x = 1, y = 1, z = 1},
        minp_table = {x = -1, y = 0, z = -1},
        offset_list = {1, 1, 1},
        select_table = {-4 / 16, -0.5, -4 / 16, 4 / 16, 2 / 16, 4 / 16},
    })
    unilib.register_craft({
        -- Original to unilib
        type = "fuel",
        recipe = "unilib:bush_exotic_sapling",
        burntime = unilib.global.bush_burn_table.sapling[burnlevel],
    })

    unilib.register_decoration_generic("farlands_bush_exotic_1", {
        -- From farlands, mapgen/mapgen.lua
        deco_type = "schematic",
        schematic = unilib.core.path_mod .. "/mts/unilib_bush_exotic.mts",

        flags = "place_center_x, place_center_z",
        noise_params = {
            octaves = 3,
            offset = -0.004,
            persist = 0.7,
            scale = 0.01,
            seed = 137,
            spread = {x = 100, y = 100, z = 100},
        },
        sidelen = 16,
    })

    unilib.register_decoration_generic("farlands_bush_exotic_2", {
        -- From farlands, mapgen/mapgen.lua
        deco_type = "schematic",
        schematic = unilib.core.path_mod .. "/mts/unilib_bush_exotic.mts",

        flags = "place_center_x, place_center_z",
        noise_params = {
            octaves = 3,
            offset = 0.01,
            persist = 0.7,
            scale = 0.015,
            seed = 137,
            spread = {x = 100, y = 100, z = 100},
        },
        sidelen = 16,
    })

end

function unilib.pkg.bush_exotic.post()

    if unilib.global.pkg_executed_table["shared_farlands_fruit"] ~= nil then

        unilib.register_regrowing_fruit({
            fruit_name = "unilib:fruit_berry_exotic_node",

            replace_mode = mode,
            leaves_list = {"unilib:bush_exotic_leaves"},
            pkg_list = {"bush_exotic"},
        })

    end

end
