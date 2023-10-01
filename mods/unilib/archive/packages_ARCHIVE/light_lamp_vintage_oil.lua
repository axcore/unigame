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
minetest.register_node("morelights_vintage:oillamp", {
    description = S("Vintage Oil Lamp"),
    drawtype = "mesh",
    mesh = "morelights_vintage_oillamp.obj",
    tiles = {
        {
            name = "morelights_vintage_oil_flame.png",
            animation = {
                type = "sheet_2d",
                frames_w = 16,
                frames_h = 1,
                frame_length = 0.3
            }
        },
        "morelights_vintage_oillamp.png",
        "morelights_vintage_brass_32.png"
    },
    use_texture_alpha = "clip",
    collision_box = {
        type = "fixed",
        fixed = {-1/8, -1/2, -1/8, 1/8, 1/4, 1/8}
    },
    selection_box = {
        type = "fixed",
        fixed = {-1/8, -1/2, -1/8, 1/8, 1/4, 1/8}
    },
    paramtype = "light",
    sunlight_propagates = true,
    light_source = 8,
    groups = {cracky = 2, oddly_breakable_by_hand = 3, handy = 1},
    _mcl_hardness = 0.2,
    sounds = morelights.sounds.glass
})
minetest.register_craft({
    output = "morelights_vintage:oillamp",
    recipe = {
        {"", a.glass, ""},
        {"", a.string, ""},
        {"", a.brass, ""}
    }
})
]]--
