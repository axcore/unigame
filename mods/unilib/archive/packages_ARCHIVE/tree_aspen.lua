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
minetest.register_node("default:aspen_tree", {
    description = S("Aspen Tree"),
    tiles = {"default_aspen_tree_top.png", "default_aspen_tree_top.png",
        "default_aspen_tree.png"},
    paramtype2 = "facedir",
    is_ground_content = false,
    groups = {tree = 1, choppy = 3, oddly_breakable_by_hand = 1, flammable = 3},
    sounds = default.node_sound_wood_defaults(),

    on_place = minetest.rotate_node
})
minetest.register_craft({
    type = "fuel",
    recipe = "default:aspen_tree",
    burntime = 22,
})

minetest.register_node("default:aspen_wood", {
    description = S("Aspen Wood Planks"),
    paramtype2 = "facedir",
    place_param2 = 0,
    tiles = {"default_aspen_wood.png"},
    is_ground_content = false,
    groups = {choppy = 3, oddly_breakable_by_hand = 2, flammable = 3, wood = 1},
    sounds = default.node_sound_wood_defaults(),
})
minetest.register_craft({
    output = "default:aspen_wood 4",
    recipe = {
        {"default:aspen_tree"},
    }
})
minetest.register_craft({
    type = "fuel",
    recipe = "default:aspen_wood",
    burntime = 5,
})
my_register_stair_and_slab(
    "aspen_wood",
    "default:aspen_wood",
    {choppy = 3, oddly_breakable_by_hand = 2, flammable = 3},
    {"default_aspen_wood.png"},
    "Aspen Wood Stair",
    "Aspen Wood Slab",
    default.node_sound_wood_defaults(),
    false
)

minetest.register_node("default:aspen_leaves", {
    description = S("Aspen Tree Leaves"),
    drawtype = "allfaces_optional",
    tiles = {"default_aspen_leaves.png"},
    waving = 1,
    paramtype = "light",
    is_ground_content = false,
    groups = {snappy = 3, leafdecay = 3, flammable = 2, leaves = 1},
    drop = {
        max_items = 1,
        items = {
            {items = {"default:aspen_sapling"}, rarity = 20},
            {items = {"default:aspen_leaves"}}
        }
    },
    sounds = default.node_sound_leaves_defaults(),

    after_place_node = after_place_leaves,
})
default.register_leafdecay({
    trunks = {"default:aspen_tree"},
    leaves = {"default:aspen_leaves"},
    radius = 3,
})

minetest.register_node("default:aspen_sapling", {
    description = S("Aspen Tree Sapling"),
    drawtype = "plantlike",
    tiles = {"default_aspen_sapling.png"},
    inventory_image = "default_aspen_sapling.png",
    wield_image = "default_aspen_sapling.png",
    paramtype = "light",
    sunlight_propagates = true,
    walkable = false,
    on_timer = grow_sapling,
    selection_box = {
        type = "fixed",
        fixed = {-3 / 16, -0.5, -3 / 16, 3 / 16, 0.5, 3 / 16}
    },
    groups = {snappy = 2, dig_immediate = 3, flammable = 3,
        attached_node = 1, sapling = 1},
    sounds = default.node_sound_leaves_defaults(),

    on_construct = function(pos)
        minetest.get_node_timer(pos):start(math.random(300, 1500))
    end,

    on_place = function(itemstack, placer, pointed_thing)
        itemstack = default.sapling_on_place(itemstack, placer, pointed_thing,
            "default:aspen_sapling",
            -- minp, maxp to be checked, relative to sapling pos
            -- minp_relative.y = 1 because sapling pos has been checked
            {x = -2, y = 1, z = -2},
            {x = 2, y = 12, z = 2},
            -- maximum interval of interior volume check
            4)

        return itemstack
    end,
})
minetest.register_craft({
    type = "fuel",
    recipe = "default:aspen_sapling",
    burntime = 4,
})
minetest.register_lbm({
    name = "default:convert_saplings_to_node_timer",
    nodenames = {"default:sapling", "default:junglesapling",
            "default:pine_sapling", "default:acacia_sapling",
            "default:aspen_sapling"},
    action = function(pos)
        minetest.get_node_timer(pos):start(math.random(300, 1500))
    end
})

function default.grow_new_aspen_tree(pos)
    local path = minetest.get_modpath("default") ..
        "/schematics/aspen_tree_from_sapling.mts"
    minetest.place_schematic({x = pos.x - 2, y = pos.y - 1, z = pos.z - 2},
        path, "0", nil, false)
end

local nodes = {
    ["all_faces_aspen_tree"] = {
        description = S("All-faces Aspen Tree"),
        tiles = {"default_aspen_tree_top.png"},
        groups = {tree = 1, choppy = 3, oddly_breakable_by_hand = 1, flammable = 3},
        sounds = sound_wood,
        furnace_burntime = 22,
    },
}
minetest.register_craft({
    output = "moreblocks:all_faces_aspen_tree 8",
    recipe = {
        {"default:aspen_tree", "default:aspen_tree", "default:aspen_tree"},
        {"default:aspen_tree", "", "default:aspen_tree"},
        {"default:aspen_tree", "default:aspen_tree", "default:aspen_tree"},
    }
})

default.register_fence("default:fence_aspen_wood", {
    description = S("Aspen Wood Fence"),
    texture = "default_fence_aspen_wood.png",
    inventory_image = "default_fence_overlay.png^default_aspen_wood.png^" ..
                "default_fence_overlay.png^[makealpha:255,126,126",
    wield_image = "default_fence_overlay.png^default_aspen_wood.png^" ..
                "default_fence_overlay.png^[makealpha:255,126,126",
    material = "default:aspen_wood",
    groups = {choppy = 3, oddly_breakable_by_hand = 2, flammable = 3},
    sounds = default.node_sound_wood_defaults()
})
minetest.register_craft({
    type = "fuel",
    recipe = "default:fence_aspen_wood",
    burntime = 5,
})

default.register_fence_rail("default:fence_rail_aspen_wood", {
    description = S("Aspen Wood Fence Rail"),
    texture = "default_fence_rail_aspen_wood.png",
    inventory_image = "default_fence_rail_overlay.png^default_aspen_wood.png^" ..
                "default_fence_rail_overlay.png^[makealpha:255,126,126",
    wield_image = "default_fence_rail_overlay.png^default_aspen_wood.png^" ..
                "default_fence_rail_overlay.png^[makealpha:255,126,126",
    material = "default:aspen_wood",
    groups = {choppy = 3, oddly_breakable_by_hand = 2, flammable = 2},
    sounds = default.node_sound_wood_defaults()
})
minetest.register_craft({
    type = "fuel",
    recipe = "default:fence_rail_aspen_wood",
    burntime = 3,
})

doors.register_fencegate("doors:gate_aspen_wood", {
    description = S("Aspen Wood Fence Gate"),
    texture = "default_aspen_wood.png",
    material = "default:aspen_wood",
    groups = {choppy = 3, oddly_breakable_by_hand = 2, flammable = 3}
})
minetest.register_craft({
    type = "fuel",
    recipe = "doors:gate_aspen_wood_closed",
    burntime = 5,
})

minetest.register_decoration({
    name = "default:aspen_tree",
    deco_type = "schematic",
    place_on = {"default:dirt_with_grass"},
    sidelen = 16,
    noise_params = {
        offset = 0.0,
        scale = -0.015,
        spread = {x = 250, y = 250, z = 250},
        seed = 2,
        octaves = 3,
        persist = 0.66
    },
    biomes = {"deciduous_forest"},
    y_max = 31000,
    y_min = 1,
    schematic = minetest.get_modpath("default") .. "/schematics/aspen_tree.mts",
    flags = "place_center_x, place_center_z",
})

minetest.register_decoration({
    name = "default:aspen_log",
    deco_type = "schematic",
    place_on = {"default:dirt_with_grass"},
    place_offset_y = 1,
    sidelen = 16,
    noise_params = {
        offset = 0.0,
        scale = -0.0008,
        spread = {x = 250, y = 250, z = 250},
        seed = 2,
        octaves = 3,
        persist = 0.66
    },
    biomes = {"deciduous_forest"},
    y_max = 31000,
    y_min = 1,
    schematic = minetest.get_modpath("default") .. "/schematics/aspen_log.mts",
    flags = "place_center_x",
    rotation = "random",
    spawn_by = "default:dirt_with_grass",
    num_spawn_by = 8,
})    
]]--
