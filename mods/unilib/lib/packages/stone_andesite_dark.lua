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

unilib.pkg.stone_andesite_dark = {}

local S = unilib.intllib
local underch_add_mode = unilib.imported_mod_table.underch.add_mode
local compressed_add_mode = unilib.imported_mod_table.compressed.add_mode
local condensed_add_mode = unilib.imported_mod_table.condensed.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_andesite_dark.init()

    return {
        description = "Dark Andesite",
    }

end

function unilib.pkg.stone_andesite_dark.exec()

    unilib.register_stone({
        -- Original to unilib
        part_name = "andesite_dark",
        description = S("Dark Andesite"),

        category = "extrusive",
        grinder_flag = true,
        -- (N.B. In-game hardness adjusted to match original mod's code, should be 3)
        hardness = 1,
        hardness_real = 3,
        moss_flag = true,
        platform_flag = true,
    })

    unilib.register_stone_smooth({
        -- From underch:andesite. Creates unilib:stone_andesite_dark
        part_name = "andesite_dark",
        orig_name = "underch:andesite",

        replace_mode = underch_add_mode,
        cobble_mode = "cobble",
        description = S("Dark Andesite"),
    })

    unilib.register_stone_block({
        -- From underch:andesite_block. Creates unilib:stone_andesite_dark_block
        part_name = "andesite_dark",
        orig_name = "underch:andesite_block",

        replace_mode = underch_add_mode,
        description = S("Dark Andesite Block"),
    })

    unilib.register_stone_brick({
        -- From underch:andesite_brick. Creates unilib:stone_andesite_dark_brick
        part_name = "andesite_dark",
        orig_name = "underch:andesite_brick",

        replace_mode = underch_add_mode,
        description = S("Dark Andesite Bricks"),
    })

    unilib.register_stone_cobble({
        -- From underch:andesite_cobble. Creates unilib:stone_andesite_dark_cobble
        part_name = "andesite_dark",
        orig_name = "underch:andesite_cobble",

        replace_mode = underch_add_mode,
        description = S("Dark Andesite Cobble"),
        wall_orig_name = "underch:andesite_cobble_wall",
    })

    unilib.register_stone_cobble_mossy({
        -- From underch:andesite_mossy_cobble. Creates unilib:stone_andesite_dark_cobble_mossy
        part_name = "andesite_dark",
        orig_name = "underch:andesite_mossy_cobble",

        replace_mode = underch_add_mode,
        description = S("Mossy Dark Andesite Cobble"),
        wall_orig_name = "underch:andesite_mossy_cobble_wall",
    })

    if unilib.underch_tweak_flag then

        unilib.register_stone_cobble_compressed({
            -- From compressed:andesite. Creates unilib:stone_andesite_dark_cobble_compressed
            part_name = "andesite_dark",
            orig_name = "compressed:andesite",

            replace_mode = compressed_add_mode,
            description = S("Compressed Dark Andesite Cobble"),
        })

        unilib.register_stone_cobble_condensed({
            -- From condensed:andesite. Creates unilib:stone_andesite_dark_cobble_condensed
            part_name = "andesite_dark",
            orig_name = "condensed:andesite",

            replace_mode = condensed_add_mode,
            description = S("Condensed Dark Andesite Cobble"),
        })

    end

end
