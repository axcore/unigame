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

unilib.pkg.stone_marble_carrara = {}

local S = unilib.intllib
local underch_add_mode = unilib.imported_mod_table.underch.add_mode
local compressed_add_mode = unilib.imported_mod_table.compressed.add_mode
local condensed_add_mode = unilib.imported_mod_table.condensed.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_marble_carrara.init()

    return {
        description = "Carrara Marble",
    }

end

function unilib.pkg.stone_marble_carrara.exec()

    unilib.register_stone({
        -- Original to unilib
        part_name = "marble_carrara",
        description = S("Carrara Marble"),

        category = "metamorphic",
        grinder_flag = true,
        -- (N.B. In-game hardness adjusted to match original mod's code, should be 3)
        hardness = 1,
        hardness_real = 3,
        moss_flag = true,
        platform_flag = true,
    })

    unilib.register_stone_smooth({
        -- From underch:marble. Creates unilib:stone_marble_carrara
        part_name = "marble_carrara",
        orig_name = "underch:marble",

        replace_mode = underch_add_mode,
        cobble_mode = "cobble",
        description = S("Carrara Marble"),
        -- N.B. marble = 1 not in original code
        group_table = {marble = 1},
    })

    unilib.register_stone_block({
        -- From underch:marble_block. Creates unilib:stone_marble_carrara_block
        part_name = "marble_carrara",
        orig_name = "underch:marble_block",

        replace_mode = underch_add_mode,
        description = S("Carrara Marble Block"),
    })

    unilib.register_stone_brick({
        -- From underch:marble_brick. Creates unilib:stone_marble_carrara_brick
        part_name = "marble_carrara",
        orig_name = "underch:marble_brick",

        replace_mode = underch_add_mode,
        description = S("Carrara Marble Bricks"),
    })

    unilib.register_stone_cobble({
        -- From underch:marble_cobble. Creates unilib:stone_marble_carrara_cobble
        part_name = "marble_carrara",
        orig_name = "underch:marble_cobble",

        replace_mode = underch_add_mode,
        description = S("Carrara Marble Cobble"),
        wall_orig_name = "underch:marble_cobble_wall",
    })

    unilib.register_stone_cobble_mossy({
        -- From underch:marble_mossy_cobble. Creates unilib:stone_marble_carrara_cobble_mossy
        part_name = "marble_carrara",
        orig_name = "underch:marble_mossy_cobble",

        replace_mode = underch_add_mode,
        description = S("Mossy Carrara Marble Cobble"),
        wall_orig_name = "underch:marble_mossy_cobble_wall",
    })

    if unilib.underch_tweak_flag then

        unilib.register_stone_cobble_compressed({
            -- From compressed:marble. Creates unilib:stone_marble_carrara_cobble_compressed
            part_name = "marble_carrara",
            orig_name = "compressed:marble",

            replace_mode = compressed_add_mode,
            description = S("Compressed Carrara Marble Cobble"),
        })

        unilib.register_stone_cobble_condensed({
            -- From condensed:marble. Creates unilib:stone_marble_carrara_cobble_condensed
            part_name = "marble_carrara",
            orig_name = "condensed:marble",

            replace_mode = condensed_add_mode,
            description = S("Condensed Carrara Marble Cobble"),
        })

    end

end
