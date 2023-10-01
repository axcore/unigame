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

unilib.pkg.stone_slimestone_red = {}

local S = unilib.intllib
local underch_add_mode = unilib.imported_mod_table.underch.add_mode
local compressed_add_mode = unilib.imported_mod_table.compressed.add_mode
local condensed_add_mode = unilib.imported_mod_table.condensed.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_slimestone_red.init()

    return {
        description = "Red slimestone",
    }

end

function unilib.pkg.stone_slimestone_red.exec()

    unilib.register_stone({
        -- Original to unilib
        part_name = "slimestone_red",
        description = S("Red Slimestone"),

        category = "other",
        fictional_flag = true,
        grinder_flag = true,
        hardness = 1,
        platform_flag = true,
    })

    unilib.register_stone_smooth({
        -- From underch:red_slimestone. Creates unilib:stone_slimestone_red
        part_name = "slimestone_red",
        orig_name = "underch:red_slimestone",

        replace_mode = underch_add_mode,
        cobble_mode = "cobble",
        description = S("Red Slimestone"),
    })

    unilib.register_stone_block({
        -- From underch:red_slimestone_block. Creates unilib:stone_slimestone_red_block
        part_name = "slimestone_red",
        orig_name = "underch:red_slimestone_block",

        replace_mode = underch_add_mode,
        description = S("Red Slimestone Block"),
    })

    unilib.register_stone_brick({
        -- From underch:red_slimestone_brick. Creates unilib:stone_slimestone_red_brick
        part_name = "slimestone_red",
        orig_name = "underch:red_slimestone_brick",

        replace_mode = underch_add_mode,
        description = S("Red Slimestone Bricks"),
    })

    unilib.register_stone_cobble({
        -- From underch:red_slimestone_cobble. Creates unilib:stone_slimestone_red_cobble
        part_name = "slimestone_red",
        orig_name = "underch:red_slimestone_cobble",

        replace_mode = underch_add_mode,
        description = S("Red Slimestone Cobble"),
        wall_orig_name = "underch:red_slimestone_cobble_wall",
    })

    -- (no mossy cobble)

    if unilib.underch_tweak_flag then

        unilib.register_stone_cobble_compressed({
            -- From compressed:red_slimestone. Creates unilib:stone_slimestone_red_cobble_compressed
            part_name = "slimestone_red",
            orig_name = "compressed:red_slimestone",

            replace_mode = compressed_add_mode,
            description = S("Compressed Red Slimestone Cobble"),
        })

        unilib.register_stone_cobble_condensed({
            -- From condensed:red_slimestone. Creates unilib:stone_slimestone_red_cobble_condensed
            part_name = "slimestone_red",
            orig_name = "condensed:red_slimestone",

            replace_mode = condensed_add_mode,
            description = S("Condensed Red Slimestone Cobble"),
        })

    end

end
