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
minetest.register_node ("morebricks:pink", {
    description = S("Pink Brick Block"),
    tiles = {"morebricks_pink.png"},
    is_ground_content = false,
    sounds = default.node_sound_stone_defaults(),
    groups = {cracky = 2, level = 1},
    light_source = 0,
})
minetest.register_craft({
    output = "morebricks:pink 3",
    recipe = {
        {"default:clay_brick", "default:clay_brick", "bakedclay:pink"},
        {"default:clay_brick", "default:clay_brick", "bakedclay:pink"},
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
    output = "morebricks:pinkvertical 1",
    recipe = {
        {"", "", ""},
        {"", "morebricks:pink", ""},
        {"", "", ""},
    }
})
minetest.register_craft({
    output = "morebricks:pink 1",
    recipe = {
        {"", "", ""},
        {"", "morebricks:pinkvertical", ""},
        {"", "", ""},
    }
})

minetest.register_node ("morebricks:pinkaged", {
    description = S("Aged Pink Brick Block"),
    tiles = {"morebricks_pinkaged.png"},
    is_ground_content = false,
    sounds = default.node_sound_stone_defaults(),
    groups = {cracky = 2, level = 1},
    light_source = 0,
})
minetest.register_craft({
    output = "morebricks:pinkaged 3",
    recipe = {
        {"default:clay_brick", "default:clay_brick", "bakedclay:pink"},
        {"default:clay_brick", "default:clay_brick", "bakedclay:pink"},
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
    output = "morebricks:pinkagedvertical 1",
    recipe = {
        {"", "", ""},
        {"", "morebricks:pinkaged", ""},
        {"", "", ""},
    }
})
minetest.register_craft({
    output = "morebricks:pinkaged 1",
    recipe = {
        {"", "", ""},
        {"", "morebricks:pinkagedvertical", ""},
        {"", "", ""},
    }
})
]]--
