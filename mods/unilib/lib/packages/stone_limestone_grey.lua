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

unilib.pkg.stone_limestone_grey = {}

local S = unilib.intllib
local underch_add_mode = unilib.global.imported_mod_table.underch.add_mode
local compressed_add_mode = unilib.global.imported_mod_table.compressed.add_mode
local condensed_add_mode = unilib.global.imported_mod_table.condensed.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_limestone_grey.init()

    return {
        description = "Grey limestone",
    }

end

function unilib.pkg.stone_limestone_grey.exec()

    unilib.register_stone({
        -- Original to unilib
        part_name = "limestone_grey",
        description = S("Grey Limestone"),

        category = "sedimentary",
        colour = "#AEA5A3",
        grinder_flag = true,
        hardness = 1,
        moss_flag = true,
        platform_flag = true,
    })

    unilib.register_stone_smooth({
        -- From underch:limestone. Creates unilib:stone_limestone_grey
        part_name = "limestone_grey",
        orig_name = "underch:limestone",

        replace_mode = underch_add_mode,
        cobble_mode = "cobble",
        description = S("Grey Limestone"),
        -- N.B. limestone = 1 not in original code
        group_table = {limestone = 1},
    })

    unilib.register_stone_block({
        -- From underch:limestone_block. Creates unilib:stone_limestone_grey_block
        part_name = "limestone_grey",
        orig_name = "underch:limestone_block",

        replace_mode = underch_add_mode,
        description = S("Grey Limestone Block"),
    })

    unilib.register_stone_brick({
        -- From underch:limestone_brick. Creates unilib:stone_limestone_grey_brick
        part_name = "limestone_grey",
        orig_name = "underch:limestone_brick",

        replace_mode = underch_add_mode,
        description = S("Grey Limestone Bricks"),
    })

    unilib.register_stone_cobble({
        -- From underch:limestone_cobble. Creates unilib:stone_limestone_grey_cobble
        part_name = "limestone_grey",
        orig_name = "underch:limestone_cobble",

        replace_mode = underch_add_mode,
        description = S("Grey Limestone Cobble"),
        wall_orig_name = "underch:limestone_cobble_wall",
    })

    unilib.register_stone_cobble_mossy({
        -- From underch:limestone_mossy_cobble. Creates unilib:stone_limestone_grey_cobble_mossy
        part_name = "limestone_grey",
        orig_name = "underch:limestone_mossy_cobble",

        replace_mode = underch_add_mode,
        description = S("Mossy Grey Limestone Cobble"),
        wall_orig_name = "underch:limestone_mossy_cobble_wall",
    })

    unilib.register_stone_cobble_compressed({
        -- From compressed:limestone. Creates unilib:stone_limestone_grey_cobble_compressed
        part_name = "limestone_grey",
        orig_name = "compressed:limestone",

        replace_mode = compressed_add_mode,
        description = S("Compressed Grey Limestone Cobble"),
    })

    unilib.register_stone_cobble_condensed({
        -- From condensed:limestone. Creates unilib:stone_limestone_grey_cobble_condensed
        part_name = "limestone_grey",
        orig_name = "condensed:limestone",

        replace_mode = condensed_add_mode,
        description = S("Condensed Grey Limestone Cobble"),
    })

end
