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

unilib.pkg.stone_granite_salmon = {}

local S = unilib.intllib
local underch_add_mode = unilib.imported_mod_table.underch.add_mode
local compressed_add_mode = unilib.imported_mod_table.compressed.add_mode
local condensed_add_mode = unilib.imported_mod_table.condensed.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_granite_salmon.init()

    return {
        description = "Salmon granite",
    }

end

function unilib.pkg.stone_granite_salmon.exec()

    unilib.register_stone({
        -- Original to unilib
        part_name = "granite_salmon",
        description = S("Salmon Granite"),

        category = "intrusive",
        grinder_flag = true,
        -- (N.B. In-game hardness adjusted to match original mod's code, should be 3/4)
        hardness = 1,
        hardness_real = 3,
        moss_flag = true,
        platform_flag = true,
    })

    unilib.register_stone_smooth({
        -- From underch:granite. Creates unilib:stone_granite_salmon
        part_name = "granite_salmon",
        orig_name = "underch:granite",

        replace_mode = underch_add_mode,
        cobble_mode = "cobble",
        description = S("Salmon Granite"),
        -- N.B. granite = 1 not in original code
        group_table = {granite = 1},
    })

    unilib.register_stone_block({
        -- From underch:granite_block. Creates unilib:stone_granite_salmon_block
        part_name = "granite_salmon",
        orig_name = "underch:granite_block",

        replace_mode = underch_add_mode,
        description = S("Salmon Granite Block"),
    })

    unilib.register_stone_brick({
        -- From underch:granite_brick. Creates unilib:stone_granite_salmon_brick
        part_name = "granite_salmon",
        orig_name = "underch:granite_brick",

        replace_mode = underch_add_mode,
        description = S("Salmon Granite Bricks"),
    })

    unilib.register_stone_cobble({
        -- From underch:granite_cobble. Creates unilib:stone_granite_salmon_cobble
        part_name = "granite_salmon",
        orig_name = "underch:granite_cobble",

        replace_mode = underch_add_mode,
        description = S("Salmon Granite Cobble"),
        wall_orig_name = "underch:granite_cobble_wall",
    })

    unilib.register_stone_cobble_mossy({
        -- From underch:granite_mossy_cobble. Creates unilib:stone_granite_salmon_cobble_mossy
        part_name = "granite_salmon",
        orig_name = "underch:granite_mossy_cobble",

        replace_mode = underch_add_mode,
        description = S("Mossy Salmon Granite Cobble"),
        wall_orig_name = "underch:granite_mossy_cobble_wall",
    })

    if unilib.underch_tweak_flag then

        unilib.register_stone_cobble_compressed({
            -- From compressed:granite. Creates unilib:stone_granite_salmon_cobble_compressed
            part_name = "granite_salmon",
            orig_name = "compressed:granite",

            replace_mode = compressed_add_mode,
            description = S("Compressed Salmon Granite Cobble"),
        })

        unilib.register_stone_cobble_condensed({
            -- From condensed:granite. Creates unilib:stone_granite_salmon_cobble_condensed
            part_name = "granite_salmon",
            orig_name = "condensed:granite",

            replace_mode = condensed_add_mode,
            description = S("Condensed Salmon Granite Cobble"),
        })

    end

end
