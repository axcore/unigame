---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.ore_farlands_tree_acacia_exotic = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ore_farlands_tree_acacia_exotic.init()

    return {
        description = "Exotic acacia tree leaves with fruit, implemented as an ore",
        depends = {"fruit_orange_exotic", "tree_acacia_exotic"},
    }

end

function unilib.pkg.ore_farlands_tree_acacia_exotic.exec()

    unilib.register_node(
        -- From farlands, fruit:leaves_with_orange
        "unilib:tree_acacia_exotic_leaves_with_orange",
        "fruit:leaves_with_orange",
        mode,
        {
            description = S("Exotic Acacia Leaves with Oranges"),
            tiles = {"unilib_tree_acacia_exotic_leaves.png^unilib_fruit_orange_exotic_overlay.png"},
            groups = {leaves = 1, not_in_creative_inventory = 1, snappy = 3},
            sounds = unilib.sound_table.leaves,

            drawtype = "allfaces_optional",
            drop = "unilib:tree_acacia_exotic_leaves",
            paramtype = "light",
            special_tiles = {
                "unilib_tree_acacia_exotic_leaves_simple.png^unilib_fruit_orange_exotic_overlay.png"
            },
            waving = 1,

            on_destruct = function(pos)
                minetest.add_item(pos, "unilib:fruit_orange_exotic")
            end,

            on_rightclick = function(pos)
                minetest.set_node(pos, {name = "unilib:tree_acacia_exotic_leaves"})
            end,
        }
    )

end

function unilib.pkg.ore_farlands_tree_acacia_exotic.post()

    unilib.register_ore({
        -- From farlands, fruit/init.lua
        ore_type                = "scatter",
        ore                     = "unilib:tree_acacia_exotic_leaves_with_orange",
        wherein                 = "unilib:tree_acacia_exotic_leaves",

        clust_num_ores          = 6,
        clust_scarcity          = 15 * 15 * 15,
        clust_size              = 4,
        noise_params            = {
            octaves = 1,
            offset = 0.5,
            persist = 0.0,
            scale = 1,
            seed = 766,
            spread = {x = 5, y = 5, z = 5},
        },
        y_max                   = unilib.y_max,
        y_min                   = 0,
    })

end
