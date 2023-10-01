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

unilib.pkg.stone_afualite = {}

local S = unilib.intllib
local underch_add_mode = unilib.imported_mod_table.underch.add_mode
local compressed_add_mode = unilib.imported_mod_table.compressed.add_mode
local condensed_add_mode = unilib.imported_mod_table.condensed.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_afualite.init()

    return {
        description = "Afualite",
    }

end

function unilib.pkg.stone_afualite.exec()

    unilib.register_stone({
        -- Original to unilib
        part_name = "afualite",
        description = S("Afualite"),

        category = "other",
        fictional_flag = true,
        grinder_flag = true,
        hardness = 1,
        platform_flag = true,
    })

    unilib.register_stone_smooth({
        -- From underch:afualite. Creates unilib:stone_afualite
        part_name = "afualite",
        orig_name = "underch:afualite",

        replace_mode = underch_add_mode,
        cobble_mode = "cobble",
        description = S("Afualite"),
    })

    unilib.register_stone_block({
        -- From underch:afualite_block. Creates unilib:stone_afualite_block
        part_name = "afualite",
        orig_name = "underch:afualite_block",

        replace_mode = underch_add_mode,
        description = S("Afualite Block"),
    })

    unilib.register_stone_brick({
        -- From underch:afualite_brick. Creates unilib:stone_afualite_brick
        part_name = "afualite",
        orig_name = "underch:afualite_brick",

        replace_mode = underch_add_mode,
        description = S("Afualite Bricks"),
    })

    unilib.register_stone_cobble({
        -- From underch:afualite_cobble. Creates unilib:stone_afualite_cobble
        part_name = "afualite",
        orig_name = "underch:afualite_cobble",

        replace_mode = underch_add_mode,
        description = S("Afualite Cobble"),
        wall_orig_name = "underch:afualite_cobble_wall",
    })

    -- (no mossy cobble)

    if unilib.underch_tweak_flag then

        unilib.register_stone_cobble_compressed({
            -- From compressed:afualite. Creates unilib:stone_afualite_cobble_compressed
            part_name = "afualite",
            orig_name = "compressed:afualite",

            replace_mode = compressed_add_mode,
            description = S("Compressed Afualite Cobble"),
        })

        unilib.register_stone_cobble_condensed({
            -- From condensed:afualite. Creates unilib:stone_afualite_cobble_condensed
            part_name = "afualite",
            orig_name = "condensed:afualite",

            replace_mode = condensed_add_mode,
            description = S("Condensed Afualite Cobble"),
        })

    end

end
