---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
--
-- From:    doors
-- Code:    MIT
-- Media:   CC BY-SA 3.0
--
-- From:    moreblocks
-- Code:    zlib
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("default:tree", {
    description = S("Apple Tree"),
    tiles = {"default_tree_top.png", "default_tree_top.png", "default_tree.png"},
    paramtype2 = "facedir",
    is_ground_content = false,
    groups = {tree = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2},
    sounds = default.node_sound_wood_defaults(),

    on_place = minetest.rotate_node
})
-- Support use of group:tree, includes default:tree which has the same burn time
minetest.register_craft({
    type = "fuel",
    recipe = "group:tree",
    burntime = 30,
})

minetest.register_node("default:wood", {
    description = S("Apple Wood Planks"),
    paramtype2 = "facedir",
    place_param2 = 0,
    tiles = {"default_wood.png"},
    is_ground_content = false,
    groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2, wood = 1},
    sounds = default.node_sound_wood_defaults(),
})
minetest.register_craft({
    output = "default:wood 4",
    recipe = {
        {"default:tree"},
    }
})
minetest.register_craft({
    type = "fuel",
    recipe = "group:wood",
    burntime = 7,
})
minetest.register_craft({
	output = "default:wood",
	recipe = {
		{"default:stick", "default:stick"},
		{"default:stick", "default:stick"},
	}
})
my_register_stair_and_slab(
    "wood",
    "default:wood",
    {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
    {"default_wood.png"},
    "Wooden Stair",
    "Wooden Slab",
    default.node_sound_wood_defaults(),
    false
)

minetest.register_node("default:leaves", {
    description = S("Apple Tree Leaves"),
    drawtype = "allfaces_optional",
    waving = 1,
    tiles = {"default_leaves.png"},
    special_tiles = {"default_leaves_simple.png"},
    paramtype = "light",
    is_ground_content = false,
    groups = {snappy = 3, leafdecay = 3, flammable = 2, leaves = 1},
    drop = {
        max_items = 1,
        items = {
            {
                -- player will get sapling with 1/20 chance
                items = {"default:sapling"},
                rarity = 20,
            },
            {
                -- player will get leaves only if he get no saplings,
                -- this is because max_items is 1
                items = {"default:leaves"},
            }
        }
    },
    sounds = default.node_sound_leaves_defaults(),

    after_place_node = after_place_leaves,
})
default.register_leafdecay({
    trunks = {"default:tree"},
    leaves = {"default:apple", "default:leaves"},
    radius = 3,
})

minetest.register_node("default:sapling", {
    description = S("Apple Tree Sapling"),
    drawtype = "plantlike",
    tiles = {"default_sapling.png"},
    inventory_image = "default_sapling.png",
    wield_image = "default_sapling.png",
    paramtype = "light",
    sunlight_propagates = true,
    walkable = false,
    on_timer = grow_sapling,
    selection_box = {
        type = "fixed",
        fixed = {-4 / 16, -0.5, -4 / 16, 4 / 16, 7 / 16, 4 / 16}
    },
    groups = {snappy = 2, dig_immediate = 3, flammable = 2,
        attached_node = 1, sapling = 1},
    sounds = default.node_sound_leaves_defaults(),

    on_construct = function(pos)
        minetest.get_node_timer(pos):start(math.random(300, 1500))
    end,

    on_place = function(itemstack, placer, pointed_thing)
        itemstack = default.sapling_on_place(itemstack, placer, pointed_thing,
            "default:sapling",
            -- minp, maxp to be checked, relative to sapling pos
            -- minp_relative.y = 1 because sapling pos has been checked
            {x = -3, y = 1, z = -3},
            {x = 3, y = 6, z = 3},
            -- maximum interval of interior volume check
            4)

        return itemstack
    end,
})

function default.grow_new_apple_tree(pos)
    local path = minetest.get_modpath("default") ..
        "/schematics/apple_tree_from_sapling.mts"
    minetest.place_schematic({x = pos.x - 3, y = pos.y - 1, z = pos.z - 3},
        path, "random", nil, false)
end

local nodes = {
	["all_faces_tree"] = {
		description = S("All-faces Tree"),
		tiles = {"default_tree_top.png"},
		groups = {tree = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2},
		sounds = sound_wood,
		furnace_burntime = 30,
	},
}
minetest.register_craft({
	output = "moreblocks:all_faces_tree 8",
	recipe = {
		{"default:tree", "default:tree", "default:tree"},
		{"default:tree", "", "default:tree"},
		{"default:tree", "default:tree", "default:tree"},
	}
})

default.register_fence("default:fence_wood", {
    description = S("Apple Wood Fence"),
    texture = "default_fence_wood.png",
    inventory_image = "default_fence_overlay.png^default_wood.png^" ..
                "default_fence_overlay.png^[makealpha:255,126,126",
    wield_image = "default_fence_overlay.png^default_wood.png^" ..
                "default_fence_overlay.png^[makealpha:255,126,126",
    material = "default:wood",
    groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
    sounds = default.node_sound_wood_defaults()
})
minetest.register_craft({
    type = "fuel",
    recipe = "default:fence_wood",
    burntime = 7,
})

default.register_fence_rail("default:fence_rail_wood", {
    description = S("Apple Wood Fence Rail"),
    texture = "default_fence_rail_wood.png",
    inventory_image = "default_fence_rail_overlay.png^default_wood.png^" ..
                "default_fence_rail_overlay.png^[makealpha:255,126,126",
    wield_image = "default_fence_rail_overlay.png^default_wood.png^" ..
                "default_fence_rail_overlay.png^[makealpha:255,126,126",
    material = "default:wood",
    groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
    sounds = default.node_sound_wood_defaults()
})
minetest.register_craft({
    type = "fuel",
    recipe = "default:fence_rail_wood",
    burntime = 5,
})

doors.register_fencegate("doors:gate_wood", {
    description = S("Apple Wood Fence Gate"),
    texture = "default_wood.png",
    material = "default:wood",
    groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2}
})
minetest.register_craft({
    type = "fuel",
    recipe = "doors:gate_wood_closed",
    burntime = 7,
})

minetest.register_decoration({
    name = "default:apple_tree",
    deco_type = "schematic",
    place_on = {"default:dirt_with_grass"},
    sidelen = 16,
    noise_params = {
        offset = 0.024,
        scale = 0.015,
        spread = {x = 250, y = 250, z = 250},
        seed = 2,
        octaves = 3,
        persist = 0.66
    },
    biomes = {"deciduous_forest"},
    y_max = 31000,
    y_min = 1,
    schematic = minetest.get_modpath("default") .. "/schematics/apple_tree.mts",
    flags = "place_center_x, place_center_z",
    rotation = "random",
})

minetest.register_decoration({
    name = "default:apple_log",
    deco_type = "schematic",
    place_on = {"default:dirt_with_grass"},
    place_offset_y = 1,
    sidelen = 16,
    noise_params = {
        offset = 0.0012,
        scale = 0.0007,
        spread = {x = 250, y = 250, z = 250},
        seed = 2,
        octaves = 3,
        persist = 0.66
    },
    biomes = {"deciduous_forest"},
    y_max = 31000,
    y_min = 1,
    schematic = minetest.get_modpath("default") .. "/schematics/apple_log.mts",
    flags = "place_center_x",
    rotation = "random",
    spawn_by = "default:dirt_with_grass",
    num_spawn_by = 8,
})
]]--
