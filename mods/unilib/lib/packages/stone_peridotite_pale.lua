---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    PFAA
-- Code:    Artistic-2.0
-- Media:   Artistic-2.0
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_peridotite_pale = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.pfaa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_peridotite_pale.init()

    return {
        description = "Pale peridotite",
    }

end

function unilib.pkg.stone_peridotite_pale.exec()

    unilib.register_stone({
        -- Original to unilib
        part_name = "peridotite_pale",
        description = S("Pale Peridotite"),

        category = "intrusive",
        grinder_flag = true,
        hardness = 4,
    })

    unilib.register_stone_smooth({
        -- Texture from PFAA, veryStrongStone_peridotite.png. Original code. Creates
        --      unilib:stone_peridotite_pale
        part_name = "peridotite_pale",
        orig_name = nil,

        replace_mode = mode,
        cobble_mode = "smooth",
        description = S("Pale Peridotite"),
    })

    unilib.register_stone_block({
        -- Textures adapted from PFAA. Original code. Creates unilib:stone_peridotite_pale_block
        part_name = "peridotite_pale",
        orig_name = nil,

        replace_mode = mode,
        description = S("Pale Peridotite Block"),
        img_list = {"unilib_stone_peridotite_pale.png^unilib_stone_block_overlay.png"},
    })

    unilib.register_stone_brick({
        -- Textures adapted from PFAA. Original code. Creates unilib:stone_peridotite_pale_brick
        part_name = "peridotite_pale",
        orig_name = nil,

        replace_mode = mode,
        description = S("Pale Peridotite Bricks"),
        img_list = {"unilib_stone_peridotite_pale.png^unilib_stone_brick_overlay.png"},
    })

end
