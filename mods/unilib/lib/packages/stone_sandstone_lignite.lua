---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    UGBC
-- Code:    GPLv2
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_sandstone_lignite = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ugbc.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_sandstone_lignite.init()

    return {
        description = "Lignite sandstone",
    }

end

function unilib.pkg.stone_sandstone_lignite.exec()

    local top_img = "unilib_stone_sandstone_lignite_top.png"
    local bottom_img = "unilib_stone_sandstone_lignite_bottom.png"

    unilib.register_stone({
        -- Original to unilib
        part_name = "sandstone_lignite",
        description = S("Lignite Sandstone"),

        category = "sedimentary",
        colour = "#6D6B52",
        grinder_flag = true,
        grinder_powder = "unilib:sand_lignite",
        grinder_gravel = "unilib:gravel_lignite",
        hardness = 4,
        not_super_flag = true,
    })

    unilib.register_stone_smooth({
        -- Textures from UGBC, lignite_sandstone_*.png. Original code. Creates
        --      unilib:stone_sandstone_lignite
        part_name = "sandstone_lignite",
        orig_name = nil,

        replace_mode = mode,
        cobble_mode = "optional_cobble",
        description = S("Lignite Sandstone"),
        img_list = {top_img, bottom_img, top_img},
    })

    unilib.register_stone_block({
        -- Textures from UGBC, lignite_sandstone_*.png. Original code. Creates
        --      unilib:stone_sandstone_lignite_block
        part_name = "sandstone_lignite",
        orig_name = nil,

        replace_mode = mode,
        description = S("Lignite Sandstone Block"),
        img_list = {top_img, bottom_img, "unilib_stone_sandstone_lignite_block.png"},
    })

    unilib.register_stone_brick({
        -- Textures from UGBC, lignite_sandstone_*.png. Original code. Creates
        --      unilib:stone_sandstone_lignite_brick
        part_name = "sandstone_lignite",
        orig_name = nil,

        replace_mode = mode,
        description = S("Lignite Sandstone Bricks"),
        img_list = {top_img, bottom_img, "unilib_stone_sandstone_lignite_brick.png"},
    })

    if unilib.setting.sandstone_cobble_rubble_flag then

        unilib.register_stone_cobble({
            -- Textures from UGBC, lignite_sandstone_*.png. Original code. Creates
            --      unilib:stone_sandstone_lignite_cobble
            part_name = "sandstone_lignite",
            orig_name = nil,

            replace_mode = mode,
            description = S("Lignite Sandstone Cobble"),
            img_list = {top_img, bottom_img, "unilib_stone_sandstone_lignite_cobble.png"},
        })

        unilib.register_stone_cobble_compressed({
            -- Original to unilib. Creates unilib:stone_sandstone_lignite_cobble_compressed
            part_name = "sandstone_lignite",
            orig_name = nil,

            replace_mode = mode,
            description = S("Compressed Lignite Sandstone Cobble"),
        })

        unilib.register_stone_cobble_condensed({
            -- Original to unilib. Creates unilib:stone_sandstone_lignite_cobble_condensed
            part_name = "sandstone_lignite",
            orig_name = nil,

            replace_mode = mode,
            description = S("Condensed Lignite Sandstone Cobble"),
        })

    end

end
