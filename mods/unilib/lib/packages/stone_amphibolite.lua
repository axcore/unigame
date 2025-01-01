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

unilib.pkg.stone_amphibolite = {}

local S = unilib.intllib
local underch_add_mode = unilib.global.imported_mod_table.underch.add_mode
local compressed_add_mode = unilib.global.imported_mod_table.compressed.add_mode
local condensed_add_mode = unilib.global.imported_mod_table.condensed.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_amphibolite.init()

    return {
        description = "Amphibolite",
    }

end

function unilib.pkg.stone_amphibolite.exec()

    unilib.register_stone({
        -- Original to unilib
        part_name = "amphibolite",
        description = S("Amphibolite"),

        category = "metamorphic",
        colour = "#787768",
        grinder_flag = true,
        -- (N.B. In-game hardness adjusted to match original mod's code, should be 2)
        hardness = 1,
        hardness_real = 2,
        moss_flag = true,
        platform_flag = true,
    })

    unilib.register_stone_smooth({
        -- From underch:amphibolite. Creates unilib:stone_amphibolite
        part_name = "amphibolite",
        orig_name = "underch:amphibolite",

        replace_mode = underch_add_mode,
        cobble_mode = "cobble",
        description = S("Amphibolite"),
    })

    unilib.register_stone_block({
        -- From underch:amphibolite_block. Creates unilib:stone_amphibolite_block
        part_name = "amphibolite",
        orig_name = "underch:amphibolite_block",

        replace_mode = underch_add_mode,
        description = S("Amphibolite Block"),
    })

    unilib.register_stone_brick({
        -- From underch:amphibolite_brick. Creates unilib:stone_amphibolite_brick
        part_name = "amphibolite",
        orig_name = "underch:amphibolite_brick",

        replace_mode = underch_add_mode,
        description = S("Amphibolite Bricks"),
    })

    unilib.register_stone_cobble({
        -- From underch:amphibolite_cobble. Creates unilib:stone_amphibolite_cobble
        part_name = "amphibolite",
        orig_name = "underch:amphibolite_cobble",

        replace_mode = underch_add_mode,
        description = S("Amphibolite Cobble"),
        wall_orig_name = "underch:amphibolite_cobble_wall",
    })

    unilib.register_stone_cobble_mossy({
        -- From underch:amphibolite_mossy_cobble. Creates unilib:stone_amphibolite_cobble_mossy
        part_name = "amphibolite",
        orig_name = "underch:amphibolite_mossy_cobble",

        replace_mode = underch_add_mode,
        description = S("Mossy Amphibolite Cobble"),
        wall_orig_name = "underch:amphibolite_mossy_cobble_wall",
    })

    unilib.register_stone_cobble_compressed({
        -- From compressed:amphibolite. Creates unilib:stone_amphibolite_cobble_compressed
        part_name = "amphibolite",
        orig_name = "compressed:amphibolite",

        replace_mode = compressed_add_mode,
        description = S("Compressed Amphibolite Cobble"),
    })

    unilib.register_stone_cobble_condensed({
        -- From condensed:amphibolite. Creates unilib:stone_amphibolite_cobble_condensed
        part_name = "amphibolite",
        orig_name = "condensed:amphibolite",

        replace_mode = condensed_add_mode,
        description = S("Condensed Amphibolite Cobble"),
    })

end
