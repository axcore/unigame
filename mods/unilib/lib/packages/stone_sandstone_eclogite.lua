---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    UGBC
-- Code:    GPLv2
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_sandstone_eclogite = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ugbc.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_sandstone_eclogite.init()

    return {
        description = "Eclogite sandstone",
    }

end

function unilib.pkg.stone_sandstone_eclogite.exec()

    local top_img = "unilib_stone_sandstone_eclogite_top.png"
    local bottom_img = "unilib_stone_sandstone_eclogite_bottom.png"

    unilib.register_stone({
        -- Original to unilib
        part_name = "sandstone_eclogite",
        description = S("Eclogite Sandstone"),

        category = "sedimentary",
        colour = "#B5AA95",
        grinder_flag = true,
        grinder_powder = "unilib:sand_eclogite",
        grinder_gravel = "unilib:gravel_eclogite",
        hardness = 4,
        not_super_flag = true,
    })

    unilib.register_stone_smooth({
        -- Textures from UGBC, eclogite_sandstone_*.png. Original code. Creates
        --      unilib:stone_sandstone_eclogite
        part_name = "sandstone_eclogite",
        orig_name = nil,

        replace_mode = mode,
        cobble_mode = "optional_cobble",
        description = S("Eclogite Sandstone"),
        img_list = {top_img, bottom_img, top_img},
    })

    unilib.register_stone_block({
        -- Textures from UGBC, eclogite_sandstone_*.png. Original code. Creates
        --      unilib:stone_sandstone_eclogite_block
        part_name = "sandstone_eclogite",
        orig_name = nil,

        replace_mode = mode,
        description = S("Eclogite Sandstone Block"),
        img_list = {top_img, bottom_img, "unilib_stone_sandstone_eclogite_block.png"},
    })

    unilib.register_stone_brick({
        -- Textures from UGBC, eclogite_sandstone_*.png. Original code. Creates
        --      unilib:stone_sandstone_eclogite_brick
        part_name = "sandstone_eclogite",
        orig_name = nil,

        replace_mode = mode,
        description = S("Eclogite Sandstone Bricks"),
        img_list = {top_img, bottom_img, "unilib_stone_sandstone_eclogite_brick.png"},
    })

    if unilib.setting.sandstone_cobble_rubble_flag then

        unilib.register_stone_cobble({
            -- Textures from UGBC, eclogite_sandstone_*.png. Original code. Creates
            --      unilib:stone_sandstone_eclogite_cobble
            part_name = "sandstone_eclogite",
            orig_name = nil,

            replace_mode = mode,
            description = S("Eclogite Sandstone Cobble"),
            img_list = {top_img, bottom_img, "unilib_stone_sandstone_eclogite_cobble.png"},
        })

        unilib.register_stone_cobble_compressed({
            -- Original to unilib. Creates unilib:stone_sandstone_eclogite_cobble_compressed
            part_name = "sandstone_eclogite",
            orig_name = nil,

            replace_mode = mode,
            description = S("Compressed Eclogite Sandstone Cobble"),
        })

        unilib.register_stone_cobble_condensed({
            -- Original to unilib. Creates unilib:stone_sandstone_eclogite_cobble_condensed
            part_name = "sandstone_eclogite",
            orig_name = nil,

            replace_mode = mode,
            description = S("Condensed Eclogite Sandstone Cobble"),
        })

    end

end
