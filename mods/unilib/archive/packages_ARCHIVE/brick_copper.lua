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
minetest.register_node ("morebricks:copper", {
    description = S("Copper Brick Block"),
    tiles = {"morebricks_copper.png"},
    is_ground_content = false,
    sounds = default.node_sound_stone_defaults(),
    groups = {cracky = 1, level = 2}, 
    light_source = 0,
})
minetest.register_craft({
    output = "morebricks:copper 2",
    recipe = {
        {"default:copper_ingot", "default:copper_ingot", ""},
        {"default:copper_ingot", "default:copper_ingot", ""},
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
    output = "morebricks:coppervertical 1",
    recipe = {
        {"", "", ""},
        {"", "morebricks:copper", ""},
        {"", "", ""},
    }
})
minetest.register_craft({
    output = "morebricks:copper 1",
    recipe = {
        {"", "", ""},
        {"", "morebricks:coppervertical", ""},
        {"", "", ""},
    }
})

minetest.register_node ("morebricks:copperaged", {
    description = S("Aged Copper Brick Block"),
    tiles = {"morebricks_copperaged.png"},
    is_ground_content = false,
    sounds = default.node_sound_stone_defaults(),
    groups = {cracky = 2, level = 1},
    light_source = 0,
})
minetest.register_craft({
    output = "morebricks:copperaged 2",
    recipe = {
        {"default:copper_ingot", "default:copper_ingot", ""},
        {"default:copper_ingot", "default:copper_ingot", ""},
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
    output = "morebricks:copperagedvertical 1",
    recipe = {
        {"", "", ""},
        {"", "morebricks:copperaged", ""},
        {"", "", ""},
    }
})
minetest.register_craft({
    output = "morebricks:copperaged 1",
    recipe = {
        {"", "", ""},
        {"", "morebricks:copperagedvertical", ""},
        {"", "", ""},
    }
})
]]--
