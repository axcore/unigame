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

unilib.pkg.stone_gneiss_black = {}

local S = unilib.intllib
local underch_add_mode = unilib.imported_mod_table.underch.add_mode
local compressed_add_mode = unilib.imported_mod_table.compressed.add_mode
local condensed_add_mode = unilib.imported_mod_table.condensed.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_gneiss_black.init()

    return {
        description = "Black gneiss",
    }

end

function unilib.pkg.stone_gneiss_black.exec()

    unilib.register_stone({
        -- Original to unilib
        part_name = "gneiss_black",
        description = S("Black Gneiss"),

        category = "metamorphic",
        grinder_flag = true,
        -- (N.B. In-game hardness adjusted to match original mod's code, should be 3)
        hardness = 1,
        hardness_real = 3,
        moss_flag = true,
        platform_flag = true,
    })

    unilib.register_stone_smooth({
        -- From underch:gneiss. Creates unilib:stone_gneiss_black
        part_name = "gneiss_black",
        orig_name = "underch:gneiss",

        replace_mode = underch_add_mode,
        cobble_mode = "cobble",
        description = S("Black Gneiss"),
    })

    unilib.register_stone_block({
        -- From underch:gneiss_block. Creates unilib:stone_gneiss_black_block
        part_name = "gneiss_black",
        orig_name = "underch:gneiss_block",

        replace_mode = underch_add_mode,
        description = S("Black Gneiss Block"),
    })

    unilib.register_stone_brick({
        -- From underch:gneiss_brick. Creates unilib:stone_gneiss_black_brick
        part_name = "gneiss_black",
        orig_name = "underch:gneiss_brick",

        replace_mode = underch_add_mode,
        description = S("Black Gneiss Bricks"),
    })

    unilib.register_stone_cobble({
        -- From underch:gneiss_cobble. Creates unilib:stone_gneiss_black_cobble
        part_name = "gneiss_black",
        orig_name = "underch:gneiss_cobble",

        replace_mode = underch_add_mode,
        description = S("Black Gneiss Cobble"),
        wall_orig_name = "underch:gneiss_cobble_wall",
    })

    unilib.register_stone_cobble_mossy({
        -- From underch:gneiss_mossy_cobble. Creates unilib:stone_gneiss_black_cobble_mossy
        part_name = "gneiss_black",
        orig_name = "underch:gneiss_mossy_cobble",

        replace_mode = underch_add_mode,
        description = S("Mossy Black Gneiss Cobble"),
        wall_orig_name = "underch:gneiss_mossy_cobble_wall",
    })

    if unilib.underch_tweak_flag then

        unilib.register_stone_cobble_compressed({
            -- From compressed:gneiss. Creates unilib:stone_gneiss_black_cobble_compressed
            part_name = "gneiss_black",
            orig_name = "compressed:gneiss",

            replace_mode = compressed_add_mode,
            description = S("Compressed Black Gneiss Cobble"),
        })

        unilib.register_stone_cobble_condensed({
            -- From condensed:gneiss. Creates unilib:stone_gneiss_black_cobble_condensed
            part_name = "gneiss_black",
            orig_name = "condensed:gneiss",

            replace_mode = condensed_add_mode,
            description = S("Condensed Black Gneiss Cobble"),
        })

    end

end
