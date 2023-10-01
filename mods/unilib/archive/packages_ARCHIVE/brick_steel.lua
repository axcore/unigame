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
minetest.register_node ("morebricks:steel", {
    description = S("Steel Brick Block"),
    tiles = {"morebricks_steel.png"},
    is_ground_content = false,
    sounds = default.node_sound_stone_defaults(),
    groups = {cracky = 2, level = 1},
    light_source = 0,
})
minetest.register_craft({
    output = "morebricks:steel 5",
    recipe = {
        {"default:steel_ingot", "default:steel_ingot", "default:steelblock"},
        {"default:steel_ingot", "default:steel_ingot", "default:steelblock"},
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
    output = "morebricks:steelvertical 1",
    recipe = {
        {"", "", ""},
        {"", "morebricks:steel", ""},
        {"", "", ""},
    }
})
minetest.register_craft({
    output = "morebricks:steel 1",
    recipe = {
        {"", "", ""},
        {"", "morebricks:steelvertical", ""},
        {"", "", ""},
    }
})

minetest.register_node ("morebricks:steelaged", {
    description = S("Aged Steel Brick Block"),
    tiles = {"morebricks_steelaged.png"},
    is_ground_content = false,
    sounds = default.node_sound_stone_defaults(),
    groups = {cracky = 2, level = 1},
    light_source = 0,
})
minetest.register_craft({
    output = "morebricks:steelaged 3",
    recipe = {
        {"default:steel_ingot", "default:steel_ingot", ""},
        {"default:steel_ingot", "default:steel_ingot", ""},
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
    output = "morebricks:steelagedvertical 1",
    recipe = {
        {"", "", ""},
        {"", "morebricks:steelaged", ""},
        {"", "", ""},
    }
})
minetest.register_craft({
    output = "morebricks:steelaged 1",
    recipe = {
        {"", "", ""},
        {"", "morebricks:steelagedvertical", ""},
        {"", "", ""},
    }
})
]]--
