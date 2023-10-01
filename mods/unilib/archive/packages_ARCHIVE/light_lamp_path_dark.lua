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

--[[morelights.register_variants({
    {
        name = "morelights_modern:pathlight_d",
        description = S("Modern Path Light (@1)", S("dark")),
        tiles = {
            "morelights_metal_dark_32.png^morelights_modern_pathlight.png"
        }
    },
},
{
    drawtype = "nodebox",
    node_box = {
        type = "fixed",
        fixed = {
            {-1/32, -8/16, -1/32, 1/32, 1/8, 1/32},
            {-1/16, 1/8, -1/16, 1/16, 5/16, 1/16},
            {-1/8, 5/16, -1/8, 1/8, 3/8, 1/8}
        }
    },
    selection_box = {
        type = "fixed",
        fixed = {-1/8, -1/2, -1/8, 1/8, 3/8, 1/8}
    },
    paramtype = "light",
    sunlight_propagates = true,
    light_source = 8,
    groups = {cracky = 3, oddly_breakable_by_hand = 3, handy = 1},
    _mcl_hardness = 0.2,
    sounds = morelights.sounds.metal
})
minetest.register_craft({
    output = "morelights_modern:pathlight_d",
    recipe = {
        {a.dye_dark, "morelights:bulb", ""},
        {"", a.steel, ""},
        {"", a.steel, ""}
    }
})

]]--
