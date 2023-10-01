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
minetest.register_node ("morebricks:darkgreen", {
    description = S("Dark-Green Brick Block"),
    tiles = {"morebricks_darkgreen.png"},
    is_ground_content = false,
    sounds = default.node_sound_stone_defaults(),
    groups = {cracky = 2, level = 1},
    light_source = 0,
})
minetest.register_craft({
    output = "morebricks:darkgreen 3",
    recipe = {
        {"default:clay_brick", "default:clay_brick", "bakedclay:dark_green"},
        {"default:clay_brick", "default:clay_brick", "bakedclay:dark_green"},
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
    output = "morebricks:darkgreenvertical 1",
    recipe = {
        {"", "", ""},
        {"", "morebricks:darkgreen", ""},
        {"", "", ""},
    }
})
minetest.register_craft({
    output = "morebricks:darkgreen 1",
    recipe = {
        {"", "", ""},
        {"", "morebricks:darkgreenvertical", ""},
        {"", "", ""},
    }
})
]]--
