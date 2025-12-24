---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/bale
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_straw_ordinary_block = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.bale.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_straw_ordinary_block.init()

    return {
        description = "Block of ordinary straw",
        depends = {"crop_wheat", "item_string_ordinary"},
    }

end

function unilib.pkg.misc_straw_ordinary_block.exec()

    local c_wheat = "unilib:crop_wheat_harvest"

    unilib.register_node("unilib:misc_straw_ordinary_block", "bale:bale", mode, {
        -- From bale:bale
        description = S("Ordinary Straw Block"),
        tiles = {"unilib_misc_straw_ordinary_block.png"},
        groups = {choppy = 2, feeder = 1, flammable = 3, oddly_breakable_by_hand = 3, snappy = 2},
        sounds = unilib.global.sound_table.node,

        is_ground_content = false,
    })
    unilib.register_craft({
        -- From bale:bale
        output = "unilib:misc_straw_ordinary_block",
        recipe = {
            {c_wheat, c_wheat, c_wheat},
            {c_wheat, "unilib:item_string_ordinary", c_wheat},
            {c_wheat, c_wheat, c_wheat},
        },
    })

end
