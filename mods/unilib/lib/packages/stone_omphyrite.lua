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

unilib.pkg.stone_omphyrite = {}

local S = unilib.intllib
local underch_add_mode = unilib.global.imported_mod_table.underch.add_mode
local compressed_add_mode = unilib.global.imported_mod_table.compressed.add_mode
local condensed_add_mode = unilib.global.imported_mod_table.condensed.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_omphyrite.init()

    return {
        description = "Omphyrite",
    }

end

function unilib.pkg.stone_omphyrite.exec()

    unilib.register_stone({
        -- Original to unilib
        part_name = "omphyrite",
        description = S("Omphyrite"),

        category = "other",
        colour = "#E6BE63",
        fictional_flag = true,
        grinder_flag = true,
        hardness = 1,
        platform_flag = true,
    })

    unilib.register_stone_smooth({
        -- From underch:omphyrite. Creates unilib:stone_omphyrite
        part_name = "omphyrite",
        orig_name = "underch:omphyrite",

        replace_mode = underch_add_mode,
        cobble_mode = "cobble",
        description = S("Omphyrite"),
    })

    unilib.register_stone_block({
        -- From underch:omphyrite_block. Creates unilib:stone_omphyrite_block
        part_name = "omphyrite",
        orig_name = "underch:omphyrite_block",

        replace_mode = underch_add_mode,
        description = S("Omphyrite Block"),
    })

    unilib.register_stone_brick({
        -- From underch:omphyrite_brick. Creates unilib:stone_omphyrite_brick
        part_name = "omphyrite",
        orig_name = "underch:omphyrite_brick",

        replace_mode = underch_add_mode,
        description = S("Omphyrite Bricks"),
    })

    unilib.register_stone_cobble({
        -- From underch:omphyrite_cobble. Creates unilib:stone_omphyrite_cobble
        part_name = "omphyrite",
        orig_name = "underch:omphyrite_cobble",

        replace_mode = underch_add_mode,
        description = S("Omphyrite Cobble"),
        wall_orig_name = "underch:omphyrite_cobble_wall",
    })

    -- (no mossy cobble)

    unilib.register_stone_cobble_compressed({
        -- From compressed:omphyrite. Creates unilib:stone_omphyrite_cobble_compressed
        part_name = "omphyrite",
        orig_name = "compressed:omphyrite",

        replace_mode = compressed_add_mode,
        description = S("Compressed Omphyrite Cobble"),
    })

    unilib.register_stone_cobble_condensed({
        -- From condensed:omphyrite. Creates unilib:stone_omphyrite_cobble_condensed
        part_name = "omphyrite",
        orig_name = "condensed:omphyrite",

        replace_mode = condensed_add_mode,
        description = S("Condensed Omphyrite Cobble"),
    })

end
