---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    PFAA
-- Code:    Artistic-2.0
-- Media:   Artistic-2.0
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_granite_pale = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.pfaa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_granite_pale.init()

    return {
        description = "Pale granite",
    }

end

function unilib.pkg.stone_granite_pale.exec()

    unilib.register_stone({
        -- Original to unilib
        part_name = "granite_pale",
        description = S("Pale Granite"),

        category = "intrusive",
        colour = "#9A9A9A",
        grinder_flag = true,
        hardness = 3,
    })

    unilib.register_stone_smooth({
        -- Texture from PFAA, strongStone_granite.png. Original code. Creates
        --      unilib:stone_granite_pale
        part_name = "granite_pale",
        orig_name = nil,

        replace_mode = mode,
        description = S("Pale Granite"),
        -- N.B. granite = 1 not in original code
        group_table = {granite = 1},
    })

    unilib.register_stone_block({
        -- Textures adapted from PFAA. Original code. Creates unilib:stone_granite_pale_block
        part_name = "granite_pale",
        orig_name = nil,

        replace_mode = mode,
        description = S("Pale Granite Block"),
        img_list = {"unilib_stone_granite_pale.png^unilib_stone_block_overlay.png"},
    })

    unilib.register_stone_brick({
        -- Textures adapted from PFAA. Original code. Creates unilib:stone_granite_pale_brick
        part_name = "granite_pale",
        orig_name = nil,

        replace_mode = mode,
        description = S("Pale Granite Bricks"),
        img_list = {"unilib_stone_granite_pale.png^unilib_stone_brick_overlay.png"},
    })

    unilib.register_stone_cobble({
        -- Textures adapted from PFAA. Original code. Creates unilib:stone_granite_pale_cobble
        part_name = "granite_pale",
        orig_name = nil,

        replace_mode = mode,
        description = S("Pale Granite Cobble"),
        img_list = {"unilib_stone_granite_pale.png^unilib_stone_cobble_overlay.png"},
    })

    unilib.register_stone_cobble_compressed({
        -- Original to unilib. Creates unilib:stone_granite_pale_cobble_compressed
        part_name = "granite_pale",
        orig_name = nil,

        replace_mode = mode,
        description = S("Compressed Pale Granite Cobble"),
    })

    unilib.register_stone_cobble_condensed({
        -- Original to unilib. Creates unilib:stone_granite_pale_cobble_condensed
        part_name = "granite_pale",
        orig_name = nil,

        replace_mode = mode,
        description = S("Condensed Pale Granite Cobble"),
    })

end
