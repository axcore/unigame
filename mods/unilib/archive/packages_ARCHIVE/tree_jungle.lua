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
minetest.register_node("default:jungletree", {
    description = S("Jungle Tree"),
    tiles = {"default_jungletree_top.png", "default_jungletree_top.png",
        "default_jungletree.png"},
    paramtype2 = "facedir",
    is_ground_content = false,
    groups = {tree = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2},
    sounds = default.node_sound_wood_defaults(),

    on_place = minetest.rotate_node
})
minetest.register_craft({
    type = "fuel",
    recipe = "default:jungletree",
    burntime = 38,
})

minetest.register_node("default:junglewood", {
    description = S("Jungle Wood Planks"),
    paramtype2 = "facedir",
    place_param2 = 0,
    tiles = {"default_junglewood.png"},
    is_ground_content = false,
    groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2, wood = 1},
    sounds = default.node_sound_wood_defaults(),
})
minetest.register_craft({
    output = "default:junglewood 4",
    recipe = {
        {"default:jungletree"},
    }
})
minetest.register_craft({
    type = "fuel",
    recipe = "default:junglewood",
    burntime = 9,
})
my_register_stair_and_slab(
    "junglewood",
    "default:junglewood",
    {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
    {"default_junglewood.png"},
    "Jungle Wood Stair",
    "Jungle Wood Slab",
    default.node_sound_wood_defaults(),
    false
)

minetest.register_node("default:jungleleaves", {
    description = S("Jungle Tree Leaves"),
    drawtype = "allfaces_optional",
    waving = 1,
    tiles = {"default_jungleleaves.png"},
    special_tiles = {"default_jungleleaves_simple.png"},
    paramtype = "light",
    is_ground_content = false,
    groups = {snappy = 3, leafdecay = 3, flammable = 2, leaves = 1},
    drop = {
        max_items = 1,
        items = {
            {items = {"default:junglesapling"}, rarity = 20},
            {items = {"default:jungleleaves"}}
        }
    },
    sounds = default.node_sound_leaves_defaults(),

    after_place_node = after_place_leaves,
})
default.register_leafdecay({
    trunks = {"default:jungletree"},
    leaves = {"default:jungleleaves"},
    radius = 2,
})

minetest.register_node("default:junglesapling", {
    description = S("Jungle Tree Sapling"),
    drawtype = "plantlike",
    tiles = {"default_junglesapling.png"},
    inventory_image = "default_junglesapling.png",
    wield_image = "default_junglesapling.png",
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
            "default:junglesapling",
            -- minp, maxp to be checked, relative to sapling pos
            -- minp_relative.y = 1 because sapling pos has been checked
            {x = -2, y = 1, z = -2},
            {x = 2, y = 15, z = 2},
            -- maximum interval of interior volume check
            4)

        return itemstack
    end,
})
minetest.register_craft({
    type = "fuel",
    recipe = "default:junglesapling",
    burntime = 6,
})

minetest.register_node("default:emergent_jungle_sapling", {
    description = S("Emergent Jungle Tree Sapling"),
    drawtype = "plantlike",
    tiles = {"default_emergent_jungle_sapling.png"},
    inventory_image = "default_emergent_jungle_sapling.png",
    wield_image = "default_emergent_jungle_sapling.png",
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
            "default:emergent_jungle_sapling",
            -- minp, maxp to be checked, relative to sapling pos
            {x = -3, y = -5, z = -3},
            {x = 3, y = 31, z = 3},
            -- maximum interval of interior volume check
            4)

        return itemstack
    end,
})
minetest.register_craft({
    output = "default:emergent_jungle_sapling",
    recipe = {
        {"default:junglesapling", "default:junglesapling", "default:junglesapling"},
        {"default:junglesapling", "default:junglesapling", "default:junglesapling"},
        {"default:junglesapling", "default:junglesapling", "default:junglesapling"},
    }
})
minetest.register_craft({
    type = "fuel",
    recipe = "default:emergent_jungle_sapling",
    burntime = 7,
})

-- New jungle tree
function default.grow_new_jungle_tree(pos)
	local path = minetest.get_modpath("default") ..
		"/schematics/jungle_tree_from_sapling.mts"
	minetest.place_schematic({x = pos.x - 2, y = pos.y - 1, z = pos.z - 2},
		path, "random", nil, false)
end


-- New emergent jungle tree
function default.grow_new_emergent_jungle_tree(pos)
	local path = minetest.get_modpath("default") ..
		"/schematics/emergent_jungle_tree_from_sapling.mts"
	minetest.place_schematic({x = pos.x - 3, y = pos.y - 5, z = pos.z - 3},
		path, "random", nil, false)
end

local nodes = {
	["all_faces_jungle_tree"] = {
		description = S("All-faces Jungle Tree"),
		tiles = {"default_jungletree_top.png"},
		groups = {tree = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2},
		sounds = sound_wood,
		furnace_burntime = 38,
	},
}
minetest.register_craft({
	output = "moreblocks:all_faces_jungle_tree 8",
	recipe = {
		{"default:jungletree", "default:jungletree", "default:jungletree"},
		{"default:jungletree", "", "default:jungletree"},
		{"default:jungletree", "default:jungletree", "default:jungletree"},
	}
})

default.register_fence("default:fence_junglewood", {
    description = S("Jungle Wood Fence"),
    texture = "default_fence_junglewood.png",
    inventory_image = "default_fence_overlay.png^default_junglewood.png^" ..
                "default_fence_overlay.png^[makealpha:255,126,126",
    wield_image = "default_fence_overlay.png^default_junglewood.png^" ..
                "default_fence_overlay.png^[makealpha:255,126,126",
    material = "default:junglewood",
    groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
    sounds = default.node_sound_wood_defaults()
})
minetest.register_craft({
    type = "fuel",
    recipe = "default:fence_junglewood",
    burntime = 9,
})

default.register_fence_rail("default:fence_rail_junglewood", {
    description = S("Jungle Wood Fence Rail"),
    texture = "default_fence_rail_junglewood.png",
    inventory_image = "default_fence_rail_overlay.png^default_junglewood.png^" ..
                "default_fence_rail_overlay.png^[makealpha:255,126,126",
    wield_image = "default_fence_rail_overlay.png^default_junglewood.png^" ..
                "default_fence_rail_overlay.png^[makealpha:255,126,126",
    material = "default:junglewood",
    groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
    sounds = default.node_sound_wood_defaults()
})
minetest.register_craft({
    type = "fuel",
    recipe = "default:fence_rail_junglewood",
    burntime = 7,
})

doors.register_fencegate("doors:gate_junglewood", {
	description = S("Jungle Wood Fence Gate"),
	texture = "default_junglewood.png",
	material = "default:junglewood",
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2}
})
minetest.register_craft({
	type = "fuel",
	recipe = "doors:gate_junglewood_closed",
	burntime = 9,
})

-- Jungle tree
minetest.register_decoration({
    name = "default:jungle_tree",
    deco_type = "schematic",
    place_on = {"default:dirt_with_rainforest_litter"},
    sidelen = 80,
    fill_ratio = 0.1,
    biomes = {"rainforest"},
    y_max = 31000,
    y_min = 1,
    schematic = minetest.get_modpath("default") .. "/schematics/jungle_tree.mts",
    flags = "place_center_x, place_center_z",
    rotation = "random",
})

-- Emergent jungle tree
-- Due to 32 node height, altitude is limited and prescence depends on chunksize
local chunksize = tonumber(minetest.get_mapgen_setting("chunksize"))
if chunksize >= 5 then
    minetest.register_decoration({
        name = "default:emergent_jungle_tree",
        deco_type = "schematic",
        place_on = {"default:dirt_with_rainforest_litter"},
        sidelen = 80,
        noise_params = {
            offset = 0.0,
            scale = 0.0025,
            spread = {x = 250, y = 250, z = 250},
            seed = 2685,
            octaves = 3,
            persist = 0.7
        },
        biomes = {"rainforest"},
        y_max = 32,
        y_min = 1,
        schematic = minetest.get_modpath("default") ..
                "/schematics/emergent_jungle_tree.mts",
        flags = "place_center_x, place_center_z",
        rotation = "random",
        place_offset_y = -4,
    })
end

-- Swamp jungle trees
minetest.register_decoration({
    name = "default:jungle_tree(swamp)",
    deco_type = "schematic",
    place_on = {"default:dirt"},
    sidelen = 16,
    -- Noise tuned to place swamp trees where papyrus is absent
    noise_params = {
        offset = 0.0,
        scale = -0.1,
        spread = {x = 200, y = 200, z = 200},
        seed = 354,
        octaves = 1,
        persist = 0.5
    },
    biomes = {"rainforest_swamp"},
    y_max = 0,
    y_min = -1,
    schematic = minetest.get_modpath("default") .. "/schematics/jungle_tree.mts",
    flags = "place_center_x, place_center_z",
    rotation = "random",
})

-- Jungle log
minetest.register_decoration({
    name = "default:jungle_log",
    deco_type = "schematic",
    place_on = {"default:dirt_with_rainforest_litter"},
    place_offset_y = 1,
    sidelen = 80,
    fill_ratio = 0.005,
    biomes = {"rainforest"},
    y_max = 31000,
    y_min = 1,
    schematic = minetest.get_modpath("default") .. "/schematics/jungle_log.mts",
    flags = "place_center_x",
    rotation = "random",
    spawn_by = "default:dirt_with_rainforest_litter",
    num_spawn_by = 8,
})
]]--
