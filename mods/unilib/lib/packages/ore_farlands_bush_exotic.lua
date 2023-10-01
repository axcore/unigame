---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.ore_farlands_bush_exotic = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ore_farlands_bush_exotic.init()

    return {
        description = "Exotic bush leaves with fruit, implemented as an ore",
        depends = {"bush_exotic", "fruit_berry_exotic"},
    }

end

function unilib.pkg.ore_farlands_bush_exotic.exec()

    local img = "unilib_tree_exotic_leaves_simple.png^unilib_fruit_berry_exotic_overlay.png"

    unilib.register_node("unilib:bush_exotic_leaves_with_berry", "fruit:leaves_with_berry", mode, {
        -- From farlands, fruit:leaves_with_berry
        description = S("Exotic Bush Leaves with Berries"),
        tiles = {img},
        groups = {leaves = 1, not_in_creative_inventory = 1, snappy = 3},
        sounds = unilib.sound_table.leaves,

        drawtype = "allfaces_optional",
        drop = "unilib:bush_exotic_leaves",
        paramtype = "light",
        special_tiles = {img},

        on_destruct = function(pos)
            minetest.add_item(pos, "unilib:fruit_berry_exotic")
        end,

        on_rightclick = function(pos)
            minetest.set_node(pos, {name = "unilib:bush_exotic_leaves"})
        end,
    })

end

function unilib.pkg.ore_farlands_bush_exotic.post()

    unilib.register_ore({
        -- From farlands, fruit/init.lua
        ore_type                = "scatter",
        ore                     = "unilib:bush_exotic_leaves_with_berry",
        wherein                 = "unilib:bush_exotic_leaves",

        clust_num_ores          = 6,
        clust_scarcity          = 10 * 10 * 10,
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
