---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    UGBC
-- Code:    GPLv2
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_rhyolite_dark = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ugbc.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_rhyolite_dark.init()

    return {
        description = "Dark rhyolite",
    }

end

function unilib.pkg.stone_rhyolite_dark.exec()

    local top_img = "unilib_stone_rhyolite_dark.png"

    unilib.register_stone({
        -- Original to unilib
        part_name = "rhyolite_dark",
        description = S("Dark Rhyolite"),

        category = "extrusive",
        grinder_flag = true,
        hardness = 3,
    })

    unilib.register_stone_smooth({
        -- Texture from UGBC, rhyolite.png. Original code. Creates unilib:stone_rhyolite_dark
        part_name = "rhyolite_dark",
        orig_name = nil,

        replace_mode = mode,
        description = S("Dark Rhyolite"),
    })

    unilib.register_stone_block({
        -- Texture from UGBC, rhyolite_slab_top.png. Original code. Creates
        --      unilib:stone_rhyolite_dark_block
        part_name = "rhyolite_dark",
        orig_name = nil,

        replace_mode = mode,
        description = S("Dark Rhyolite Block"),
        slab_img_list = {top_img, top_img, "unilib_stone_rhyolite_dark_slab.png"},
    })

    unilib.register_stone_brick({
        -- Texture from UGBC, rhyolite_brick.png. Original code. Creates
        --      unilib:stone_rhyolite_dark_brick
        part_name = "rhyolite_dark",
        orig_name = nil,

        replace_mode = mode,
        description = S("Dark Rhyolite Bricks"),
    })

    unilib.register_stone_cobble({
        -- Texture from UGBC, rhyolite_cobble.png. Original code. Creates
        --      unilib:stone_rhyolite_dark_cobble
        part_name = "rhyolite_dark",
        orig_name = nil,

        replace_mode = mode,
        description = S("Dark Rhyolite Cobble"),
    })

end
