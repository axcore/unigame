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

unilib.pkg.stone_quartzite_brown = {}

local S = unilib.intllib
local underch_add_mode = unilib.global.imported_mod_table.underch.add_mode
local compressed_add_mode = unilib.global.imported_mod_table.compressed.add_mode
local condensed_add_mode = unilib.global.imported_mod_table.condensed.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_quartzite_brown.init()

    return {
        description = "Brown quartzite",
    }

end

function unilib.pkg.stone_quartzite_brown.exec()

    unilib.register_stone({
        -- Original to unilib
        part_name = "quartzite_brown",
        description = S("Brown Quartzite"),

        category = "metamorphic",
        colour = "#877A66",
        -- (N.B. In-game hardness adjusted to match original mod's code, should be 4)
        hardness = 1,
        hardness_real = 4,
        grinder_flag = true,
        moss_flag = true,
        platform_flag = true,
    })

    unilib.register_stone_smooth({
        -- From underch:quartzite. Creates unilib:stone_quartzite_brown
        part_name = "quartzite_brown",
        orig_name = "underch:quartzite",

        replace_mode = underch_add_mode,
        cobble_mode = "cobble",
        description = S("Brown Quartzite"),
    })

    unilib.register_stone_block({
        -- From underch:quartzite_block. Creates unilib:stone_quartzite_brown_block
        part_name = "quartzite_brown",
        orig_name = "underch:quartzite_block",

        replace_mode = underch_add_mode,
        description = S("Brown Quartzite Block"),
    })

    unilib.register_stone_brick({
        -- From underch:quartzite_brick. Creates unilib:stone_quartzite_brown_brick
        part_name = "quartzite_brown",
        orig_name = "underch:quartzite_brick",

        replace_mode = underch_add_mode,
        description = S("Brown Quartzite Bricks"),
    })

    unilib.register_stone_cobble({
        -- From underch:quartzite_cobble. Creates unilib:stone_quartzite_brown_cobble
        part_name = "quartzite_brown",
        orig_name = "underch:quartzite_cobble",

        replace_mode = underch_add_mode,
        description = S("Brown Quartzite Cobble"),
        wall_orig_name = "underch:quartzite_cobble_wall",
    })

    unilib.register_stone_cobble_mossy({
        -- From underch:quartzite_mossy_cobble. Creates unilib:stone_quartzite_brown_cobble_mossy
        part_name = "quartzite_brown",
        orig_name = "underch:quartzite_mossy_cobble",

        replace_mode = underch_add_mode,
        description = S("Mossy Brown Quartzite Cobble"),
        wall_orig_name = "underch:quartzite_mossy_cobble_wall",
    })

    unilib.register_stone_cobble_compressed({
        -- From compressed:quartzite. Creates unilib:stone_quartzite_brown_cobble_compressed
        part_name = "quartzite_brown",
        orig_name = "compressed:quartzite",

        replace_mode = compressed_add_mode,
        description = S("Compressed Brown Quartzite Cobble"),
    })

    unilib.register_stone_cobble_condensed({
        -- From condensed:quartzite. Creates unilib:stone_quartzite_brown_cobble_condensed
        part_name = "quartzite_brown",
        orig_name = "condensed:quartzite",

        replace_mode = condensed_add_mode,
        description = S("Condensed Brown Quartzite Cobble"),
    })

end
