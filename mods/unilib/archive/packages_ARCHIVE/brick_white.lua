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
minetest.register_node ("morebricks:white", {
    description = S("White Brick Block"),
    tiles = {"morebricks_white.png"},
    is_ground_content = false,
    sounds = default.node_sound_stone_defaults(),
    groups = {cracky = 2, level = 1},
    light_source = 0,
})
minetest.register_craft({
    output = "morebricks:white 3",
    recipe = {
        {"default:clay_brick", "default:clay_brick", "bakedclay:white"},
        {"default:clay_brick", "default:clay_brick", "bakedclay:white"},
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
    output = "morebricks:whitevertical 1",
    recipe = {
        {"", "", ""},
        {"", "morebricks:white", ""},
        {"", "", ""},
    }
})
minetest.register_craft({
    output = "morebricks:white 1",
    recipe = {
        {"", "", ""},
        {"", "morebricks:whitevertical", ""},
        {"", "", ""},
    }
})

minetest.register_node ("morebricks:whiteaged", {
    description = S("Aged White Brick Block"),
    tiles = {"morebricks_whiteaged.png"},
    is_ground_content = false,
    sounds = default.node_sound_stone_defaults(),
    groups = {cracky = 2, level = 1},
    light_source = 0,
})
minetest.register_craft({
    output = "morebricks:whiteaged 3",
    recipe = {
        {"default:clay_brick", "default:clay_brick", "bakedclay:white"},
        {"default:clay_brick", "default:clay_brick", "bakedclay:white"},
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
    output = "morebricks:whiteagedvertical 1",
    recipe = {
        {"", "", ""},
        {"", "morebricks:whiteaged", ""},
        {"", "", ""},
    }
})
minetest.register_craft({
    output = "morebricks:whiteaged 1",
    recipe = {
        {"", "", ""},
        {"", "morebricks:whiteagedvertical", ""},
        {"", "", ""},
    }
})
]]--
