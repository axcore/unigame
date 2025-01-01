---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    PFAA
-- Code:    Artistic-2.0
-- Media:   Artistic-2.0
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_mudstone = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.pfaa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_mudstone.init()

    return {
        description = "Mudstone",
    }

end

function unilib.pkg.stone_mudstone.exec()

    unilib.register_stone({
        -- Original to unilib
        part_name = "mudstone",
        description = S("Mudstone"),

        category = "sedimentary",
        colour = "#95918B",
        grinder_flag = false,
        hardness = 2,
    })

    unilib.register_stone_smooth({
        -- Texture from PFAA, weakStone_mudstone.png. Original code. Creates unilib:stone_mudstone
        part_name = "mudstone",
        orig_name = nil,

        replace_mode = mode,
        cobble_mode = "rubble",
        description = S("Mudstone"),
    })

    unilib.register_stone_block({
        -- Textures adapted from PFAA. Original code. Creates unilib:stone_mudstone_block
        part_name = "mudstone",
        orig_name = nil,

        replace_mode = mode,
        description = S("Mudstone Block"),
        img_list = {"unilib_stone_mudstone.png^unilib_stone_block_overlay.png"},
    })

    unilib.register_stone_brick({
        -- Textures adapted from PFAA. Original code. Creates unilib:stone_mudstone_brick
        part_name = "mudstone",
        orig_name = nil,

        replace_mode = mode,
        description = S("Mudstone Bricks"),
        img_list = {"unilib_stone_mudstone.png^unilib_stone_brick_overlay.png"},
    })

    unilib.register_stone_rubble({
        -- Textures adapted from PFAA. Original code. Creates unilib:stone_mudstone_rubble
        part_name = "mudstone",
        orig_name = nil,

        replace_mode = mode,
        description = S("Mudstone Rubble"),
        img_list = {"unilib_stone_mudstone.png^unilib_stone_rubble_overlay.png"},
    })

    unilib.register_stone_rubble_compressed({
        -- Original to unilib. Creates unilib:stone_mudstone_rubble_compressed
        part_name = "mudstone",
        orig_name = nil,

        replace_mode = mode,
        description = S("Compressed Mudstone Rubble"),
    })

    unilib.register_stone_rubble_condensed({
        -- Original to unilib. Creates unilib:stone_mudstone_rubble_condensed
        part_name = "mudstone",
        orig_name = nil,

        replace_mode = mode,
        description = S("Condensed Mudstone Rubble"),
    })

end
