---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    UGBC
-- Code:    GPLv2
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_sandstone_soapstone = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ugbc.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_sandstone_soapstone.init()

    return {
        description = "Soapstone sandstone",
    }

end

function unilib.pkg.stone_sandstone_soapstone.exec()

    local top_img = "unilib_stone_sandstone_soapstone_top.png"
    local bottom_img = "unilib_stone_sandstone_soapstone_bottom.png"

    unilib.register_stone({
        -- Original to unilib
        part_name = "sandstone_soapstone",
        description = S("Soapstone Sandstone"),

        category = "sedimentary",
        colour = "#C1BDAB",
        grinder_flag = true,
        grinder_powder = "unilib:sand_soapstone",
        grinder_gravel = "unilib:gravel_soapstone",
        hardness = 1,
        not_super_flag = true,
    })

    unilib.register_stone_smooth({
        -- Textures from UGBC, soapstone_sandstone_*.png. Original code. Creates
        --      unilib:stone_sandstone_soapstone
        part_name = "sandstone_soapstone",
        orig_name = nil,

        replace_mode = mode,
        cobble_mode = "optional_cobble",
        description = S("Soapstone Sandstone"),
        img_list = {top_img, bottom_img, top_img},
    })

    unilib.register_stone_block({
        -- Textures from UGBC, soapstone_sandstone_*.png. Original code. Creates
        --      unilib:stone_sandstone_soapstone_block
        part_name = "sandstone_soapstone",
        orig_name = nil,

        replace_mode = mode,
        description = S("Soapstone Sandstone Block"),
        img_list = {top_img, bottom_img, "unilib_stone_sandstone_soapstone_block.png"},
    })

    unilib.register_stone_brick({
        -- Textures from UGBC, soapstone_sandstone_*.png. Original code. Creates
        --      unilib:stone_sandstone_soapstone_brick
        part_name = "sandstone_soapstone",
        orig_name = nil,

        replace_mode = mode,
        description = S("Soapstone Sandstone Bricks"),
        img_list = {top_img, bottom_img, "unilib_stone_sandstone_soapstone_brick.png"},
    })

    if unilib.setting.sandstone_cobble_rubble_flag then

        unilib.register_stone_cobble({
            -- Textures from UGBC, soapstone_sandstone_*.png. Original code. Creates
            --      unilib:stone_sandstone_soapstone_cobble
            part_name = "sandstone_soapstone",
            orig_name = nil,

            replace_mode = mode,
            description = S("Soapstone Sandstone Cobble"),
            img_list = {top_img, bottom_img, "unilib_stone_sandstone_soapstone_cobble.png"},
        })

        unilib.register_stone_cobble_compressed({
            -- Original to unilib. Creates unilib:stone_sandstone_soapstone_cobble_compressed
            part_name = "sandstone_soapstone",
            orig_name = nil,

            replace_mode = mode,
            description = S("Compressed Soapstone Sandstone Cobble"),
        })

        unilib.register_stone_cobble_condensed({
            -- Original to unilib. Creates unilib:stone_sandstone_soapstone_cobble_condensed
            part_name = "sandstone_soapstone",
            orig_name = nil,

            replace_mode = mode,
            description = S("Condensed Soapstone Sandstone Cobble"),
        })

    end

end
