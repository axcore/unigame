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

unilib.pkg.stone_slimestone_purple = {}

local S = unilib.intllib
local underch_add_mode = unilib.global.imported_mod_table.underch.add_mode
local compressed_add_mode = unilib.global.imported_mod_table.compressed.add_mode
local condensed_add_mode = unilib.global.imported_mod_table.condensed.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_slimestone_purple.init()

    return {
        description = "Purple slimestone",
    }

end

function unilib.pkg.stone_slimestone_purple.exec()

    unilib.register_stone({
        -- Original to unilib
        part_name = "slimestone_purple",
        description = S("Purple Slimestone"),

        category = "other",
        colour = "#E03FD3",
        fictional_flag = true,
        grinder_flag = true,
        hardness = 1,
        platform_flag = true,
    })

    unilib.register_stone_smooth({
        -- From underch:purple_slimestone. Creates unilib:stone_slimestone_purple
        part_name = "slimestone_purple",
        orig_name = "underch:purple_slimestone",

        replace_mode = underch_add_mode,
        cobble_mode = "cobble",
        description = S("Purple Slimestone"),
    })

    unilib.register_stone_block({
        -- From underch:purple_slimestone_block. Creates unilib:stone_slimestone_purple_block
        part_name = "slimestone_purple",
        orig_name = "underch:purple_slimestone_block",

        replace_mode = underch_add_mode,
        description = S("Purple Slimestone Block"),
    })

    unilib.register_stone_brick({
        -- From underch:purple_slimestone_brick. Creates unilib:stone_slimestone_purple_brick
        part_name = "slimestone_purple",
        orig_name = "underch:purple_slimestone_brick",

        replace_mode = underch_add_mode,
        description = S("Purple Slimestone Bricks"),
    })

    unilib.register_stone_cobble({
        -- From underch:purple_slimestone_cobble. Creates unilib:stone_slimestone_purple_cobble
        part_name = "slimestone_purple",
        orig_name = "underch:purple_slimestone_cobble",

        replace_mode = underch_add_mode,
        description = S("Purple Slimestone Cobble"),
        wall_orig_name = "underch:purple_slimestone_cobble_wall",
    })

    -- (no mossy cobble)

    unilib.register_stone_cobble_compressed({
        -- From compressed:purple_slimestone. Creates
        --      unilib:stone_slimestone_purple_cobble_compressed
        part_name = "slimestone_purple",
        orig_name = "compressed:purple_slimestone",

        replace_mode = compressed_add_mode,
        description = S("Compressed Purple Slimestone Cobble"),
    })

    unilib.register_stone_cobble_condensed({
        -- From condensed:purple_slimestone. Creates
        --      unilib:stone_slimestone_purple_cobble_condensed
        part_name = "slimestone_purple",
        orig_name = "condensed:purple_slimestone",

        replace_mode = condensed_add_mode,
        description = S("Condensed Purple Slimestone Cobble"),
    })

end
