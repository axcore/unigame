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
minetest.register_node ("morebricks:magenta", {
    description = S("Magenta Brick Block"),
    tiles = {"morebricks_magenta.png"},
    is_ground_content = false,
    sounds = default.node_sound_stone_defaults(),
    groups = {cracky = 2, level = 1},
    light_source = 0,
})
minetest.register_craft({
    output = "morebricks:magenta 3",
    recipe = {
        {"default:clay_brick", "default:clay_brick", "bakedclay:magenta"},
        {"default:clay_brick", "default:clay_brick", "bakedclay:magenta"},
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
    output = "morebricks:magentavertical 1",
    recipe = {
        {"", "", ""},
        {"", "morebricks:magenta", ""},
        {"", "", ""},
    }
})
minetest.register_craft({
    output = "morebricks:magenta 1",
    recipe = {
        {"", "", ""},
        {"", "morebricks:magentavertical", ""},
        {"", "", ""},
    }
})

minetest.register_node ("morebricks:magentaaged", {
    description = S("Aged Magenta Brick Block"),
    tiles = {"morebricks_magentaaged.png"},
    is_ground_content = false,
    sounds = default.node_sound_stone_defaults(),
    groups = {cracky = 2, level = 1},
    light_source = 0,
})
minetest.register_craft({
    output = "morebricks:magentaaged 3",
    recipe = {
        {"default:clay_brick", "default:clay_brick", "bakedclay:magenta"},
        {"default:clay_brick", "default:clay_brick", "bakedclay:magenta"},
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
    output = "morebricks:magentaagedvertical 1",
    recipe = {
        {"", "", ""},
        {"", "morebricks:magentaaged", ""},
        {"", "", ""},
    }
})
minetest.register_craft({
    output = "morebricks:magentaaged 1",
    recipe = {
        {"", "", ""},
        {"", "morebricks:magentavertical", ""},
        {"", "", ""},
    }
})
]]--
