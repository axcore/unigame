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

unilib.pkg.stone_peridotite_dark = {}

local S = unilib.intllib
local underch_add_mode = unilib.global.imported_mod_table.underch.add_mode
local compressed_add_mode = unilib.global.imported_mod_table.compressed.add_mode
local condensed_add_mode = unilib.global.imported_mod_table.condensed.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_peridotite_dark.init()

    return {
        description = "Dark peridotite",
    }

end

function unilib.pkg.stone_peridotite_dark.exec()

    unilib.register_stone({
        -- Original to unilib
        part_name = "peridotite_dark",
        description = S("Dark Peridotite"),

        category = "intrusive",
        colour = "#6F737C",
        grinder_flag = true,
        -- (N.B. In-game hardness adjusted to match original mod's code, should be 4)
        hardness = 1,
        hardness_real = 4,
        moss_flag = true,
        platform_flag = true,
    })

    unilib.register_stone_smooth({
        -- From underch:peridotite. Creates unilib:stone_peridotite_dark
        part_name = "peridotite_dark",
        orig_name = "underch:peridotite",

        replace_mode = underch_add_mode,
        cobble_mode = "cobble",
        description = S("Dark Peridotite"),
    })

    unilib.register_stone_block({
        -- From underch:peridotite_block. Creates unilib:stone_peridotite_dark_block
        part_name = "peridotite_dark",
        orig_name = "underch:peridotite_block",

        replace_mode = underch_add_mode,
        description = S("Dark Peridotite Block"),
    })

    unilib.register_stone_brick({
        -- From underch:peridotite_brick. Creates unilib:stone_peridotite_dark_brick
        part_name = "peridotite_dark",
        orig_name = "underch:peridotite_brick",

        replace_mode = underch_add_mode,
        description = S("Dark Peridotite Bricks"),
    })

    unilib.register_stone_cobble({
        -- From underch:peridotite_cobble. Creates unilib:stone_peridotite_dark_cobble
        part_name = "peridotite_dark",
        orig_name = "underch:peridotite_cobble",

        replace_mode = underch_add_mode,
        description = S("Dark Peridotite Cobble"),
        wall_orig_name = "underch:peridotite_cobble_wall",
    })

    unilib.register_stone_cobble_mossy({
        -- From underch:peridotite_mossy_cobble. Creates unilib:stone_peridotite_dark_cobble_mossy
        part_name = "peridotite_dark",
        orig_name = "underch:peridotite_mossy_cobble",

        replace_mode = underch_add_mode,
        description = S("Mossy Dark Peridotite Cobble"),
        wall_orig_name = "underch:peridotite_mossy_cobble_wall",
    })

    unilib.register_stone_cobble_compressed({
        -- From compressed:peridotite. Creates unilib:stone_peridotite_dark_cobble_compressed
        part_name = "peridotite_dark",
        orig_name = "compressed:peridotite",

        replace_mode = compressed_add_mode,
        description = S("Compressed Dark Peridotite Cobble"),
    })

    unilib.register_stone_cobble_condensed({
        -- From condensed:peridotite. Creates unilib:stone_peridotite_dark_cobble_condensed
        part_name = "peridotite_dark",
        orig_name = "condensed:peridotite",

        replace_mode = condensed_add_mode,
        description = S("Condensed Dark Peridotite Cobble"),
    })

end
