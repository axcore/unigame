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

unilib.pkg.stone_vindesite_white = {}

local S = unilib.intllib
local underch_add_mode = unilib.global.imported_mod_table.underch.add_mode
local compressed_add_mode = unilib.global.imported_mod_table.compressed.add_mode
local condensed_add_mode = unilib.global.imported_mod_table.condensed.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_vindesite_white.init()

    return {
        description = "White vindesite",
    }

end

function unilib.pkg.stone_vindesite_white.exec()

    unilib.register_stone({
        -- Original to unilib
        part_name = "vindesite_white",
        description = S("White Vindesite"),

        category = "other",
        colour = "#141119",
        fictional_flag = true,
        grinder_flag = true,
        hardness = 1,
        moss_flag = true,
        platform_flag = true,
    })

    unilib.register_stone_smooth({
        -- From underch:vindesite. Creates unilib:stone_vindesite_white
        part_name = "vindesite_white",
        orig_name = "underch:vindesite",

        replace_mode = underch_add_mode,
        cobble_mode = "cobble",
        description = S("White Vindesite"),
    })

    unilib.register_stone_block({
        -- From underch:vindesite_block. Creates unilib:stone_vindesite_white_block
        part_name = "vindesite_white",
        orig_name = "underch:vindesite_block",

        replace_mode = underch_add_mode,
        description = S("White Vindesite Block"),
    })

    unilib.register_stone_brick({
        -- From underch:vindesite_brick. Creates unilib:stone_vindesite_white_brick
        part_name = "vindesite_white",
        orig_name = "underch:vindesite_brick",

        replace_mode = underch_add_mode,
        description = S("White Vindesite Bricks"),
    })

    unilib.register_stone_cobble({
        -- From underch:vindesite_cobble. Creates unilib:stone_vindesite_white_cobble
        part_name = "vindesite_white",
        orig_name = "underch:vindesite_cobble",

        replace_mode = underch_add_mode,
        description = S("White Vindesite Cobble"),
        wall_orig_name = "underch:vindesite_cobble_wall",
    })

    unilib.register_stone_cobble_mossy({
        -- From underch:vindesite_mossy_cobble. Creates unilib:stone_vindesite_white_cobble_mossy
        part_name = "vindesite_white",
        orig_name = "underch:vindesite_mossy_cobble",

        replace_mode = underch_add_mode,
        description = S("Mossy White Vindesite Cobble"),
        wall_orig_name = "underch:vindesite_mossy_cobble_wall",
    })

    unilib.register_stone_cobble_compressed({
        -- From compressed:vindesite. Creates unilib:stone_vindesite_white_cobble_compressed
        part_name = "vindesite_white",
        orig_name = "compressed:vindesite",

        replace_mode = compressed_add_mode,
        description = S("Compressed White Vindesite Cobble"),
    })

    unilib.register_stone_cobble_condensed({
        -- From condensed:vindesite. Creates unilib:stone_vindesite_white_cobble_condensed
        part_name = "vindesite_white",
        orig_name = "condensed:vindesite",

        replace_mode = condensed_add_mode,
        description = S("Condensed White Vindesite Cobble"),
    })

end
