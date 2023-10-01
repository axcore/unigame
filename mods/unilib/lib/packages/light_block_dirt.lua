---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    morelights/morelights_extras
-- Code:    LGPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.light_block_dirt = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.morelights_extras.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.light_block_dirt.init()

    return {
        description = "Dirt lamp",
        depends = {"dirt_ordinary", "grass_ordinary", "light_bulb_normal", "pane_glass_ordinary"},
    }

end

function unilib.pkg.light_block_dirt.exec()

    unilib.register_node("unilib:light_block_dirt", "morelights_extras:dirt_with_grass", mode, {
        -- From morelights_extras:dirt_with_grass
        description = S("Dirt Lamp"),
        tiles = {
            "unilib_turf_ordinary_top.png^unilib_light_block_overlay.png",
            "unilib_dirt_ordinary.png",
            "unilib_dirt_ordinary.png^unilib_turf_ordinary_side_overlay.png"
        },
        groups = {cracky = 2, handy = 1, oddly_breakable_by_hand = 3, soil = 1},
        sounds = unilib.sound_table.glass,

        light_source = 12,
        paramtype = "light",
    })
    unilib.register_craft({
        -- From morelights_extras:dirt_with_grass
        output = "unilib:light_block_dirt",
        recipe = {
            {"", "unilib:pane_glass_ordinary_flat", ""},
            {"", "unilib:light_bulb_normal", ""},
            {"unilib:grass_ordinary_1", "unilib:dirt_ordinary", ""},
        },
    })

end
