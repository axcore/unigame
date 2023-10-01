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

unilib.pkg.stone_slimestone_green = {}

local S = unilib.intllib
local underch_add_mode = unilib.imported_mod_table.underch.add_mode
local compressed_add_mode = unilib.imported_mod_table.compressed.add_mode
local condensed_add_mode = unilib.imported_mod_table.condensed.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_slimestone_green.init()

    return {
        description = "Green slimestone",
    }

end

function unilib.pkg.stone_slimestone_green.exec()

    unilib.register_stone({
        -- Original to unilib
        part_name = "slimestone_green",
        description = S("Green Slimestone"),

        category = "other",
        fictional_flag = true,
        grinder_flag = true,
        hardness = 1,
        platform_flag = true,
    })

    unilib.register_stone_smooth({
        -- From underch:green_slimestone. Creates unilib:stone_slimestone_green
        part_name = "slimestone_green",
        orig_name = "underch:green_slimestone",

        replace_mode = underch_add_mode,
        cobble_mode = "cobble",
        description = S("Green Slimestone"),
    })

    unilib.register_stone_block({
        -- From underch:green_slimestone_block. Creates unilib:stone_slimestone_green_block
        part_name = "slimestone_green",
        orig_name = "underch:green_slimestone_block",

        replace_mode = underch_add_mode,
        description = S("Green Slimestone Block"),
    })

    unilib.register_stone_brick({
        -- From underch:green_slimestone_brick. Creates unilib:stone_slimestone_green_brick
        part_name = "slimestone_green",
        orig_name = "underch:green_slimestone_brick",

        replace_mode = underch_add_mode,
        description = S("Green Slimestone Bricks"),
    })

    unilib.register_stone_cobble({
        -- From underch:green_slimestone_cobble. Creates unilib:stone_slimestone_green_cobble
        part_name = "slimestone_green",
        orig_name = "underch:green_slimestone_cobble",

        replace_mode = underch_add_mode,
        description = S("Green Slimestone Cobble"),
        wall_orig_name = "underch:green_slimestone_cobble_wall",
    })

    -- (no mossy cobble)

    if unilib.underch_tweak_flag then

        unilib.register_stone_cobble_compressed({
            -- From compressed:green_slimestone. Creates
            --      unilib:stone_slimestone_green_cobble_compressed
            part_name = "slimestone_green",
            orig_name = "compressed:green_slimestone",

            replace_mode = compressed_add_mode,
            description = S("Compressed Green Slimestone Cobble"),
        })

        unilib.register_stone_cobble_condensed({
            -- From condensed:green_slimestone. Creates
            --      unilib:stone_slimestone_green_cobble_condensed
            part_name = "slimestone_green",
            orig_name = "condensed:green_slimestone",

            replace_mode = condensed_add_mode,
            description = S("Condensed Green Slimestone Cobble"),
        })

    end

end
