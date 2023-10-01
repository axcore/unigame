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
minetest.register_node ("morebricks:darkgrey", {
    description = S("Dark-Grey Brick Block"),
    tiles = {"morebricks_darkgrey.png"},
    is_ground_content = false,
    sounds = default.node_sound_stone_defaults(),
    groups = {cracky = 2, level = 1},
    light_source = 0,
})
minetest.register_craft({
    output = "morebricks:darkgrey 3",
    recipe = {
        {"default:clay_brick", "default:clay_brick", "bakedclay:dark_grey"},
        {"default:clay_brick", "default:clay_brick", "bakedclay:dark_grey"},
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
    output = "morebricks:darkgreyvertical 1",
    recipe = {
        {"", "", ""},
        {"", "morebricks:darkgrey", ""},
        {"", "", ""},
    }
})
minetest.register_craft({
    output = "morebricks:darkgrey 1",
    recipe = {
        {"", "", ""},
        {"", "morebricks:darkgreyvertical", ""},
        {"", "", ""},
    }
})
]]--
