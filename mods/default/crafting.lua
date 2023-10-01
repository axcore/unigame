-- mods/default/crafting.lua

--
-- Crafting (tool repair)
--

minetest.register_craft({
    type = "toolrepair",
    additional_wear = -0.02,
})


--
-- Fuels
--

-- Support use of group:tree, includes default:tree which has the same burn time
minetest.register_craft({
    type = "fuel",
    recipe = "group:tree",
    burntime = 30,
})
