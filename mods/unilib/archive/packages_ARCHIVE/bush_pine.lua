---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("default:pine_bush_stem", {
    description = S("Pine Bush Stem"),
    drawtype = "plantlike",
    visual_scale = 1.41,
    tiles = {"default_pine_bush_stem.png"},
    inventory_image = "default_pine_bush_stem.png",
    wield_image = "default_pine_bush_stem.png",
    paramtype = "light",
    sunlight_propagates = true,
    groups = {choppy = 2, oddly_breakable_by_hand = 1, flammable = 2},
    sounds = default.node_sound_wood_defaults(),
    selection_box = {
        type = "fixed",
        fixed = {-7 / 16, -0.5, -7 / 16, 7 / 16, 0.5, 7 / 16},
    },
})
minetest.register_craft({
    output = "default:pine_wood",
    recipe = {
        {"default:pine_bush_stem"},
    }
})
minetest.register_craft({
    type = "fuel",
    recipe = "default:pine_bush_stem",
    burntime = 6,
})

minetest.register_node("default:pine_bush_needles", {
    description = S("Pine Bush Needles"),
    drawtype = "allfaces_optional",
    tiles = {"default_pine_needles.png"},
    paramtype = "light",
    groups = {snappy = 3, flammable = 2, leaves = 1},
    drop = {
        max_items = 1,
        items = {
            {items = {"default:pine_bush_sapling"}, rarity = 5},
            {items = {"default:pine_bush_needles"}}
        }
    },
    sounds = default.node_sound_leaves_defaults(),

    after_place_node = after_place_leaves,
})
default.register_leafdecay({
    trunks = {"default:pine_bush_stem"},
    leaves = {"default:pine_bush_needles"},
    radius = 1,
})

minetest.register_node("default:pine_bush_sapling", {
    description = S("Pine Bush Sapling"),
    drawtype = "plantlike",
    tiles = {"default_pine_bush_sapling.png"},
    inventory_image = "default_pine_bush_sapling.png",
    wield_image = "default_pine_bush_sapling.png",
    paramtype = "light",
    sunlight_propagates = true,
    walkable = false,
    on_timer = grow_sapling,
    selection_box = {
        type = "fixed",
        fixed = {-4 / 16, -0.5, -4 / 16, 4 / 16, 2 / 16, 4 / 16}
    },
    groups = {snappy = 2, dig_immediate = 3, flammable = 2,
        attached_node = 1, sapling = 1},
    sounds = default.node_sound_leaves_defaults(),

    on_construct = function(pos)
        minetest.get_node_timer(pos):start(math.random(300, 1500))
    end,

    on_place = function(itemstack, placer, pointed_thing)
        itemstack = default.sapling_on_place(itemstack, placer, pointed_thing,
            "default:pine_bush_sapling",
            -- minp, maxp to be checked, relative to sapling pos
            {x = -1, y = 0, z = -1},
            {x = 1, y = 1, z = 1},
            -- maximum interval of interior volume check
            2)

        return itemstack
    end,
})
minetest.register_craft({
    type = "fuel",
    recipe = "default:pine_bush_sapling",
    burntime = 2,
})

function default.grow_pine_bush(pos)
	local path = minetest.get_modpath("default") ..
		"/schematics/pine_bush.mts"
	minetest.place_schematic({x = pos.x - 1, y = pos.y - 1, z = pos.z - 1},
		path, "0", nil, false)
end

minetest.register_decoration({
    name = "default:pine_bush",
    deco_type = "schematic",
    place_on = {"default:dirt_with_snow"},
    sidelen = 16,
    noise_params = {
        offset = -0.004,
        scale = 0.01,
        spread = {x = 100, y = 100, z = 100},
        seed = 137,
        octaves = 3,
        persist = 0.7,
    },
    biomes = {"taiga", "snowy_grassland"},
    y_max = 31000,
    y_min = 4,
    schematic = minetest.get_modpath("default") .. "/schematics/pine_bush.mts",
    flags = "place_center_x, place_center_z",
})
]]--
