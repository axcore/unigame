---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    underch
-- Code:    CC0
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_craftitem(item, {
    description = name,
    inventory_image = "underch_" .. id .. ".png"
})
minetest.register_craft({
    output = item .. " 9",
    type = "shapeless",
    recipe = {block}
})
minetest.register_craft({
    output = item .. " 2",
    type = "shapeless",
    recipe = {"underch:" .. id .. "_crystal"}
})

minetest.register_node(block, {
    description = name .. " Block",
    tiles = {"underch_" .. id .. "_block.png"},
    groups = {cracky = 3},
    is_ground_content = false,
    sounds = default.node_sound_glass_defaults(),
})
minetest.register_craft({
    output = block,
    recipe = {
        {item, item, item},
        {item, item, item},
        {item, item, item}
    }
})
underch.functions.register_stairs(
    id .. "_block", 
    {cracky = 3},
    {"underch_" .. id .. "_block.png"},
    name .. " Block",
    default.node_sound_glass_defaults())

minetest.register_node("underch:" .. id .. "_crystal", {
    description = name .. " Crystal",
    tiles = {"underch_" .. id .. "_crystal.png"},
    groups = {cracky = 2},
    paramtype = "light",
    paramtype2 = "facedir",
    drawtype = "mesh",
    mesh = "underch_crystal.obj",
    light_source = 4,
    is_ground_content = false,
    sounds = default.node_sound_glass_defaults(),
})

underch.gems.register_gem("Ruby", "ruby");
]]--
