---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    morelights/morelights_modern
-- Code:    LGPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
morelights.register_variants({
    {
        name = "morelights_modern:canlight_l",
        description = S("Modern Can Light (@1)", S("light")),
        tiles = {"morelights_metal_light.png^morelights_modern_canlight.png"}
    },
},
{
    drawtype = "mesh",
    mesh = "morelights_modern_canlight.obj",
    collision_box = {
        type = "fixed",
        fixed = {-1/8, 0, -1/8, 1/8, 1/2, 1/8}
    },
    selection_box = {
        type = "fixed",
        fixed = {-1/8, 0, -1/8, 1/8, 1/2, 1/8}
    },
    paramtype = "light",
    sunlight_propagates = true,
    light_source = 12,
    groups = {cracky = 2, oddly_breakable_by_hand = 3, handy = 1},
    _mcl_hardness = 0.2,
    sounds = morelights.sounds.metal
})
minetest.register_craft({
    output = "morelights_modern:canlight_l",
    recipe = {
        {a.dye_light, a.steel, ""},
        {a.steel, "morelights:bulb", a.steel},
    }
})
]]--
