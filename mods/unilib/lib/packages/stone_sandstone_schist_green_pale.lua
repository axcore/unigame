---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    UGBC
-- Code:    GPLv2
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_sandstone_schist_green_pale = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ugbc.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_sandstone_schist_green_pale.init()

    return {
        description = "Pale green schist sandstone",
    }

end

function unilib.pkg.stone_sandstone_schist_green_pale.exec()

    local top_img = "unilib_stone_sandstone_schist_green_pale_top.png"
    local bottom_img = "unilib_stone_sandstone_schist_green_pale_bottom.png"

    unilib.register_stone({
        -- Original to unilib
        part_name = "sandstone_schist_green_pale",
        description = S("Pale Green Schist Sandstone"),

        category = "sedimentary",
        colour = "#9B9F7E",
        grinder_flag = true,
        grinder_powder = "unilib:sand_schist_green_pale",
        grinder_gravel = "unilib:gravel_schist_green_pale",
        hardness = 4,
        not_super_flag = true,
    })

    unilib.register_stone_smooth({
        -- Textures from UGBC, greenschist_sandstone_*.png. Original code. Creates
        --      unilib:stone_sandstone_schist_green_pale
        part_name = "sandstone_schist_green_pale",
        orig_name = nil,

        replace_mode = mode,
        cobble_mode = "optional_cobble",
        description = S("Pale Green Schist Sandstone"),
        img_list = {top_img, bottom_img, top_img},
    })

    unilib.register_stone_block({
        -- Textures from UGBC, greenschist_sandstone_*.png. Original code. Creates
        --      unilib:stone_sandstone_schist_green_pale_block
        part_name = "sandstone_schist_green_pale",
        orig_name = nil,

        replace_mode = mode,
        description = S("Pale Green Schist Sandstone Block"),
        img_list = {top_img, bottom_img, "unilib_stone_sandstone_schist_green_pale_block.png"},
    })

    unilib.register_stone_brick({
        -- Textures from UGBC, greenschist_sandstone_*.png. Original code. Creates
        --      unilib:stone_sandstone_schist_green_pale_brick
        part_name = "sandstone_schist_green_pale",
        orig_name = nil,

        replace_mode = mode,
        description = S("Pale Green Schist Sandstone Bricks"),
        img_list = {top_img, bottom_img, "unilib_stone_sandstone_schist_green_pale_brick.png"},
    })

    if unilib.setting.sandstone_cobble_rubble_flag then

        unilib.register_stone_cobble({
            -- Textures from UGBC, greenschist_sandstone_*.png. Original code. Creates
            --      unilib:stone_sandstone_schist_green_pale_cobble
            part_name = "sandstone_schist_green_pale",
            orig_name = nil,

            replace_mode = mode,
            description = S("Pale Green Schist Sandstone Cobble"),
            img_list = {top_img, bottom_img, "unilib_stone_sandstone_schist_green_pale_cobble.png"},
        })

        unilib.register_stone_cobble_compressed({
            -- Original to unilib. Creates
            --      unilib:stone_sandstone_schist_green_pale_cobble_compressed
            part_name = "sandstone_schist_green_pale",
            orig_name = nil,

            replace_mode = mode,
            description = S("Compressed Pale Green Schist Sandstone Cobble"),
        })

        unilib.register_stone_cobble_condensed({
            -- Original to unilib. Creates unilib:stone_sandstone_schist_green_pale_cobble_condensed
            part_name = "sandstone_schist_green_pale",
            orig_name = nil,

            replace_mode = mode,
            description = S("Condensed Pale Green Schist Sandstone Cobble"),
        })

    end

end
