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

unilib.pkg.stone_phonolite = {}

local S = unilib.intllib
local underch_add_mode = unilib.global.imported_mod_table.underch.add_mode
local compressed_add_mode = unilib.global.imported_mod_table.compressed.add_mode
local condensed_add_mode = unilib.global.imported_mod_table.condensed.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_phonolite.init()

    return {
        description = "Phonolite",
    }

end

function unilib.pkg.stone_phonolite.exec()

    unilib.register_stone({
        -- Original to unilib
        part_name = "phonolite",
        description = S("Phonolite"),

        category = "extrusive",
        colour = "#616256",
        grinder_flag = true,
        -- (N.B. In-game hardness adjusted to match original mod's code, should be 3)
        hardness = 1,
        hardness_real = 3,
        moss_flag = true,
        platform_flag = true,
    })

    unilib.register_stone_smooth({
        -- From underch:phonolite. Creates unilib:stone_phonolite
        part_name = "phonolite",
        orig_name = "underch:phonolite",

        replace_mode = underch_add_mode,
        cobble_mode = "cobble",
        description = S("Phonolite"),
    })

    unilib.register_stone_block({
        -- From underch:phonolite_block. Creates unilib:stone_phonolite_block
        part_name = "phonolite",
        orig_name = "underch:phonolite_block",

        replace_mode = underch_add_mode,
        description = S("Phonolite Block"),
    })

    unilib.register_stone_brick({
        -- From underch:phonolite_brick. Creates unilib:stone_phonolite_brick
        part_name = "phonolite",
        orig_name = "underch:phonolite_brick",

        replace_mode = underch_add_mode,
        description = S("Phonolite Bricks"),
    })

    unilib.register_stone_cobble({
        -- From underch:phonolite_cobble. Creates unilib:stone_phonolite_cobble
        part_name = "phonolite",
        orig_name = "underch:phonolite_cobble",

        replace_mode = underch_add_mode,
        description = S("Phonolite Cobble"),
        wall_orig_name = "underch:phonolite_cobble_wall",
    })

    unilib.register_stone_cobble_mossy({
        -- From underch:phonolite_mossy_cobble. Creates unilib:stone_phonolite_cobble_mossy
        part_name = "phonolite",
        orig_name = "underch:phonolite_mossy_cobble",

        replace_mode = underch_add_mode,
        description = S("Mossy Phonolite Cobble"),
        wall_orig_name = "underch:phonolite_mossy_cobble_wall",
    })

    unilib.register_stone_cobble_compressed({
        -- From compressed:phonolite. Creates unilib:stone_phonolite_cobble_compressed
        part_name = "phonolite",
        orig_name = "compressed:phonolite",

        replace_mode = compressed_add_mode,
        description = S("Compressed Phonolite Cobble"),
    })

    unilib.register_stone_cobble_condensed({
        -- From condensed:phonolite. Creates unilib:stone_phonolite_cobble_condensed
        part_name = "phonolite",
        orig_name = "condensed:phonolite",

        replace_mode = condensed_add_mode,
        description = S("Condensed Phonolite Cobble"),
    })

end
