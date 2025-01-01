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

unilib.pkg.stone_schist_red = {}

local S = unilib.intllib
local underch_add_mode = unilib.global.imported_mod_table.underch.add_mode
local compressed_add_mode = unilib.global.imported_mod_table.compressed.add_mode
local condensed_add_mode = unilib.global.imported_mod_table.condensed.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_schist_red.init()

    return {
        description = "Red schist",
    }

end

function unilib.pkg.stone_schist_red.exec()

    unilib.register_stone({
        -- Original to unilib
        part_name = "schist_red",
        description = S("Red Schist"),

        category = "metamorphic",
        colour = "#825B48",
        grinder_flag = true,
        -- (N.B. In-game hardness adjusted to match original mod's code, should be 2/3)
        hardness = 1,
        hardness_real = 2,
        moss_flag = true,
        platform_flag = true,
    })

    unilib.register_stone_smooth({
        -- From underch:schist. Creates unilib:stone_schist_red
        part_name = "schist_red",
        orig_name = "underch:schist",

        replace_mode = underch_add_mode,
        cobble_mode = "cobble",
        description = S("Red Schist"),
    })

    unilib.register_stone_block({
        -- From underch:schist_block. Creates unilib:stone_schist_red_block
        part_name = "schist_red",
        orig_name = "underch:schist_block",

        replace_mode = underch_add_mode,
        description = S("Red Schist Block"),
    })

    unilib.register_stone_brick({
        -- From underch:schist_brick. Creates unilib:stone_schist_red_brick
        part_name = "schist_red",
        orig_name = "underch:schist_brick",

        replace_mode = underch_add_mode,
        description = S("Red Schist Bricks"),
    })

    unilib.register_stone_cobble({
        -- From underch:schist_cobble. Creates unilib:stone_schist_red_cobble
        part_name = "schist_red",
        orig_name = "underch:schist_cobble",

        replace_mode = underch_add_mode,
        description = S("Red Schist Cobble"),
        wall_orig_name = "underch:schist_cobble_wall",
    })

    unilib.register_stone_cobble_mossy({
        -- From underch:schist_mossy_cobble. Creates unilib:stone_schist_red_cobble_mossy
        part_name = "schist_red",
        orig_name = "underch:schist_mossy_cobble",

        replace_mode = underch_add_mode,
        description = S("Mossy Red Schist Cobble"),
        wall_orig_name = "underch:schist_mossy_cobble_wall",
    })

    unilib.register_stone_cobble_compressed({
        -- From compressed:schist. Creates unilib:stone_schist_red_cobble_compressed
        part_name = "schist_red",
        orig_name = "compressed:schist",

        replace_mode = compressed_add_mode,
        description = S("Compressed Red Schist Cobble"),
    })

    unilib.register_stone_cobble_condensed({
        -- From condensed:schist. Creates unilib:stone_schist_red_cobble_condensed
        part_name = "schist_red",
        orig_name = "condensed:schist",

        replace_mode = condensed_add_mode,
        description = S("Condensed Red Schist Cobble"),
    })

end
