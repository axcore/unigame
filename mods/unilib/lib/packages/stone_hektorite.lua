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

unilib.pkg.stone_hektorite = {}

local S = unilib.intllib
local underch_add_mode = unilib.imported_mod_table.underch.add_mode
local compressed_add_mode = unilib.imported_mod_table.compressed.add_mode
local condensed_add_mode = unilib.imported_mod_table.condensed.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_hektorite.init()

    return {
        description = "Hektorite",
    }

end

function unilib.pkg.stone_hektorite.exec()

    unilib.register_stone({
        -- Original to unilib
        part_name = "hektorite",
        description = S("Hektorite"),

        category = "other",
        fictional_flag = true,
        grinder_flag = true,
        hardness = 1,
        platform_flag = true,
    })

    unilib.register_stone_smooth({
        -- From underch:hektorite. Creates unilib:stone_hektorite
        part_name = "hektorite",
        orig_name = "underch:hektorite",

        replace_mode = underch_add_mode,
        cobble_mode = "cobble",
        description = S("Hektorite"),
    })

    unilib.register_stone_block({
        -- From underch:hektorite_block. Creates unilib:stone_hektorite_block
        part_name = "hektorite",
        orig_name = "underch:hektorite_block",

        replace_mode = underch_add_mode,
        description = S("Hektorite Block"),
    })

    unilib.register_stone_brick({
        -- From underch:hektorite_brick. Creates unilib:stone_hektorite_brick
        part_name = "hektorite",
        orig_name = "underch:hektorite_brick",

        replace_mode = underch_add_mode,
        description = S("Hektorite Bricks"),
    })

    unilib.register_stone_cobble({
        -- From underch:hektorite_cobble. Creates unilib:stone_hektorite_cobble
        part_name = "hektorite",
        orig_name = "underch:hektorite_cobble",

        replace_mode = underch_add_mode,
        description = S("Hektorite Cobble"),
        wall_orig_name = "underch:hektorite_cobble_wall",
    })

    -- (no mossy cobble)

    if unilib.underch_tweak_flag then

        unilib.register_stone_cobble_compressed({
            -- From compressed:hektorite. Creates unilib:stone_hektorite_cobble_compressed
            part_name = "hektorite",
            orig_name = "compressed:hektorite",

            replace_mode = compressed_add_mode,
            description = S("Compressed Hektorite Cobble"),
        })

        unilib.register_stone_cobble_condensed({
            -- From condensed:hektorite. Creates unilib:stone_hektorite_cobble_condensed
            part_name = "hektorite",
            orig_name = "condensed:hektorite",

            replace_mode = condensed_add_mode,
            description = S("Condensed Hektorite Cobble"),
        })

    end

end
