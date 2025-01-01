---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    UGBC
-- Code:    GPLv2
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_sandstone_chert = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ugbc.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_sandstone_chert.init()

    return {
        description = "Chert sandstone",
    }

end

function unilib.pkg.stone_sandstone_chert.exec()

    local top_img = "unilib_stone_sandstone_chert_top.png"
    local bottom_img = "unilib_stone_sandstone_chert_bottom.png"

    unilib.register_stone({
        -- Original to unilib
        part_name = "sandstone_chert",
        description = S("Chert Sandstone"),

        category = "sedimentary",
        colour = "#A19377",
        grinder_flag = true,
        grinder_powder = "unilib:sand_chert",
        grinder_gravel = "unilib:gravel_chert",
        hardness = 4,
        not_super_flag = true,
    })

    unilib.register_stone_smooth({
        -- Textures from UGBC, chert_sandstone_*.png. Original code. Creates
        --      unilib:stone_sandstone_chert
        part_name = "sandstone_chert",
        orig_name = nil,

        replace_mode = mode,
        cobble_mode = "optional_cobble",
        description = S("Chert Sandstone"),
        img_list = {top_img, bottom_img, top_img},
    })

    unilib.register_stone_block({
        -- Textures from UGBC, chert_sandstone_*.png. Original code. Creates
        --      unilib:stone_sandstone_chert_block
        part_name = "sandstone_chert",
        orig_name = nil,

        replace_mode = mode,
        description = S("Chert Sandstone Block"),
        img_list = {top_img, bottom_img, "unilib_stone_sandstone_chert_block.png"},
    })

    unilib.register_stone_brick({
        -- Textures from UGBC, chert_sandstone_*.png. Original code. Creates
        --      unilib:stone_sandstone_chert_brick
        part_name = "sandstone_chert",
        orig_name = nil,

        replace_mode = mode,
        description = S("Chert Sandstone Bricks"),
        img_list = {top_img, bottom_img, "unilib_stone_sandstone_chert_brick.png"},
    })

    if unilib.setting.sandstone_cobble_rubble_flag then

        unilib.register_stone_cobble({
            -- Textures from UGBC, chert_sandstone_*.png. Original code. Creates
            --      unilib:stone_sandstone_chert_cobble
            part_name = "sandstone_chert",
            orig_name = nil,

            replace_mode = mode,
            description = S("Chert Sandstone Cobble"),
            img_list = {top_img, bottom_img, "unilib_stone_sandstone_chert_cobble.png"},
        })

        unilib.register_stone_cobble_compressed({
            -- Original to unilib. Creates unilib:stone_sandstone_chert_cobble_compressed
            part_name = "sandstone_chert",
            orig_name = nil,

            replace_mode = mode,
            description = S("Compressed Chert Sandstone Cobble"),
        })

        unilib.register_stone_cobble_condensed({
            -- Original to unilib. Creates unilib:stone_sandstone_chert_cobble_condensed
            part_name = "sandstone_chert",
            orig_name = nil,

            replace_mode = mode,
            description = S("Condensed Chert Sandstone Cobble"),
        })

    end

end
