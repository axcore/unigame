---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    morelights/morelights_extras
-- Code:    LGPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
do
    local def = {
        description = S("Grass Light"),
        tiles = {
            "default_grass.png^morelights_extras_blocklight.png",
            "default_dirt.png",
            "default_dirt.png^default_grass_side.png"
        },
        paramtype = "light",
        light_source = 12,
        groups = {
            cracky = 2,
            oddly_breakable_by_hand = 3,
            handy = 1,
            soil = 1,
        },
        _mcl_hardness = 0.3,
        sounds = morelights.sounds.glass
    }

    minetest.register_node("morelights_extras:dirt_with_grass", def)
end
minetest.register_craft({
    output = "morelights_extras:dirt_with_grass",
    recipe = {
        {"", a.glass_pane, ""},
        {"", "morelights:bulb", ""},
        {a.grass, a.dirt, ""}
    }
})
]]--
