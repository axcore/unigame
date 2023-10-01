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
minetest.register_node ("morebricks:cyan", {
    description = S("Cyan Brick Block"),
    tiles = {"morebricks_cyan.png"},
    is_ground_content = false,
    sounds = default.node_sound_stone_defaults(),
    groups = {cracky = 2, level = 1},
    light_source = 0,
})
minetest.register_craft({
    output = "morebricks:cyan 3",
    recipe = {
        {"default:clay_brick", "default:clay_brick", "bakedclay:cyan"},
        {"default:clay_brick", "default:clay_brick", "bakedclay:cyan"},
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
    output = "morebricks:cyanvertical 1",
    recipe = {
        {"", "", ""},
        {"", "morebricks:cyan", ""},
        {"", "", ""},
    }
})
minetest.register_craft({
    output = "morebricks:cyan 1",
    recipe = {
        {"", "", ""},
        {"", "morebricks:cyanvertical", ""},
        {"", "", ""},
    }
})

minetest.register_node ("morebricks:cyanaged", {
    description = S("Aged Cyan Brick Block"),
    tiles = {"morebricks_cyanaged.png"},
    is_ground_content = false,
    sounds = default.node_sound_stone_defaults(),
    groups = {cracky = 2, level = 1},
    light_source = 0,
})
minetest.register_craft({
    output = "morebricks:cyanaged 3",
    recipe = {
        {"default:clay_brick", "default:clay_brick", "bakedclay:cyan"},
        {"default:clay_brick", "default:clay_brick", "bakedclay:cyan"},
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
    output = "morebricks:cyanagedvertical 1",
    recipe = {
        {"", "", ""},
        {"", "morebricks:cyanaged", ""},
        {"", "", ""},
    }
})
minetest.register_craft({
    output = "morebricks:cyanaged 1",
    recipe = {
        {"", "", ""},
        {"", "morebricks:cyanagedvertical", ""},
        {"", "", ""},
    }
})
]]--
