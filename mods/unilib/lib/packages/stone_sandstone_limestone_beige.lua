---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    UGBC
-- Code:    GPLv2
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_sandstone_limestone_beige = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ugbc.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_sandstone_limestone_beige.init()

    return {
        description = "Beige limestone sandstone",
    }

end

function unilib.pkg.stone_sandstone_limestone_beige.exec()

    local top_img = "unilib_stone_sandstone_limestone_beige_top.png"
    local bottom_img = "unilib_stone_sandstone_limestone_beige_bottom.png"

    unilib.register_stone({
        -- Original to unilib
        part_name = "sandstone_limestone_beige",
        description = S("Beige Limestone Sandstone"),

        category = "sedimentary",
        colour = "#C5BD96",
        grinder_flag = true,
        grinder_powder = "unilib:sand_limestone_beige",
        grinder_gravel = "unilib:gravel_limestone_beige",
        hardness = 4,
        not_super_flag = true,
    })

    unilib.register_stone_smooth({
        -- Textures from UGBC, limestone_sandstone_*.png. Original code. Creates
        --      unilib:stone_sandstone_limestone_beige
        part_name = "sandstone_limestone_beige",
        orig_name = nil,

        replace_mode = mode,
        cobble_mode = "optional_cobble",
        description = S("Beige Limestone Sandstone"),
        img_list = {top_img, bottom_img, top_img},
    })

    unilib.register_stone_block({
        -- Textures from UGBC, limestone_sandstone_*.png. Original code. Creates
        --      unilib:stone_sandstone_limestone_beige_block
        part_name = "sandstone_limestone_beige",
        orig_name = nil,

        replace_mode = mode,
        description = S("Beige Limestone Sandstone Block"),
        img_list = {top_img, bottom_img, "unilib_stone_sandstone_limestone_beige_block.png"},
    })

    unilib.register_stone_brick({
        -- Textures from UGBC, limestone_sandstone_*.png. Original code. Creates
        --      unilib:stone_sandstone_limestone_beige_brick
        part_name = "sandstone_limestone_beige",
        orig_name = nil,

        replace_mode = mode,
        description = S("Beige Limestone Sandstone Bricks"),
        img_list = {top_img, bottom_img, "unilib_stone_sandstone_limestone_beige_brick.png"},
    })

    if unilib.setting.sandstone_cobble_rubble_flag then

        unilib.register_stone_cobble({
            -- Textures from UGBC, limestone_sandstone_*.png. Original code. Creates
            --      unilib:stone_sandstone_limestone_beige_cobble
            part_name = "sandstone_limestone_beige",
            orig_name = nil,

            replace_mode = mode,
            description = S("Beige Limestone Sandstone Cobble"),
            img_list = {top_img, bottom_img, "unilib_stone_sandstone_limestone_beige_cobble.png"},
        })

        unilib.register_stone_cobble_compressed({
            -- Original to unilib. Creates unilib:stone_sandstone_limestone_beige_cobble_compressed
            part_name = "sandstone_limestone_beige",
            orig_name = nil,

            replace_mode = mode,
            description = S("Compressed Beige Limestone Sandstone Cobble"),
        })

        unilib.register_stone_cobble_condensed({
            -- Original to unilib. Creates unilib:stone_sandstone_limestone_beige_cobble_condensed
            part_name = "sandstone_limestone_beige",
            orig_name = nil,

            replace_mode = mode,
            description = S("Condensed Beige Limestone Sandstone Cobble"),
        })

    end

end
