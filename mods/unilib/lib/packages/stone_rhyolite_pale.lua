---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    PFAA
-- Code:    Artistic-2.0
-- Media:   Artistic-2.0
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_rhyolite_pale = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.pfaa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_rhyolite_pale.init()

    return {
        description = "Pale rhyolite",
    }

end

function unilib.pkg.stone_rhyolite_pale.exec()

    unilib.register_stone({
        -- Original to unilib
        part_name = "rhyolite_pale",
        description = S("Pale Rhyolite"),

        category = "extrusive",
        colour = "#C0C2D4",
        grinder_flag = true,
        hardness = 3,
    })

    unilib.register_stone_smooth({
        -- Texture from PFAA, strongStone_rhyolite.png. Original code. Creates
        --      unilib:stone_rhyolite_pale
        part_name = "rhyolite_pale",
        orig_name = nil,

        replace_mode = mode,
        description = S("Pale Rhyolite"),
    })

    unilib.register_stone_block({
        -- Textures adapted from PFAA. Original code. Creates unilib:stone_rhyolite_pale_block
        part_name = "rhyolite_pale",
        orig_name = nil,

        replace_mode = mode,
        description = S("Pale Rhyolite Block"),
        img_list = {"unilib_stone_rhyolite_pale.png^unilib_stone_block_overlay.png"},
    })

    unilib.register_stone_brick({
        -- Textures adapted from PFAA. Original code. Creates unilib:stone_rhyolite_pale_brick
        part_name = "rhyolite_pale",
        orig_name = nil,

        replace_mode = mode,
        description = S("Pale Rhyolite Bricks"),
        img_list = {"unilib_stone_rhyolite_pale.png^unilib_stone_brick_overlay.png"},
    })

    unilib.register_stone_cobble({
        -- Textures adapted from PFAA. Original code. Creates unilib:stone_rhyolite_pale_cobble
        part_name = "rhyolite_pale",
        orig_name = nil,

        replace_mode = mode,
        description = S("Pale Rhyolite Cobble"),
        img_list = {"unilib_stone_rhyolite_pale.png^unilib_stone_cobble_overlay.png"},
    })

    unilib.register_stone_cobble_compressed({
        -- Original to unilib. Creates unilib:stone_rhyolite_pale_cobble_compressed
        part_name = "rhyolite_pale",
        orig_name = nil,

        replace_mode = mode,
        description = S("Compressed Pale Rhyolite Cobble"),
    })

    unilib.register_stone_cobble_condensed({
        -- Original to unilib. Creates unilib:stone_rhyolite_pale_cobble_condensed
        part_name = "rhyolite_pale",
        orig_name = nil,

        replace_mode = mode,
        description = S("Condensed Pale Rhyolite Cobble"),
    })

end
