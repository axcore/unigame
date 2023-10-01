---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    morelights/morelights_vintage
-- Code:    LGPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("morelights_vintage:block", {
    description = S("Vintage Light Block"),
    tiles = {"morelights_vintage_block_glass.png^morelights_vintage_block_frame.png"},
    paramtype = "light",
    light_source = minetest.LIGHT_MAX,
    groups = {cracky = 2, oddly_breakable_by_hand = 3, handy = 1},
    _mcl_hardness = 0.3,
    sounds = morelights.sounds.glass
})
minetest.register_craft({
    output = "morelights_vintage:block",
    recipe = {
        {"", a.wood_dark, ""},
        {a.glass_pane, "morelights:bulb", a.glass_pane},
        {"", a.wood_dark, ""}
    }
})
]]--
