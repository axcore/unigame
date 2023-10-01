---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    morelights/morelights_extras
-- Code:    LGPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.light_block_sandstone = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.morelights_extras.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.light_block_sandstone.init()

    return {
        description = "Sandstone lamp",
        depends = {"light_bulb_normal", "pane_glass_ordinary", "stone_sandstone_ordinary"},
    }

end

function unilib.pkg.light_block_sandstone.exec()

    unilib.register_node(
        -- From morelights_extras:stone_block
        "unilib:light_block_sandstone",
        "morelights_extras:sandstone_block",
        mode,
        {
            description = S("Sandstone Lamp"),
            tiles = {"unilib_stone_sandstone_ordinary_block.png^unilib_light_block_overlay.png"},
            groups = {cracky = 2, handy = 1, oddly_breakable_by_hand = 3},
            sounds = unilib.sound_table.glass,

            light_source = 12,
            paramtype = "light",
        }
    )
    unilib.register_craft({
        -- From morelights_extras:stone_block
        output = "unilib:light_block_sandstone",
        recipe = {
            {"", "unilib:pane_glass_ordinary_flat", ""},
            {"", "unilib:light_bulb_normal", ""},
            {"", "unilib:stone_sandstone_ordinary_block", ""},
        },
    })

end
