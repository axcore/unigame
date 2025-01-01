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

unilib.pkg.stone_aplite = {}

local S = unilib.intllib
local underch_add_mode = unilib.global.imported_mod_table.underch.add_mode
local compressed_add_mode = unilib.global.imported_mod_table.compressed.add_mode
local condensed_add_mode = unilib.global.imported_mod_table.condensed.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_aplite.init()

    return {
        description = "Aplite",
    }

end

function unilib.pkg.stone_aplite.exec()

    unilib.register_stone({
        -- Original to unilib
        part_name = "aplite",
        description = S("Aplite"),

        category = "intrusive",
        colour = "#7F665E",
        grinder_flag = true,
        -- (N.B. In-game hardness adjusted to match original mod's code, should be 3)
        hardness = 1,
        hardness_real = 3,
        moss_flag = true,
        platform_flag = true,
    })

    unilib.register_stone_smooth({
        -- From underch:aplite. Creates unilib:stone_aplite
        part_name = "aplite",
        orig_name = "underch:aplite",

        replace_mode = underch_add_mode,
        cobble_mode = "cobble",
        description = S("Aplite"),
    })

    unilib.register_stone_block({
        -- From underch:aplite_block. Creates unilib:stone_aplite_block
        part_name = "aplite",
        orig_name = "underch:aplite_block",

        replace_mode = underch_add_mode,
        description = S("Aplite Block"),
    })

    unilib.register_stone_brick({
        -- From underch:aplite_brick. Creates unilib:stone_aplite_brick
        part_name = "aplite",
        orig_name = "underch:aplite_brick",

        replace_mode = underch_add_mode,
        description = S("Aplite Bricks"),
    })

    unilib.register_stone_cobble({
        -- From underch:aplite_cobble. Creates unilib:stone_aplite_cobble
        part_name = "aplite",
        orig_name = "underch:aplite_cobble",

        replace_mode = underch_add_mode,
        description = S("Aplite Cobble"),
        wall_orig_name = "underch:aplite_cobble_wall",
    })

    unilib.register_stone_cobble_mossy({
        -- From underch:aplite_mossy_cobble. Creates unilib:stone_aplite_cobble_mossy
        part_name = "aplite",
        orig_name = "underch:aplite_mossy_cobble",

        replace_mode = underch_add_mode,
        description = S("Mossy Aplite Cobble"),
        wall_orig_name = "underch:aplite_mossy_cobble_wall",
    })

    unilib.register_stone_cobble_compressed({
        -- From compressed:aplite. Creates unilib:stone_aplite_cobble_compressed
        part_name = "aplite",
        orig_name = "compressed:aplite",

        replace_mode = compressed_add_mode,
        description = S("Compressed Aplite Cobble"),
    })

    unilib.register_stone_cobble_condensed({
        -- From condensed:aplite. Creates unilib:stone_aplite_cobble_condensed
        part_name = "aplite",
        orig_name = "condensed:aplite",

        replace_mode = condensed_add_mode,
        description = S("Condensed Aplite Cobble"),
    })

end
