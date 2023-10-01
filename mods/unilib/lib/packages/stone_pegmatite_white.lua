---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    PFAA
-- Code:    Artistic-2.0
-- Media:   Artistic-2.0
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_pegmatite_white = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.pfaa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_pegmatite_white.init()

    return {
        description = "White pegmatite",
    }

end

function unilib.pkg.stone_pegmatite_white.exec()

    unilib.register_stone({
        -- Original to unilib
        part_name = "pegmatite_white",
        description = S("White Pegmatite"),

        category = "intrusive",
        grinder_flag = true,
        hardness = 3,
    })

    unilib.register_stone_smooth({
        -- Texture from PFAA, strongStone_pegmatite.png. Original code. Creates
        --      unilib:stone_pegmatite_white
        part_name = "pegmatite_white",
        orig_name = nil,

        replace_mode = mode,
        description = S("White Pegmatite"),
    })

    unilib.register_stone_block({
        -- Textures adapted from PFAA. Original code. Creates unilib:stone_pegmatite_white_block
        part_name = "pegmatite_white",
        orig_name = nil,

        replace_mode = mode,
        description = S("White Pegmatite Block"),
        img_list = {"unilib_stone_pegmatite_white.png^unilib_stone_block_overlay.png"},
    })

    unilib.register_stone_brick({
        -- Textures adapted from PFAA. Original code. Creates unilib:stone_pegmatite_white_brick
        part_name = "pegmatite_white",
        orig_name = nil,

        replace_mode = mode,
        description = S("White Pegmatite Bricks"),
        img_list = {"unilib_stone_pegmatite_white.png^unilib_stone_brick_overlay.png"},
    })

    unilib.register_stone_cobble({
        -- Textures adapted from PFAA. Original code. Creates unilib:stone_pegmatite_white_cobble
        part_name = "pegmatite_white",
        orig_name = nil,

        replace_mode = mode,
        description = S("White Pegmatite Cobble"),
        img_list = {"unilib_stone_pegmatite_white.png^unilib_stone_cobble_overlay.png"},
    })

end
