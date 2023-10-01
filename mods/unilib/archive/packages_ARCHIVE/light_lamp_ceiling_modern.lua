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
minetest.register_node("morelights_modern:ceilinglight", {
    description = S("Modern Ceiling Light"),
    drawtype = "nodebox",
    node_box = {
        type = "fixed",
        fixed = {-1/4, 3/8, -1/4, 1/4, 1/2, 1/4}
    },
    tiles = {
        "morelights_metal_dark.png",
        "morelights_metal_dark.png^morelights_modern_block.png"
    },
    paramtype = "light",
    paramtype2 = "facedir",
    sunlight_propagates = true,
    light_source = minetest.LIGHT_MAX,
    groups = {cracky = 3, oddly_breakable_by_hand = 3, handy = 1},
    _mcl_hardness = 0.2,
    sounds = morelights.sounds.glass,

    on_place = function(itemstack, placer, pointed_thing)
        return morelights.rotate_and_place(itemstack, placer, pointed_thing,
            {[0] = 0, 20, 12, 16, 4, 8})
    end
})
minetest.register_craft({
    output = "morelights_modern:ceilinglight",
    recipe = {
        {a.steel, "morelights:bulb", a.steel},
        {"", a.glass_pane, ""},
    }
})
]]--
