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

unilib.pkg.stone_phyllite = {}

local S = unilib.intllib
local underch_add_mode = unilib.imported_mod_table.underch.add_mode
local compressed_add_mode = unilib.imported_mod_table.compressed.add_mode
local condensed_add_mode = unilib.imported_mod_table.condensed.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_phyllite.init()

    return {
        description = "Phyllite",
    }

end

function unilib.pkg.stone_phyllite.exec()

    unilib.register_stone({
        -- Original to unilib
        part_name = "phyllite",
        description = S("Phyllite"),

        category = "metamorphic",
        grinder_flag = true,
        hardness = 1,
        moss_flag = true,
        platform_flag = true,
    })

    unilib.register_stone_smooth({
        -- From underch:phylite. Creates unilib:stone_phyllite
        part_name = "phyllite",
        orig_name = "underch:phylite",

        replace_mode = underch_add_mode,
        cobble_mode = "cobble",
        description = S("Phyllite"),
    })

    unilib.register_stone_block({
        -- From underch:phylite_block. Creates unilib:stone_phyllite_block
        part_name = "phyllite",
        orig_name = "underch:phylite_block",

        replace_mode = underch_add_mode,
        description = S("Phyllite Block"),
    })

    unilib.register_stone_brick({
        -- From underch:phylite_brick. Creates unilib:stone_phyllite_brick
        part_name = "phyllite",
        orig_name = "underch:phylite_brick",

        replace_mode = underch_add_mode,
        description = S("Phyllite Bricks"),
    })

    unilib.register_stone_cobble({
        -- From underch:phylite_cobble. Creates unilib:stone_phyllite_cobble
        part_name = "phyllite",
        orig_name = "underch:phylite_cobble",

        replace_mode = underch_add_mode,
        description = S("Phyllite Cobble"),
        wall_orig_name = "underch:phylite_cobble_wall",
    })

    unilib.register_stone_cobble_mossy({
        -- From underch:phylite_mossy_cobble. Creates unilib:stone_phyllite_cobble_mossy
        part_name = "phyllite",
        orig_name = "underch:phylite_mossy_cobble",

        replace_mode = underch_add_mode,
        description = S("Mossy Phyllite Cobble"),
        wall_orig_name = "underch:phylite_mossy_cobble_wall",
    })

    if unilib.underch_tweak_flag then

        unilib.register_stone_cobble_compressed({
            -- From compressed:phylite. Creates unilib:stone_phyllite_cobble_compressed
            part_name = "phyllite",
            orig_name = "compressed:phylite",

            replace_mode = compressed_add_mode,
            description = S("Compressed Phyllite Cobble"),
        })

        unilib.register_stone_cobble_condensed({
            -- From condensed:phylite. Creates unilib:stone_phyllite_cobble_condensed
            part_name = "phyllite",
            orig_name = "condensed:phylite",

            replace_mode = condensed_add_mode,
            description = S("Condensed Phyllite Cobble"),
        })

    end

end
