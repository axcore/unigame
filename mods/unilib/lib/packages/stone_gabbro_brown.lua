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

unilib.pkg.stone_gabbro_brown = {}

local S = unilib.intllib
local underch_add_mode = unilib.global.imported_mod_table.underch.add_mode
local compressed_add_mode = unilib.global.imported_mod_table.compressed.add_mode
local condensed_add_mode = unilib.global.imported_mod_table.condensed.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_gabbro_brown.init()

    return {
        description = "Brown gabbro",
    }

end

function unilib.pkg.stone_gabbro_brown.exec()

    unilib.register_stone({
        -- Original to unilib
        part_name = "gabbro_brown",
        description = S("Brown Gabbro"),

        category = "intrusive",
        colour = "#4A3C3D",
        grinder_flag = true,
        -- (N.B. In-game hardness adjusted to match original mod's code, should be 4)
        hardness = 1,
        hardness_real = 4,
        moss_flag = true,
        platform_flag = true,
    })

    unilib.register_stone_smooth({
        -- From underch:gabbro. Creates unilib:stone_gabbro_brown
        part_name = "gabbro_brown",
        orig_name = "underch:gabbro",

        replace_mode = underch_add_mode,
        cobble_mode = "cobble",
        description = S("Brown Gabbro"),
    })

    unilib.register_stone_block({
        -- From underch:gabbro_block. Creates unilib:stone_gabbro_brown_block
        part_name = "gabbro_brown",
        orig_name = "underch:gabbro_block",

        replace_mode = underch_add_mode,
        description = S("Brown Gabbro Block"),
    })

    unilib.register_stone_brick({
        -- From underch:gabbro_brick. Creates unilib:stone_gabbro_brown_brick
        part_name = "gabbro_brown",
        orig_name = "underch:gabbro_brick",

        replace_mode = underch_add_mode,
        description = S("Brown Gabbro Bricks"),
    })

    unilib.register_stone_cobble({
        -- From underch:gabbro_cobble. Creates unilib:stone_gabbro_brown_cobble
        part_name = "gabbro_brown",
        orig_name = "underch:gabbro_cobble",

        replace_mode = underch_add_mode,
        description = S("Brown Gabbro Cobble"),
        wall_orig_name = "underch:gabbro_cobble_wall",
    })

    unilib.register_stone_cobble_mossy({
        -- From underch:gabbro_mossy_cobble. Creates unilib:stone_gabbro_brown_cobble_mossy
        part_name = "gabbro_brown",
        orig_name = "underch:gabbro_mossy_cobble",

        replace_mode = underch_add_mode,
        description = S("Mossy Brown Gabbro Cobble"),
        wall_orig_name = "underch:gabbro_mossy_cobble_wall",
    })

    unilib.register_stone_cobble_compressed({
        -- From compressed:gabbro. Creates unilib:stone_gabbro_brown_cobble_compressed
        part_name = "gabbro_brown",
        orig_name = "compressed:gabbro",

        replace_mode = compressed_add_mode,
        description = S("Compressed Brown Gabbro Cobble"),
    })

    unilib.register_stone_cobble_condensed({
        -- From condensed:gabbro. Creates unilib:stone_gabbro_brown_cobble_condensed
        part_name = "gabbro_brown",
        orig_name = "condensed:gabbro",

        replace_mode = condensed_add_mode,
        description = S("Condensed Brown Gabbro Cobble"),
    })

end
