---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    morelights/morelights_extras
-- Code:    LGPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.light_block_stone = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.morelights_extras.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.light_block_stone.init()

    return {
        description = "Stone lamp",
        depends = {"light_bulb_normal", "pane_glass_ordinary", "stone_ordinary"},
    }

end

function unilib.pkg.light_block_stone.exec()

    unilib.register_node("unilib:light_block_stone", "morelights_extras:stone_block", mode, {
        -- From morelights_extras:stone_block
        description = S("Stone Lamp"),
        tiles = {"unilib_stone_ordinary_block.png^unilib_light_block_overlay.png"},
        groups = {cracky = 2, handy = 1, oddly_breakable_by_hand = 3},
        sounds = unilib.sound_table.glass,

        light_source = 12,
        paramtype = "light",
    })
    unilib.register_craft({
        -- From morelights_extras:stone_block
        output = "unilib:light_block_stone",
        recipe = {
            {"", "unilib:pane_glass_ordinary_flat", ""},
            {"", "unilib:light_bulb_normal", ""},
            {"", "unilib:stone_ordinary_block", ""},
        },
    })

end
