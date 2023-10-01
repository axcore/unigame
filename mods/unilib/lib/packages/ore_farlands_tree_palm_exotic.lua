---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.ore_farlands_tree_palm_exotic = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ore_farlands_tree_palm_exotic.init()

    return {
        description = "Exotic palm tree leaves with fruit, implemented as an ore",
        depends = {"fruit_coconut_exotic", "tree_palm_exotic"},
    }

end

function unilib.pkg.ore_farlands_tree_palm_exotic.exec()

    unilib.register_node(
        -- From farlands, fruit:palm_leaves_coconut
        "unilib:tree_palm_exotic_leaves_with_coconut",
        "fruit:palm_leaves_coconut",
        mode,
        {
            description = S("Exotic Palm Tree Leaves with Coconuts"),
            tiles = {"unilib_tree_palm_exotic_leaves_with_coconut.png"},
            -- N.B. added not_in_creative_inventory for consistency with other farlands stuff
            groups = {
                flammable = 1, leafdecay = 3, leaves = 1, not_in_creative_inventory = 1, snappy = 2,
            },
            sounds = unilib.sound_table.leaves,

            drawtype = "allfaces_optional",
            paramtype = "light",
            special_tiles = {"unilib_tree_palm_exotic_leaves_with_coconut.png"},
            waving = 1,

            on_destruct = function(pos, oldnode)
                minetest.add_item(pos, "unilib:fruit_coconut_exotic")
            end,

            on_rightclick = function(pos)
                minetest.set_node(pos, {name = "unilib:tree_palm_exotic_leaves"})
            end,
        }
    )

end

function unilib.pkg.ore_farlands_tree_palm_exotic.post()

    unilib.register_ore({
        -- From farlands, fruit/init.lua
        ore_type                = "scatter",
        ore                     = "unilib:tree_palm_exotic_leaves_with_coconut",
        wherein                 = "unilib:tree_palm_exotic_leaves",

        clust_num_ores          = 4,
        clust_scarcity          = 5 * 5 * 5,
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
