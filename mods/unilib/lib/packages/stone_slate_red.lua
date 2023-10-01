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

unilib.pkg.stone_slate_red = {}

local S = unilib.intllib
local underch_add_mode = unilib.imported_mod_table.underch.add_mode
local compressed_add_mode = unilib.imported_mod_table.compressed.add_mode
local condensed_add_mode = unilib.imported_mod_table.condensed.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_slate_red.init()

    return {
        description = "Red slate",
    }

end

function unilib.pkg.stone_slate_red.exec()

    unilib.register_stone({
        -- Original to unilib
        part_name = "slate_red",
        description = S("Red Slate"),

        category = "metamorphic",
        grinder_flag = true,
        -- (N.B. In-game hardness adjusted to match original mod's code, should be 2)
        hardness = 1,
        hardness_real = 2,
        moss_flag = true,
        platform_flag = true,
    })

    unilib.register_stone_smooth({
        -- From underch:slate. Creates unilib:stone_slate_red
        part_name = "slate_red",
        orig_name = "underch:slate",

        replace_mode = underch_add_mode,
        cobble_mode = "cobble",
        description = S("Red Slate"),
    })

    unilib.register_stone_block({
        -- From underch:slate_block. Creates unilib:stone_slate_red_block
        part_name = "slate_red",
        orig_name = "underch:slate_block",

        replace_mode = underch_add_mode,
        description = S("Red Slate Block"),
    })

    unilib.register_stone_brick({
        -- From underch:slate_brick. Creates unilib:stone_slate_red_brick
        part_name = "slate_red",
        orig_name = "underch:slate_brick",

        replace_mode = underch_add_mode,
        description = S("Red Slate Bricks"),
    })

    unilib.register_stone_cobble({
        -- From underch:slate_cobble. Creates unilib:stone_slate_red_cobble
        part_name = "slate_red",
        orig_name = "underch:slate_cobble",

        replace_mode = underch_add_mode,
        description = S("Red Slate Cobble"),
        wall_orig_name = "underch:slate_cobble_wall",
    })

    unilib.register_stone_cobble_mossy({
        -- From underch:slate_mossy_cobble. Creates unilib:stone_slate_red_cobble_mossy
        part_name = "slate_red",
        orig_name = "underch:slate_mossy_cobble",

        replace_mode = underch_add_mode,
        description = S("Mossy Red Slate Cobble"),
        wall_orig_name = "underch:slate_mossy_cobble_wall",
    })

    if unilib.underch_tweak_flag then

        unilib.register_stone_cobble_compressed({
            -- From compressed:slate. Creates unilib:stone_slate_cobble_compressed
            part_name = "slate_red",
            orig_name = "compressed:slate",

            replace_mode = compressed_add_mode,
            description = S("Compressed Red Slate Cobble"),
        })

        unilib.register_stone_cobble_condensed({
            -- From condensed:slate. Creates unilib:stone_slate_red_cobble_condensed
            part_name = "slate_red",
            orig_name = "condensed:slate",

            replace_mode = condensed_add_mode,
            description = S("Condensed Red Slate Cobble"),
        })

    end

end
