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
        name = "morelights_modern:tablelamp_d",
        description = S("Modern Table Lamp (@1)", S("dark")),
        tiles = {
            "morelights_metal_light_32.png^morelights_modern_tablelamp_o.png",
            "morelights_modern_tablelamp_d.png"
        }
    },
},
{
    drawtype = "mesh",
    mesh = "morelights_modern_tablelamp.obj",
    collision_box = {
        type = "fixed",
        fixed = {-1/4, -1/2, -1/4, 1/4, 7/16, 1/4}
    },
    selection_box = {
        type = "fixed",
        fixed = {-1/4, -1/2, -1/4, 1/4, 7/16, 1/4}
    },
    paramtype = "light",
    sunlight_propagates = true,
    light_source = 10,
    groups = {choppy = 2, oddly_breakable_by_hand = 3, handy = 1},
    _mcl_hardness = 0.2,
    sounds = morelights.sounds.default
})
minetest.register_craft({
    output = "morelights_modern:tablelamp_d",
    recipe = {
        {"", a.steel, ""},
        {a.wool_dark, "morelights:bulb", a.wool_dark},
        {"", a.steel, ""}
    }
})
]]--
