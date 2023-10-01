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
minetest.register_node ("morebricks:green", {
    description = S("Green Brick Block"),
    tiles = {"morebricks_green.png"},
    is_ground_content = false,
    sounds = default.node_sound_stone_defaults(),
    groups = {cracky = 2, level = 1},
    light_source = 0,
})
minetest.register_craft({
    output = "morebricks:green 3",
    recipe = {
        {"default:clay_brick", "default:clay_brick", "bakedclay:green"},
        {"default:clay_brick", "default:clay_brick", "bakedclay:green"},
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
    output = "morebricks:greenvertical 1",
    recipe = {
        {"", "", ""},
        {"", "morebricks:green", ""},
        {"", "", ""},
    }
})
minetest.register_craft({
    output = "morebricks:green 1",
    recipe = {
        {"", "", ""},
        {"", "morebricks:greenvertical", ""},
        {"", "", ""},
    }
})

minetest.register_node ("morebricks:greenaged", {
    description = S("Aged Green Brick Block"),
    tiles = {"morebricks_greenaged.png"},
    is_ground_content = false,
    sounds = default.node_sound_stone_defaults(),
    groups = {cracky = 2, level = 1},
    light_source = 0,
})
minetest.register_craft({
    output = "morebricks:greenaged 3",
    recipe = {
        {"default:clay_brick", "default:clay_brick", "bakedclay:green"},
        {"default:clay_brick", "default:clay_brick", "bakedclay:green"},
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
    output = "morebricks:greenagedvertical 1",
    recipe = {
        {"", "", ""},
        {"", "morebricks:greenaged", ""},
        {"", "", ""},
    }
})
minetest.register_craft({
    output = "morebricks:greenaged 1",
    recipe = {
        {"", "", ""},
        {"", "morebricks:greenagedvertical", ""},
        {"", "", ""},
    }
})
]]--
