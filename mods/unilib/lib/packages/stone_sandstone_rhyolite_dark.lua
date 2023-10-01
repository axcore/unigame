---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    UGBC
-- Code:    GPLv2
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_sandstone_rhyolite_dark = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ugbc.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_sandstone_rhyolite_dark.init()

    return {
        description = "Dark rhyolite sandstone",
    }

end

function unilib.pkg.stone_sandstone_rhyolite_dark.exec()

    local top_img = "unilib_stone_sandstone_rhyolite_dark_top.png"
    local bottom_img = "unilib_stone_sandstone_rhyolite_dark_bottom.png"

    unilib.register_stone({
        -- Original to unilib
        part_name = "sandstone_rhyolite_dark",
        description = S("Dark Rhyolite Sandstone"),

        category = "sedimentary",
        grinder_flag = true,
        grinder_powder = "unilib:sand_rhyolite_dark",
        grinder_gravel = "unilib:gravel_rhyolite_dark",
        hardness = 4,
        not_super_flag = true,
    })

    unilib.register_stone_smooth({
        -- Textures from UGBC, rhyolite_sandstone_*.png. Original code. Creates
        --      unilib:stone_sandstone_rhyolite_dark
        part_name = "sandstone_rhyolite_dark",
        orig_name = nil,

        replace_mode = mode,
        cobble_mode = "optional_cobble",
        description = S("Dark Rhyolite Sandstone"),
        img_list = {top_img, bottom_img, top_img},
    })

    unilib.register_stone_block({
        -- Textures from UGBC, rhyolite_sandstone_*.png. Original code. Creates
        --      unilib:stone_sandstone_rhyolite_dark_block
        part_name = "sandstone_rhyolite_dark",
        orig_name = nil,

        replace_mode = mode,
        description = S("Dark Rhyolite Sandstone Block"),
        img_list = {top_img, bottom_img, "unilib_stone_sandstone_rhyolite_dark_block.png"},
    })

    unilib.register_stone_brick({
        -- Textures from UGBC, rhyolite_sandstone_*.png. Original code. Creates
        --      unilib:stone_sandstone_rhyolite_dark_brick
        part_name = "sandstone_rhyolite_dark",
        orig_name = nil,

        replace_mode = mode,
        description = S("Dark Rhyolite Sandstone Bricks"),
        img_list = {top_img, bottom_img, "unilib_stone_sandstone_rhyolite_dark_brick.png"},
    })

    if unilib.sandstone_cobble_rubble_flag then

        unilib.register_stone_cobble({
            -- Textures from UGBC, rhyolite_sandstone_*.png. Original code. Creates
            --      unilib:stone_sandstone_rhyolite_dark_cobble
            part_name = "sandstone_rhyolite_dark",
            orig_name = nil,

            replace_mode = mode,
            description = S("Dark Rhyolite Sandstone Cobble"),
            img_list = {top_img, bottom_img, "unilib_stone_sandstone_rhyolite_dark_cobble.png"},
        })

    end

end
