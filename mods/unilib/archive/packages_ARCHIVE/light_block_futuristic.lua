---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    morelights/morelights_extras
-- Code:    LGPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("morelights_extras:f_block", {
    description = S("Futuristic Light Block"),
    tiles = {"morelights_extras_f_block.png"},
    paramtype = "light",
    light_source = minetest.LIGHT_MAX,
    groups = {cracky = 2, oddly_breakable_by_hand = 3, handy = 1},
    _mcl_hardness = 0.3,
    sounds = morelights.sounds.glass
})
minetest.register_craft({
    output = "morelights_extras:f_block",
    recipe = {
        {a.crystal_fragment, a.steel, a.crystal_fragment},
        {a.glass_pane, "morelights:bulb", a.glass_pane},
        {a.crystal_fragment, a.steel, a.crystal_fragment}
    }
})
]]--
