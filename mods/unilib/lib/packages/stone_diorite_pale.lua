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

unilib.pkg.stone_diorite_pale = {}

local S = unilib.intllib
local underch_add_mode = unilib.imported_mod_table.underch.add_mode
local compressed_add_mode = unilib.imported_mod_table.compressed.add_mode
local condensed_add_mode = unilib.imported_mod_table.condensed.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_diorite_pale.init()

    return {
        description = "Pale diorite",
    }

end

function unilib.pkg.stone_diorite_pale.exec()

    unilib.register_stone({
        -- Original to unilib
        part_name = "diorite_pale",
        description = S("Pale Diorite"),

        category = "intrusive",
        grinder_flag = true,
        -- (N.B. In-game hardness adjusted to match original mod's code, should be 4)
        hardness = 1,
        hardness_real = 4,
        moss_flag = true,
        platform_flag = true,
    })

    unilib.register_stone_smooth({
        -- From underch:diorite. Creates unilib:stone_diorite_pale
        part_name = "diorite_pale",
        orig_name = "underch:diorite",

        replace_mode = underch_add_mode,
        cobble_mode = "cobble",
        description = S("Pale Diorite"),
    })

    unilib.register_stone_block({
        -- From underch:diorite_block. Creates unilib:stone_diorite_pale_block
        part_name = "diorite_pale",
        orig_name = "underch:diorite_block",

        replace_mode = underch_add_mode,
        description = S("Pale Diorite Block"),
    })

    unilib.register_stone_brick({
        -- From underch:diorite_brick. Creates unilib:stone_diorite_pale_brick
        part_name = "diorite_pale",
        orig_name = "underch:diorite_brick",

        replace_mode = underch_add_mode,
        description = S("Pale Diorite Bricks"),
    })

    unilib.register_stone_cobble({
        -- From underch:diorite_cobble. Creates unilib:stone_diorite_pale_cobble
        part_name = "diorite_pale",
        orig_name = "underch:diorite_cobble",

        replace_mode = underch_add_mode,
        description = S("Pale Diorite Cobble"),
        wall_orig_name = "underch:diorite_cobble_wall",
    })

    unilib.register_stone_cobble_mossy({
        -- From underch:diorite_mossy_cobble. Creates unilib:stone_diorite_pale_cobble_mossy
        part_name = "diorite_pale",
        orig_name = "underch:diorite_mossy_cobble",

        replace_mode = underch_add_mode,
        description = S("Mossy Pale Diorite Cobble"),
        wall_orig_name = "underch:diorite_mossy_cobble_wall",
    })

    if unilib.underch_tweak_flag then

        unilib.register_stone_cobble_compressed({
            -- From compressed:diorite. Creates unilib:stone_diorite_pale_cobble_compressed
            part_name = "diorite_pale",
            orig_name = "compressed:diorite",

            replace_mode = compressed_add_mode,
            description = S("Compressed Pale Diorite Cobble"),
        })

        unilib.register_stone_cobble_condensed({
            -- From condensed:diorite. Creates unilib:stone_diorite_pale_cobble_condensed
            part_name = "diorite_pale",
            orig_name = "condensed:diorite",

            replace_mode = condensed_add_mode,
            description = S("Condensed Pale Diorite Cobble"),
        })

    end

end
