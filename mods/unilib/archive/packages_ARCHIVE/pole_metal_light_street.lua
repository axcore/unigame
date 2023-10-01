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
        name = "morelights_modern:streetpost_l",
        description = S("Street Lamp Post (@1) - connects to bar lights",
                S("light")),
        tiles = {"morelights_metal_light.png"}
    }
},
{
    drawtype = "nodebox",
    node_box = {
        type = "connected",
        fixed = {-1/16, -1/2, -1/16, 1/16,  1/2, 1/16},
        connect_front = {-1/16,  3/8, -1/2, 1/16,  7/16, -1/16},
        connect_left = {-1/2, 3/8, -1/16, -1/16, 7/16, 1/16},
        connect_back = {-1/16, 3/8, 1/16, 1/16, 7/16, 1/2},
        connect_right = {1/16, 3/8, -1/16, 1/2, 7/16, 1/16},
    },
    connects_to = {
        "morelights_modern:barlight_c",
        "morelights_modern:barlight_s"
    },
    paramtype = "light",
    sunlight_propagates = true,
    groups = {cracky = 2, oddly_breakable_by_hand = 3, handy = 1},
    _mcl_hardness = 0.3,
    sounds = morelights.sounds.metal
})
minetest.register_craft({
    output = "morelights_modern:streetpost_l 2",
    recipe = {
        {a.dye_light, a.steel, a.steel},
        {"", a.steel, ""},
        {"", a.steel, ""}
    }
})
]]--
