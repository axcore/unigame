---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    UGBC
-- Code:    GPLv2
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_siltstone_pale = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ugbc.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_siltstone_pale.init()

    return {
        description = "Pale siltstone",
        optional = "sand_silt",
    }

end

function unilib.pkg.stone_siltstone_pale.exec()

    unilib.register_stone({
        -- Original to unilib
        part_name = "siltstone_pale",
        description = S("Pale Siltstone"),

        category = "sedimentary",
        grinder_flag = true,
        grinder_powder = "unilib:sand_silt",
        hardness = 2,
    })

    unilib.register_stone_smooth({
        -- Texture from UGBC, siltstone.png. Original code. Creates unilib:stone_siltstone_pale
        part_name = "siltstone_pale",
        orig_name = nil,

        replace_mode = mode,
        description = S("Pale Siltstone"),
    })

    unilib.register_stone_block({
        -- Original to unilib. Creates unilib:stone_siltstone_pale_block
        part_name = "siltstone_pale",
        orig_name = nil,

        replace_mode = mode,
        description = S("Pale Siltstone Block"),
        img_list = {"unilib_stone_siltstone_pale.png^unilib_stone_block_overlay.png"},
    })

    unilib.register_stone_brick({
        -- Original to unilib. Creates unilib:stone_siltstone_pale_brick
        part_name = "siltstone_pale",
        orig_name = nil,

        replace_mode = mode,
        description = S("Pale Siltstone Bricks"),
        img_list = {"unilib_stone_siltstone_pale.png^unilib_stone_brick_overlay.png"},
    })

    unilib.register_stone_cobble({
        -- Original to unilib. Creates unilib:stone_siltstone_pale_cobble
        part_name = "siltstone_pale",
        orig_name = nil,

        replace_mode = mode,
        description = S("Pale Siltstone Cobble"),
        img_list = {"unilib_stone_siltstone_pale.png^unilib_stone_cobble_overlay.png"},
    })

end
