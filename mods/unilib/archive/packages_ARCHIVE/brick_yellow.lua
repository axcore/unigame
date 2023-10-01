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
minetest.register_node ("morebricks:yellow", {
    description = S("Yellow Brick Block"),
    tiles = {"morebricks_yellow.png"},
    is_ground_content = false,
    sounds = default.node_sound_stone_defaults(),
    groups = {cracky = 2, level = 1},
    light_source = 0,
})
minetest.register_craft({
    output = "morebricks:yellow 3",
    recipe = {
        {"default:clay_brick", "default:clay_brick", "bakedclay:yellow"},
        {"default:clay_brick", "default:clay_brick", "bakedclay:yellow"},
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
    output = "morebricks:yellowvertical 1",
    recipe = {
        {"", "", ""},
        {"", "morebricks:yellow", ""},
        {"", "", ""},
    }
})
minetest.register_craft({
    output = "morebricks:yellow 1",
    recipe = {
        {"", "", ""},
        {"", "morebricks:yellowvertical", ""},
        {"", "", ""},
    }
})

minetest.register_node ("morebricks:yellowaged", {
    description = S("Aged Yellow Brick Block"),
    tiles = {"morebricks_yellowaged.png"},
    is_ground_content = false,
    sounds = default.node_sound_stone_defaults(),
    groups = {cracky = 2, level = 1},
    light_source = 0,
})
minetest.register_craft({
    output = "morebricks:yellowaged 3",
    recipe = {
        {"default:clay_brick", "default:clay_brick", "bakedclay:yellow"},
        {"default:clay_brick", "default:clay_brick", "bakedclay:yellow"},
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
    output = "morebricks:yellowagedvertical 1",
    recipe = {
        {"", "", ""},
        {"", "morebricks:yellowaged", ""},
        {"", "", ""},
    }
})
minetest.register_craft({
    output = "morebricks:yellowaged 1",
    recipe = {
        {"", "", ""},
        {"", "morebricks:yellowagedvertical", ""},
        {"", "", ""},
    }
})
]]--
