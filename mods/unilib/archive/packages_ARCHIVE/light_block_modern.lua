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
minetest.register_node("morelights_modern:block", {
    description = S("Modern Light Block"),
    tiles = {"morelights_metal_dark.png^morelights_modern_block.png"},
    paramtype = "light",
    light_source = minetest.LIGHT_MAX,
    groups = {cracky = 2, oddly_breakable_by_hand = 3, handy = 1},
    _mcl_hardness = 0.3,
    sounds = morelights.sounds.glass
})
minetest.register_craft({
    output = "morelights_modern:block",
    recipe = {
        {"", a.steel, ""},
        {a.glass_pane, "morelights:bulb", a.glass_pane},
        {"", a.steel, ""}
    }
})

minetest.register_node("morelights_modern:smallblock", {
    description = S("Modern Light Block (small)"),
    drawtype = "nodebox",
    node_box = {
        type = "fixed",
        fixed = {-1/4, -1/2, -1/4, 1/4, 0, 1/4}
    },
    tiles = {
        "morelights_metal_dark.png^morelights_modern_smallblock.png",
        "morelights_metal_dark.png^morelights_modern_smallblock.png",
        "[combine:16x16:0,0=morelights_metal_dark.png" ..
                ":0,4=morelights_modern_smallblock.png"
    },
    paramtype = "light",
    paramtype2 = "facedir",
    sunlight_propagates = true,
    light_source = 12,
    groups = {cracky = 3, oddly_breakable_by_hand = 3, handy = 1},
    _mcl_hardness = 0.2,
    sounds = morelights.sounds.glass,

    on_place = function(itemstack, placer, pointed_thing)
        return morelights.rotate_and_place(itemstack, placer, pointed_thing)
    end
})
minetest.register_craft({
    output = "morelights_modern:smallblock",
    recipe = {
        {"", a.glass_pane, ""},
        {a.steel, "morelights:bulb", a.steel}
    }
})
]]--
