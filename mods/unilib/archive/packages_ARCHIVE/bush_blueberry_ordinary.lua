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
minetest.register_node("default:blueberry_bush_leaves", {
    description = S("Blueberry Bush Leaves"),
    drawtype = "allfaces_optional",
    tiles = {"default_blueberry_bush_leaves.png"},
    paramtype = "light",
    groups = {snappy = 3, flammable = 2, leaves = 1},
    drop = {
        max_items = 1,
        items = {
            {items = {"default:blueberry_bush_sapling"}, rarity = 5},
            {items = {"default:blueberry_bush_leaves"}}
        }
    },
    sounds = default.node_sound_leaves_defaults(),

    on_timer = function(pos, elapsed)
        if minetest.get_node_light(pos) < 11 then
            minetest.get_node_timer(pos):start(200)
        else
            minetest.set_node(pos, {name = "default:blueberry_bush_leaves_with_berries"})
        end
    end,

    after_place_node = after_place_leaves,
})

minetest.register_node("default:blueberry_bush_leaves_with_berries", {
    description = S("Blueberry Bush Leaves with Berries"),
    drawtype = "allfaces_optional",
    tiles = {"default_blueberry_bush_leaves.png^default_blueberry_overlay.png"},
    paramtype = "light",
    groups = {snappy = 3, flammable = 2, leaves = 1, dig_immediate = 3},
    drop = "default:blueberries",
    sounds = default.node_sound_leaves_defaults(),
    node_dig_prediction = "default:blueberry_bush_leaves",

    after_dig_node = function(pos, oldnode, oldmetadata, digger)
        minetest.set_node(pos, {name = "default:blueberry_bush_leaves"})
        minetest.get_node_timer(pos):start(math.random(300, 1500))
    end,
})

minetest.register_node("default:blueberry_bush_sapling", {
    description = S("Blueberry Bush Sapling"),
    drawtype = "plantlike",
    tiles = {"default_blueberry_bush_sapling.png"},
    inventory_image = "default_blueberry_bush_sapling.png",
    wield_image = "default_blueberry_bush_sapling.png",
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
            "default:blueberry_bush_sapling",
            -- minp, maxp to be checked, relative to sapling pos
            {x = -1, y = 0, z = -1},
            {x = 1, y = 1, z = 1},
            -- maximum interval of interior volume check
            2)

        return itemstack
    end,
})

function default.grow_blueberry_bush(pos)
	local path = minetest.get_modpath("default") ..
		"/schematics/blueberry_bush.mts"
	minetest.place_schematic({x = pos.x - 1, y = pos.y, z = pos.z - 1},
		path, "0", nil, false)
end

minetest.register_decoration({
    name = "default:blueberry_bush",
    deco_type = "schematic",
    place_on = {"default:dirt_with_grass", "default:dirt_with_snow"},
    sidelen = 16,
    noise_params = {
        offset = -0.004,
        scale = 0.01,
        spread = {x = 100, y = 100, z = 100},
        seed = 697,
        octaves = 3,
        persist = 0.7,
    },
    biomes = {"grassland", "snowy_grassland"},
    y_max = 31000,
    y_min = 1,
    place_offset_y = 1,
    schematic = minetest.get_modpath("default") .. "/schematics/blueberry_bush.mts",
    flags = "place_center_x, place_center_z",
})
]]--
