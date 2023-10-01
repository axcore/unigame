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

unilib.pkg.stone_vindesite_blue = {}

local S = unilib.intllib
local underch_add_mode = unilib.imported_mod_table.underch.add_mode
local compressed_add_mode = unilib.imported_mod_table.compressed.add_mode
local condensed_add_mode = unilib.imported_mod_table.condensed.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_vindesite_blue.init()

    return {
        description = "Blue vindesite",
    }

end

function unilib.pkg.stone_vindesite_blue.exec()

    unilib.register_stone({
        -- Original to unilib
        part_name = "vindesite_blue",
        description = S("Blue Vindesite"),

        category = "other",
        fictional_flag = true,
        grinder_flag = true,
        hardness = 1,
        moss_flag = true,
        platform_flag = true,
    })

    unilib.register_stone_smooth({
        -- From underch:dark_vindesite. Creates unilib:stone_vindesite_blue
        part_name = "vindesite_blue",
        orig_name = "underch:dark_vindesite",

        replace_mode = underch_add_mode,
        cobble_mode = "cobble",
        description = S("Blue Vindesite"),
    })

    unilib.register_stone_block({
        -- From underch:dark_vindesite_block. Creates unilib:stone_vindesite_blue_block
        part_name = "vindesite_blue",
        orig_name = "underch:dark_vindesite_block",

        replace_mode = underch_add_mode,
        description = S("Blue Vindesite Block"),
    })

    unilib.register_stone_brick({
        -- From underch:dark_vindesite_brick. Creates unilib:stone_vindesite_blue_brick
        part_name = "vindesite_blue",
        orig_name = "underch:dark_vindesite_brick",

        replace_mode = underch_add_mode,
        description = S("Blue Vindesite Bricks"),
    })

    unilib.register_stone_cobble({
        -- From underch:dark_vindesite_cobble. Creates unilib:stone_vindesite_blue_cobble
        part_name = "vindesite_blue",
        orig_name = "underch:dark_vindesite_cobble",

        replace_mode = underch_add_mode,
        description = S("Blue Vindesite Cobble"),
        wall_orig_name = "underch:dark_vindesite_cobble_wall",
    })

    unilib.register_stone_cobble_mossy({
        -- From underch:dark_vindesite_mossy_cobble. Creates
        --      unilib:stone_vindesite_blue_cobble_mossy
        part_name = "vindesite_blue",
        orig_name = "underch:dark_vindesite_mossy_cobble",

        replace_mode = underch_add_mode,
        description = S("Mossy Blue Vindesite Cobble"),
        wall_orig_name = "underch:dark_vindesite_mossy_cobble_wall",
    })

    if unilib.underch_tweak_flag then

        unilib.register_stone_cobble_compressed({
            -- From compressed:dark_vindesite. Creates unilib:stone_vindesite_blue_cobble_compressed
            part_name = "vindesite_blue",
            orig_name = "compressed:dark_vindesite",

            replace_mode = compressed_add_mode,
            description = S("Compressed Blue Vindesite Cobble"),
        })

        unilib.register_stone_cobble_condensed({
            -- From condensed:dark_vindesite. Creates unilib:stone_vindesite_blue_cobble_condensed
            part_name = "vindesite_blue",
            orig_name = "condensed:dark_vindesite",

            replace_mode = condensed_add_mode,
            description = S("Condensed Blue Vindesite Cobble"),
        })

    end

end
