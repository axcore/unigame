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
minetest.register_node("morelights_vintage:chandelier", {
    description = S("Vintage Chandelier"),
    drawtype = "mesh",
    mesh = "morelights_vintage_chandelier.obj",
    tiles = {
        "morelights_vintage_chandelier.png",
        "morelights_vintage_brass_32.png^[multiply:#DFDFDF"
    },
    use_texture_alpha = "clip",
    collision_box = {
        type = "fixed",
        fixed = {-3/8, -1/2, -3/8, 3/8, 1/2, 3/8}
    },
    selection_box = {
        type = "fixed",
        fixed = {-3/8, -1/2, -3/8, 3/8, 1/2, 3/8}
    },
    paramtype = "light",
    sunlight_propagates = true,
    light_source = 10,
    groups = {cracky = 2, oddly_breakable_by_hand = 3, handy = 1},
    _mcl_hardness = 0.3,
    sounds = morelights.sounds.glass
})
minetest.register_craft({
    output = "morelights_vintage:chandelier",
    recipe = {
        {"", a.brass, ""},
        {"morelights:bulb", a.brass, "morelights:bulb"},
        {a.steel, a.brass, a.steel}
    }
})
]]--
