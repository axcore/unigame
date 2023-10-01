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
minetest.register_node ("morebricks:gold", {
    description = S("Gold Brick Block"),
    tiles = {"morebricks_gold.png"},
    is_ground_content = false,
    sounds = default.node_sound_stone_defaults(),
    groups = {cracky = 1, level = 2},  
    light_source = 0,
})
minetest.register_craft({
    output = "morebricks:gold 2",
    recipe = {
        {"default:gold_ingot", "default:gold_ingot", ""},
        {"default:gold_ingot", "default:gold_ingot", ""},
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
    output = "morebricks:goldvertical 1",
    recipe = {
        {"", "", ""},
        {"", "morebricks:gold", ""},
        {"", "", ""},
    }
})
minetest.register_craft({
    output = "morebricks:gold 1",
    recipe = {
        {"", "", ""},
        {"", "morebricks:goldvertical", ""},
        {"", "", ""},
    }
})
]]--
