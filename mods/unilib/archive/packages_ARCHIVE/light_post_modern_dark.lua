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
        name = "morelights_modern:post_d",
        description = S("Modern Post Light (@1)", S("dark")),
        tiles = {
            "morelights_metal_dark.png",
            "morelights_metal_dark.png",
            "morelights_metal_dark.png^morelights_modern_post.png"
        }
    },
},
{
    drawtype = "nodebox",
    node_box = {
        type = "fixed",
        fixed = {-1/8, -1/2, -1/8, 1/8, 1/2, 1/8}
    },
    paramtype = "light",
    sunlight_propagates = true,
    light_source = minetest.LIGHT_MAX,
    groups = {cracky = 3, oddly_breakable_by_hand = 3, handy = 1},
    _mcl_hardness = 0.3,
    sounds = morelights.sounds.metal
})
minetest.register_craft({
    output = "morelights_modern:post_d",
    recipe = {
        {a.dye_dark, a.steel, ""},
        {"", "morelights:bulb", ""},
        {"", a.steel, ""}
    }
})
]]--
