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
minetest.register_node("morelights_vintage:smallblock", {
    description = S("Vintage Light Block (small)"),
    drawtype = "nodebox",
    node_box = {
        type = "fixed",
        fixed = {-1/4, -1/2, -1/4, 1/4, 0, 1/4}
    },
    tiles = {
        "morelights_vintage_block_glass.png^morelights_vintage_block_frame.png",
        "morelights_vintage_block_glass.png^morelights_vintage_block_frame.png",
        "[combine:16x16:0,4=" ..
            "(morelights_vintage_block_glass.png^morelights_vintage_block_frame.png)"
    },
    use_texture_alpha = "opaque",
    paramtype = "light",
    paramtype2 = "facedir",
    sunlight_propagates = true,
    light_source = 12,
    groups = {cracky = 2, oddly_breakable_by_hand = 3, handy = 1},
    _mcl_hardness = 0.2,
    sounds = morelights.sounds.glass,

    on_place = function(itemstack, placer, pointed_thing)
        return morelights.rotate_and_place(itemstack, placer, pointed_thing)
    end
})
minetest.register_craft({
    output = "morelights_vintage:smallblock",
    recipe = {
        {"", a.glass_pane, ""},
        {a.wood_dark, "morelights:bulb", a.wood_dark}
    }
})
]]--
