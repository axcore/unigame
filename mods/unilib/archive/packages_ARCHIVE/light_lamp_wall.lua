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
minetest.register_node("morelights_modern:walllamp", {
    description = S("Modern Wall Lamp"),
    drawtype = "mesh",
    mesh = "morelights_modern_walllamp.obj",
    collision_box = {
        type = "fixed",
        fixed = {-1/8, -3/8, 1/8, 1/8, 1/4, 1/2}
    },
    selection_box = {
        type = "fixed",
        fixed = {-1/8, -3/8, 1/8, 1/8, 1/4, 1/2}
    },
    tiles = {"morelights_metal_dark_32.png^morelights_modern_walllamp.png"},
    paramtype = "light",
    paramtype2 = "facedir",
    sunlight_propagates = true,
    light_source = 12,
    groups = {cracky = 2, oddly_breakable_by_hand = 3, handy = 1},
    _mcl_hardness = 0.2,
    sounds = morelights.sounds.glass,

    on_place = function(itemstack, placer, pointed_thing)
        return morelights.rotate_and_place(itemstack, placer, pointed_thing,
            {[0] = 6, 4, 1, 3, 0, 2})
    end
})
minetest.register_craft({
    output = "morelights_modern:walllamp",
    recipe = {
        {"", a.glass_pane, ""},
        {a.glass_pane, "morelights:bulb", a.steel},
        {"", a.dye_dark, a.steel}
    }
})
]]--
