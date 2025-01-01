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

unilib.pkg.stone_emutite = {}

local S = unilib.intllib
local underch_add_mode = unilib.global.imported_mod_table.underch.add_mode
local compressed_add_mode = unilib.global.imported_mod_table.compressed.add_mode
local condensed_add_mode = unilib.global.imported_mod_table.condensed.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_emutite.init()

    return {
        description = "Emutite",
    }

end

function unilib.pkg.stone_emutite.exec()

    unilib.register_stone({
        -- Original to unilib
        part_name = "emutite",
        description = S("Emutite"),

        category = "other",
        colour = "#ED8786",
        fictional_flag = true,
        grinder_flag = true,
        hardness = 1,
        platform_flag = true,
    })

    unilib.register_stone_smooth({
        -- From underch:emutite. Creates unilib:stone_emutite
        part_name = "emutite",
        orig_name = "underch:emutite",

        replace_mode = underch_add_mode,
        cobble_mode = "cobble",
        description = S("Emutite"),
    })

    unilib.register_stone_block({
        -- From underch:emutite_block. Creates unilib:stone_emutite_block
        part_name = "emutite",
        orig_name = "underch:emutite_block",

        replace_mode = underch_add_mode,
        description = S("Emutite Block"),
    })

    unilib.register_stone_brick({
        -- From underch:emutite_brick. Creates unilib:stone_emutite_brick
        part_name = "emutite",
        orig_name = "underch:emutite_brick",

        replace_mode = underch_add_mode,
        description = S("Emutite Bricks"),
    })

    unilib.register_stone_cobble({
        -- From underch:emutite_cobble. Creates unilib:stone_emutite_cobble
        part_name = "emutite",
        orig_name = "underch:emutite_cobble",

        replace_mode = underch_add_mode,
        description = S("Emutite Cobble"),
        wall_orig_name = "underch:emutite_cobble_wall",
    })

    -- (no mossy cobble)

    unilib.register_stone_cobble_compressed({
        -- From compressed:emutite. Creates unilib:stone_emutite_cobble_compressed
        part_name = "emutite",
        orig_name = "compressed:emutite",

        replace_mode = compressed_add_mode,
        description = S("Compressed Emutite Cobble"),
    })

    unilib.register_stone_cobble_condensed({
        -- From condensed:emutite. Creates unilib:stone_emutite_cobble_condensed
        part_name = "emutite",
        orig_name = "condensed:emutite",

        replace_mode = condensed_add_mode,
        description = S("Condensed Emutite Cobble"),
    })

end
