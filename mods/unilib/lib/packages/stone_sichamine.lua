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

unilib.pkg.stone_sichamine = {}

local S = unilib.intllib
local underch_add_mode = unilib.imported_mod_table.underch.add_mode
local compressed_add_mode = unilib.imported_mod_table.compressed.add_mode
local condensed_add_mode = unilib.imported_mod_table.condensed.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_sichamine.init()

    return {
        description = "Sichamine",
    }

end

function unilib.pkg.stone_sichamine.exec()

    unilib.register_stone({
        -- Original to unilib
        part_name = "sichamine",
        description = S("Sichamine"),

        category = "other",
        fictional_flag = true,
        grinder_flag = true,
        hardness = 1,
        moss_flag = true,
        platform_flag = true,
    })

    unilib.register_stone_smooth({
        -- From underch:sichamine. Creates unilib:stone_sichamine
        part_name = "sichamine",
        orig_name = "underch:sichamine",

        replace_mode = underch_add_mode,
        cobble_mode = "cobble",
        description = S("Sichamine"),
    })

    unilib.register_stone_block({
        -- From underch:sichamine_block. Creates unilib:stone_sichamine_block
        part_name = "sichamine",
        orig_name = "underch:sichamine_block",

        replace_mode = underch_add_mode,
        description = S("Sichamine Block"),
    })

    unilib.register_stone_brick({
        -- From underch:sichamine_brick. Creates unilib:stone_sichamine_brick
        part_name = "sichamine",
        orig_name = "underch:sichamine_brick",

        replace_mode = underch_add_mode,
        description = S("Sichamine Bricks"),
    })

    unilib.register_stone_cobble({
        -- From underch:sichamine_cobble. Creates unilib:stone_sichamine_cobble
        part_name = "sichamine",
        orig_name = "underch:sichamine_cobble",

        replace_mode = underch_add_mode,
        description = S("Sichamine Cobble"),
        wall_orig_name = "underch:sichamine_cobble_wall",
    })

    unilib.register_stone_cobble_mossy({
        -- From underch:sichamine_mossy_cobble. Creates unilib:stone_sichamine_cobble_mossy
        part_name = "sichamine",
        orig_name = "underch:sichamine_mossy_cobble",

        replace_mode = underch_add_mode,
        description = S("Weedy Sichamine Cobble"),
        wall_orig_name = "underch:sichamine_mossy_cobble_wall",
    })

    if unilib.underch_tweak_flag then

        unilib.register_stone_cobble_compressed({
            -- From compressed:sichamine. Creates unilib:stone_sichamine_cobble_compressed
            part_name = "sichamine",
            orig_name = "compressed:sichamine",

            replace_mode = compressed_add_mode,
            description = S("Compressed Sichamine Cobble"),
        })

        unilib.register_stone_cobble_condensed({
            -- From condensed:sichamine. Creates unilib:stone_sichamine_cobble_condensed
            part_name = "sichamine",
            orig_name = "condensed:sichamine",

            replace_mode = condensed_add_mode,
            description = S("Condensed Sichamine Cobble"),
        })

    end

end
