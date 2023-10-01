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

--[[minetest.register_node("morelights_vintage:hangingbulb", {
    description = S("Vintage Hanging Light Bulb"),
    drawtype = "mesh",
    mesh = "morelights_vintage_hangingbulb.obj",
    tiles = {
        "morelights_vintage_hangingbulb.png" ..
                "^[lowpart:50:morelights_metal_dark_32.png"
    },
    inventory_image = "morelights_vintage_hangingbulb_inv.png",
    wield_image = "morelights_vintage_hangingbulb_inv.png",
    use_texture_alpha = "blend",
    collision_box = {
        type = "fixed",
        fixed = {-1/8, -1/8, -1/8, 1/8, 1/2, 1/8}
    },
    selection_box = {
        type = "fixed",
        fixed = {-1/8, -1/8, -1/8, 1/8, 1/2, 1/8}
    },
    paramtype = "light",
    sunlight_propagates = true,
    light_source = 10,
    groups = {cracky = 2, oddly_breakable_by_hand = 3, handy = 1},
    _mcl_hardness = 0.15,
    sounds = morelights.sounds.glass
})
minetest.register_craft({
    output = "morelights_vintage:hangingbulb",
    recipe = {
        {"", a.steel, ""},
        {"", a.copper, ""},
        {"", "morelights:bulb", ""}
    }
})
]]--
