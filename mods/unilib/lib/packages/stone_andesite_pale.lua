---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    PFAA
-- Code:    Artistic-2.0
-- Media:   Artistic-2.0
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_andesite_pale = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.pfaa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_andesite_pale.init()

    return {
        description = "Pale andesite",
    }

end

function unilib.pkg.stone_andesite_pale.exec()

    unilib.register_stone({
        -- Original to unilib
        part_name = "andesite_pale",
        description = S("Pale Andesite"),

        category = "extrusive",
        grinder_flag = true,
        hardness = 3,
    })

    unilib.register_stone_smooth({
        -- Texture from PFAA, strongStone_andesite.png. Original code. Creates
        --      unilib:stone_andesite_pale
        part_name = "andesite_pale",
        orig_name = nil,

        replace_mode = mode,
        description = S("Pale Andesite"),
    })

    unilib.register_stone_block({
        -- Textures adapted from PFAA. Original code. Creates unilib:stone_andesite_pale_block
        part_name = "andesite_pale",
        orig_name = nil,

        replace_mode = mode,
        description = S("Pale Andesite Block"),
        img_list = {"unilib_stone_andesite_pale.png^unilib_stone_block_overlay.png"},
    })

    unilib.register_stone_brick({
        -- Textures adapted from PFAA. Original code. Creates unilib:stone_andesite_pale_brick
        part_name = "andesite_pale",
        orig_name = nil,

        replace_mode = mode,
        description = S("Pale Andesite Bricks"),
        img_list = {"unilib_stone_andesite_pale.png^unilib_stone_brick_overlay.png"},
    })

    unilib.register_stone_cobble({
        -- Textures adapted from PFAA. Original code. Creates unilib:stone_andesite_pale_cobble
        part_name = "andesite_pale",
        orig_name = nil,

        replace_mode = mode,
        description = S("Pale Andesite Cobble"),
        img_list = {"unilib_stone_andesite_pale.png^unilib_stone_cobble_overlay.png"},
    })

end
