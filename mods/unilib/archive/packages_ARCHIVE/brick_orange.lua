---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    morebricks
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node ("morebricks:orange", {
    description = S("Orange Brick Block"),
    tiles = {"morebricks_orange.png"},
    is_ground_content = false,
    sounds = default.node_sound_stone_defaults(),
    groups = {cracky = 2, level = 1},
    light_source = 0,
})
minetest.register_craft({
    output = "morebricks:orange 3",
    recipe = {
        {"default:clay_brick", "default:clay_brick", "bakedclay:orange"},
        {"default:clay_brick", "default:clay_brick", "bakedclay:orange"},
        {"", "", ""},
    }
})

minetest.register_node("morebricks:" .. brick[1], {
    description = brick[2] .. " Brick Block",
    tiles = {"morebricks_" .. brick[1] ..".png"},
    groups = {cracky = 3, bakedclay = 1},
    sounds = default.node_sound_stone_defaults(),
})
minetest.register_craft({
    output = "morebricks:orangevertical 1",
    recipe = {
        {"", "", ""},
        {"", "morebricks:orange", ""},
        {"", "", ""},
    }
})
minetest.register_craft({
    output = "morebricks:orange 1",
    recipe = {
        {"", "", ""},
        {"", "morebricks:orangevertical", ""},
        {"", "", ""},
    }
})

minetest.register_node ("morebricks:orangeaged", {
    description = S("Aged Orange Brick Block"),
    tiles = {"morebricks_orangeaged.png"},
    is_ground_content = false,
    sounds = default.node_sound_stone_defaults(),
    groups = {cracky = 2, level = 1},
    light_source = 0,
})
minetest.register_craft({
    output = "morebricks:orangeaged 3",
    recipe = {
        {"default:clay_brick", "default:clay_brick", "bakedclay:orange"},
        {"default:clay_brick", "default:clay_brick", "bakedclay:orange"},
        {"", "default:dirt", ""},
    }
})

minetest.register_node("morebricks:" .. brick[1], {
    description = brick[2] .. " Brick Block",
    tiles = {"morebricks_" .. brick[1] ..".png"},
    groups = {cracky = 3, bakedclay = 1},
    sounds = default.node_sound_stone_defaults(),
})
minetest.register_craft({
    output = "morebricks:orangeagedvertical 1",
    recipe = {
        {"", "", ""},
        {"", "morebricks:orangeaged", ""},
        {"", "", ""},
    }
})
minetest.register_craft({
    output = "morebricks:orangeaged 1",
    recipe = {
        {"", "", ""},
        {"", "morebricks:orangeagedvertical", ""},
        {"", "", ""},
    }
})
]]--
