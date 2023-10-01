---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    underch
-- Code:    CC0
-- Media:   CC BY-SA 3.0
--
-- From:    uchu/compressed
-- Code:    MIT
-- Media:   CC BY-SA 3.0
--
-- From:    uchu/condensed
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_dolostone_pale = {}

local S = unilib.intllib
local underch_add_mode = unilib.imported_mod_table.underch.add_mode
local compressed_add_mode = unilib.imported_mod_table.compressed.add_mode
local condensed_add_mode = unilib.imported_mod_table.condensed.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_dolostone_pale.init()

    return {
        description = "Pale dolostone",
    }

end

function unilib.pkg.stone_dolostone_pale.exec()

    unilib.register_stone({
        -- Original to unilib
        part_name = "dolostone_pale",
        description = S("Pale Dolostone"),

        category = "sedimentary",
        grinder_flag = true,
        hardness = 1,
        moss_flag = true,
        platform_flag = true,
    })

    unilib.register_stone_smooth({
        -- From underch:dolomite. Creates unilib:stone_dolostone_pale
        part_name = "dolostone_pale",
        orig_name = "underch:dolostone",

        replace_mode = underch_add_mode,
        cobble_mode = "cobble",
        description = S("Pale Dolostone"),
    })

    unilib.register_stone_block({
        -- From underch:dolomite_block. Creates unilib:stone_dolostone_pale_block
        part_name = "dolostone_pale",
        orig_name = "underch:dolostone_block",

        replace_mode = underch_add_mode,
        description = S("Pale Dolostone Block"),
    })

    unilib.register_stone_brick({
        -- From underch:dolomite_brick. Creates unilib:stone_dolostone_pale_brick
        part_name = "dolostone_pale",
        orig_name = "underch:dolostone_brick",

        replace_mode = underch_add_mode,
        description = S("Pale Dolostone Bricks"),
    })

    unilib.register_stone_cobble({
        -- From underch:dolomite_cobble. Creates unilib:stone_dolostone_pale_cobble
        part_name = "dolostone_pale",
        orig_name = "underch:dolostone_cobble",

        replace_mode = underch_add_mode,
        description = S("Pale Dolostone Cobble"),
        wall_orig_name = "underch:dolomite_cobble_wall",
    })

    unilib.register_stone_cobble_mossy({
        -- From underch:dolomite_mossy_cobble. Creates unilib:stone_dolostone_pale_cobble_mossy
        part_name = "dolostone_pale",
        orig_name = "underch:dolostone_mossy_cobble",

        replace_mode = underch_add_mode,
        description = S("Mossy Pale Dolostone Cobble"),
        wall_orig_name = "underch:dolomite_mossy_cobble_wall",
    })

    if unilib.underch_tweak_flag then

        unilib.register_stone_cobble_compressed({
            -- From compressed:dolomite. Creates unilib:stone_dolostone_pale_cobble_compressed
            part_name = "dolostone_pale",
            orig_name = "compressed:dolostone",

            replace_mode = compressed_add_mode,
            description = S("Compressed Pale Dolostone Cobble"),
        })

        unilib.register_stone_cobble_condensed({
            -- From condensed:dolomite. Creates unilib:stone_dolostone_pale_cobble_condensed
            part_name = "dolostone_pale",
            orig_name = "condensed:dolostone",

            replace_mode = condensed_add_mode,
            description = S("Condensed Pale Dolostone Cobble"),
        })

    end

end
