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
minetest.register_node ("morebricks:grey", {
    description = S("Grey Brick Block"),
    tiles = {"morebricks_grey.png"},
    is_ground_content = false,
    sounds = default.node_sound_stone_defaults(),
    groups = {cracky = 2, level = 1},
    light_source = 0,
})
minetest.register_craft({
    output = "morebricks:grey 3",
    recipe = {
        {"default:clay_brick", "default:clay_brick", "bakedclay:grey"},
        {"default:clay_brick", "default:clay_brick", "bakedclay:grey"},
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
    output = "morebricks:greyvertical 1",
    recipe = {
        {"", "", ""},
        {"", "morebricks:grey", ""},
        {"", "", ""},
    }
})
minetest.register_craft({
    output = "morebricks:grey 1",
    recipe = {
        {"", "", ""},
        {"", "morebricks:greyvertical", ""},
        {"", "", ""},
    }
})

minetest.register_node ("morebricks:greyaged", {
    description = S("Aged Grey Brick Block"),
    tiles = {"morebricks_greyaged.png"},
    is_ground_content = false,
    sounds = default.node_sound_stone_defaults(),
    groups = {cracky = 2, level = 1},
    light_source = 0,
})
minetest.register_craft({
    output = "morebricks:greyaged 3",
    recipe = {
        {"default:clay_brick", "default:clay_brick", "bakedclay:grey"},
        {"default:clay_brick", "default:clay_brick", "bakedclay:grey"},
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
    output = "morebricks:greyagedvertical 1",
    recipe = {
        {"", "", ""},
        {"", "morebricks:greyaged", ""},
        {"", "", ""},
    }
})
minetest.register_craft({
    output = "morebricks:greyaged 1",
    recipe = {
        {"", "", ""},
        {"", "morebricks:greyagedvertical", ""},
        {"", "", ""},
    }
})
]]--
