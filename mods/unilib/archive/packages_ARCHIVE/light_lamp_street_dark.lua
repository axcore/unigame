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
minetest.register_node("morelights_modern:barlight_c", {
    description = S("Ceiling Bar Light (connecting)"),a
    drawtype = "nodebox",
    node_box = {
        type = "connected",
        fixed = {-1/8,  3/8, -1/8, 1/8,  1/2, 1/8},
        connect_front = {-1/8, 3/8, -1/2, 1/8,  1/2, -1/8},
        connect_left = {-1/2, 3/8, -1/8, -1/8, 1/2, 1/8},
        connect_back = {-1/8, 3/8, 1/8, 1/8, 1/2, 1/2},
        connect_right = {1/8, 3/8, -1/8, 1/2, 1/2, 1/8},
    },
    connects_to = {
        "morelights_modern:barlight_c",
        "morelights_modern:barlight_s",
        "morelights_modern:streetpost_d",
        "morelights_modern:streetpost_l"
    },
    tiles = {
        "morelights_metal_dark.png",
        "morelights_modern_barlight.png",
        "morelights_metal_dark.png"
    },
    paramtype = "light",
    sunlight_propagates = true,
    light_source = minetest.LIGHT_MAX,
    groups = {cracky = 2, oddly_breakable_by_hand = 3, handy = 1},
    _mcl_hardness = 0.15,
    sounds = morelights.sounds.glass
})
minetest.register_craft({
    output = "morelights_modern:barlight_c 4",
    recipe = {
        {a.steel, a.steel, a.steel},
        {a.copper, a.glass, a.copper}
    }
})
minetest.register_craft({
    output = "morelights_modern:barlight_c",
    type = "shapeless",
    recipe = {"morelights_modern:barlight_s"}
})

minetest.register_node("morelights_modern:barlight_s", {
    description = S("Ceiling Bar Light (straight)"),
    drawtype = "nodebox",
    node_box = {
        type = "fixed",
        fixed = {-1/2, 3/8, -1/8, 1/2, 1/2, 1/8},
    },
    tiles = {
        "morelights_metal_dark.png",
        "morelights_modern_barlight.png",
        "morelights_metal_dark.png"
    },
    paramtype = "light",
    paramtype2 = "facedir",
    sunlight_propagates = true,
    light_source = minetest.LIGHT_MAX,
    groups = {cracky = 2, oddly_breakable_by_hand = 3, handy = 1},
    _mcl_hardness = 0.15,
    sounds = morelights.sounds.glass
})
minetest.register_craft({
    output = "morelights_modern:barlight_s",
    type = "shapeless",
    recipe = {"morelights_modern:barlight_c"}
})
]]--
