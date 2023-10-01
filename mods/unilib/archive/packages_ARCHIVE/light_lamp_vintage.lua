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
minetest.register_node("morelights_vintage:lantern_f", {
    description = S("Vintage Lantern (floor, wall, or ceiling)"),
    drawtype = "mesh",
    mesh = "morelights_vintage_lantern_f.obj",
    tiles = {
        "morelights_vintage_lantern_frame.png^morelights_vintage_lantern_glass.png",
        "morelights_metal_dark_32.png"
    },
    use_texture_alpha = "opaque",
    collision_box = {
        type = "fixed",
        fixed = {-3/16, -1/2, -3/16, 3/16, 1/16, 3/16}
    },
    selection_box = {
        type = "fixed",
        fixed = {-3/16, -1/2, -3/16, 3/16, 1/16, 3/16}
    },
    paramtype = "light",
    sunlight_propagates = true,
    light_source = 12,
    groups = {cracky = 2, oddly_breakable_by_hand = 3, handy = 1},
    _mcl_hardness = 0.2,
    sounds = morelights.sounds.glass,

    on_place = function(itemstack, placer, pointed_thing)
        local wdir = minetest.dir_to_wallmounted(
                vector.subtract(pointed_thing.under, pointed_thing.above))
        local fakeStack = ItemStack(itemstack)

        if wdir == 0 then
            fakeStack:set_name("morelights_vintage:lantern_c")
        elseif wdir == 1 then
            fakeStack:set_name("morelights_vintage:lantern_f")
        else
            fakeStack:set_name("morelights_vintage:lantern_w")
        end

        minetest.item_place(fakeStack, placer, pointed_thing, wdir)
        itemstack:set_count(fakeStack:get_count())

        return itemstack
    end
})
minetest.register_craft({
    output = "morelights_vintage:lantern_f",
    recipe = {
        {"", a.steel, ""},
        {a.glass_pane, "morelights:bulb", a.glass_pane},
        {a.stick, a.steel, a.stick}
    }
})

minetest.register_node("morelights_vintage:lantern_c", {
    drawtype = "mesh",
    mesh = "morelights_vintage_lantern_c.obj",
    tiles = {
        "morelights_vintage_lantern_frame.png^morelights_vintage_lantern_glass.png",
        "morelights_metal_dark_32.png"
    },
    use_texture_alpha = "opaque",
    collision_box = {
        type = "fixed",
        fixed = {-3/16, -1/16, -3/16, 3/16, 1/2, 3/16}
    },
    selection_box = {
        type = "fixed",
        fixed = {-3/16, 0, -3/16, 3/16, 1/2, 3/16}
    },
    paramtype = "light",
    sunlight_propagates = true,
    light_source = 12,
    groups = {cracky = 2, oddly_breakable_by_hand = 3, handy = 1,
              not_in_creative_inventory = 1},
    _mcl_hardness = 0.2,
    sounds = morelights.sounds.glass,
    drop = "morelights_vintage:lantern_f"
})

minetest.register_node("morelights_vintage:lantern_w", {
    drawtype = "mesh",
    mesh = "morelights_vintage_lantern_w.obj",
    tiles = {
        "morelights_vintage_lantern_frame.png^morelights_vintage_lantern_glass.png",
        "morelights_metal_dark_32.png"
    },
    use_texture_alpha = "clip",
    collision_box = {
        type = "fixed",
        fixed = {-3/16, -1/4, -5/16, 3/16, 1/8, 3/16}
    },
    selection_box = {
        type = "fixed",
        fixed = {-3/16, -1/4, -5/16, 3/16, 1/8, 3/16}
    },
    paramtype = "light",
    paramtype2 = "wallmounted",
    sunlight_propagates = true,
    light_source = 12,
    groups = {cracky = 2, oddly_breakable_by_hand = 3, handy = 1,
              not_in_creative_inventory = 1},
    _mcl_hardness = 0.2,
    sounds = morelights.sounds.glass,
    drop = "morelights_vintage:lantern_f"
})
]]--
