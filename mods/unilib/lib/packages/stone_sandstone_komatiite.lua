---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    UGBC
-- Code:    GPLv2
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_sandstone_komatiite = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ugbc.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_sandstone_komatiite.init()

    return {
        description = "Komatiite sandstone",
    }

end

function unilib.pkg.stone_sandstone_komatiite.exec()

    local top_img = "unilib_stone_sandstone_komatiite_top.png"
    local bottom_img = "unilib_stone_sandstone_komatiite_bottom.png"

    unilib.register_stone({
        -- Original to unilib
        part_name = "sandstone_komatiite",
        description = S("Komatiite Sandstone"),

        category = "sedimentary",
        grinder_flag = true,
        grinder_powder = "unilib:sand_komatiite",
        grinder_gravel = "unilib:gravel_komatiite",
        hardness = 4,
        not_super_flag = true,
    })

    unilib.register_stone_smooth({
        -- Textures from UGBC, komatiite_sandstone_*.png. Original code. Creates
        --      unilib:stone_sandstone_komatiite
        part_name = "sandstone_komatiite",
        orig_name = nil,

        replace_mode = mode,
        cobble_mode = "optional_cobble",
        description = S("Komatiite Sandstone"),
        img_list = {top_img, bottom_img, top_img},
    })

    unilib.register_stone_block({
        -- Textures from UGBC, komatiite_sandstone_*.png. Original code. Creates
        --      unilib:stone_sandstone_komatiite_block
        part_name = "sandstone_komatiite",
        orig_name = nil,

        replace_mode = mode,
        description = S("Komatiite Sandstone Block"),
        img_list = {top_img, bottom_img, "unilib_stone_sandstone_komatiite_block.png"},
    })

    unilib.register_stone_brick({
        -- Textures from UGBC, komatiite_sandstone_*.png. Original code. Creates
        --      unilib:stone_sandstone_komatiite_brick
        part_name = "sandstone_komatiite",
        orig_name = nil,

        replace_mode = mode,
        description = S("Komatiite Sandstone Bricks"),
        img_list = {top_img, bottom_img, "unilib_stone_sandstone_komatiite_brick.png"},
    })

    if unilib.sandstone_cobble_rubble_flag then

        unilib.register_stone_cobble({
            -- Textures from UGBC, komatiite_sandstone_*.png. Original code. Creates
            --      unilib:stone_sandstone_komatiite_cobble
            part_name = "sandstone_komatiite",
            orig_name = nil,

            replace_mode = mode,
            description = S("Komatiite Sandstone Cobble"),
            img_list = {top_img, bottom_img, "unilib_stone_sandstone_komatiite_cobble.png"},
        })

    end

end
