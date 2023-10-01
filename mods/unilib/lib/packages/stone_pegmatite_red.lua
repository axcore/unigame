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

unilib.pkg.stone_pegmatite_red = {}

local S = unilib.intllib
local underch_add_mode = unilib.imported_mod_table.underch.add_mode
local compressed_add_mode = unilib.imported_mod_table.compressed.add_mode
local condensed_add_mode = unilib.imported_mod_table.condensed.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_pegmatite_red.init()

    return {
        description = "Red pegmatite",
    }

end

function unilib.pkg.stone_pegmatite_red.exec()

    unilib.register_stone({
        -- Original to unilib
        part_name = "pegmatite_red",
        description = S("Red Pegmatite"),

        category = "intrusive",
        grinder_flag = true,
        -- (N.B. In-game hardness adjusted to match original mod's code, should be 3)
        hardness = 1,
        hardness_real = 3,
        moss_flag = true,
        platform_flag = true,
    })

    unilib.register_stone_smooth({
        -- From underch:pegmatite. Creates unilib:stone_pegmatite_red
        part_name = "pegmatite_red",
        orig_name = "underch:pegmatite",

        replace_mode = underch_add_mode,
        cobble_mode = "cobble",
        description = S("Red Pegmatite"),
    })

    unilib.register_stone_block({
        -- From underch:pegmatite_block. Creates unilib:stone_pegmatite_red_block
        part_name = "pegmatite_red",
        orig_name = "underch:pegmatite_block",

        replace_mode = underch_add_mode,
        description = S("Red Pegmatite Block"),
    })

    unilib.register_stone_brick({
        -- From underch:pegmatite_brick. Creates unilib:stone_pegmatite_red_brick
        part_name = "pegmatite_red",
        orig_name = "underch:pegmatite_brick",

        replace_mode = underch_add_mode,
        description = S("Red Pegmatite Bricks"),
    })

    unilib.register_stone_cobble({
        -- From underch:pegmatite_cobble. Creates unilib:stone_pegmatite_red_cobble
        part_name = "pegmatite_red",
        orig_name = "underch:pegmatite_cobble",

        replace_mode = underch_add_mode,
        description = S("Red Pegmatite Cobble"),
        wall_orig_name = "underch:pegmatite_cobble_wall",
    })

    unilib.register_stone_cobble_mossy({
        -- From underch:pegmatite_mossy_cobble. Creates unilib:stone_pegmatite_red_cobble_mossy
        part_name = "pegmatite_red",
        orig_name = "underch:pegmatite_mossy_cobble",

        replace_mode = underch_add_mode,
        description = S("Mossy Red Pegmatite Cobble"),
        wall_orig_name = "underch:pegmatite_mossy_cobble_wall",
    })

    if unilib.underch_tweak_flag then

        unilib.register_stone_cobble_compressed({
            -- From compressed:pegmatite. Creates unilib:stone_pegmatite_red_cobble_compressed
            part_name = "pegmatite_red",
            orig_name = "compressed:pegmatite",

            replace_mode = compressed_add_mode,
            description = S("Compressed Red Pegmatite Cobble"),
        })

        unilib.register_stone_cobble_condensed({
            -- From condensed:pegmatite. Creates unilib:stone_pegmatite_red_cobble_condensed
            part_name = "pegmatite_red",
            orig_name = "condensed:pegmatite",

            replace_mode = condensed_add_mode,
            description = S("Condensed Red Pegmatite Cobble"),
        })

    end

end
