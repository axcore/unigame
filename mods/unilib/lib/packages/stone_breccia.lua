---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    PFAA
-- Code:    Artistic-2.0
-- Media:   Artistic-2.0
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_breccia = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.pfaa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_breccia.init()

    return {
        description = "Breccia",
    }

end

function unilib.pkg.stone_breccia.exec()

    unilib.register_stone({
        -- Original to unilib
        part_name = "breccia",
        description = S("Breccia"),

        category = "sedimentary",
        colour = "#9E8B7F",
        grinder_flag = true,
        hardness = 1,
    })

    unilib.register_stone_smooth({
        -- Texture from PFAA, weakStone_breccia.png. Original code. Creates unilib:stone_breccia
        part_name = "breccia",
        orig_name = nil,

        replace_mode = mode,
        cobble_mode = "rubble",
        description = S("Breccia"),
    })

    unilib.register_stone_block({
        -- Textures adapted from PFAA. Original code. Creates unilib:stone_breccia_block
        part_name = "breccia",
        orig_name = nil,

        replace_mode = mode,
        description = S("Breccia Block"),
        img_list = {"unilib_stone_breccia.png^unilib_stone_block_overlay.png"},
    })

    unilib.register_stone_brick({
        -- Textures adapted from PFAA. Original code. Creates unilib:stone_breccia_brick
        part_name = "breccia",
        orig_name = nil,

        replace_mode = mode,
        description = S("Breccia Bricks"),
        img_list = {"unilib_stone_breccia.png^unilib_stone_brick_overlay.png"},
    })

    unilib.register_stone_rubble({
        -- Textures adapted from PFAA. Original code. Creates unilib:stone_breccia_rubble
        part_name = "breccia",
        orig_name = nil,

        replace_mode = mode,
        description = S("Breccia Rubble"),
        img_list = {"unilib_stone_breccia.png^unilib_stone_rubble_overlay.png"},
    })

    unilib.register_stone_rubble_compressed({
        -- Original to unilib. Creates unilib:stone_breccia_rubble_compressed
        part_name = "breccia",
        orig_name = nil,

        replace_mode = mode,
        description = S("Compressed Breccia Rubble"),
    })

    unilib.register_stone_rubble_condensed({
        -- Original to unilib. Creates unilib:stone_breccia_rubble_condensed
        part_name = "breccia",
        orig_name = nil,

        replace_mode = mode,
        description = S("Condensed Breccia Rubble"),
    })

end
