---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    UGBC
-- Code:    GPLv2
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_sandstone_schist_blue = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ugbc.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_sandstone_schist_blue.init()

    return {
        description = "Blue schist sandstone",
    }

end

function unilib.pkg.stone_sandstone_schist_blue.exec()

    local top_img = "unilib_stone_sandstone_schist_blue_top.png"
    local bottom_img = "unilib_stone_sandstone_schist_blue_bottom.png"

    unilib.register_stone({
        -- Original to unilib
        part_name = "sandstone_schist_blue",
        description = S("Blue Schist Sandstone"),

        category = "sedimentary",
        colour = "#A6B3AD",
        grinder_flag = true,
        grinder_powder = "unilib:sand_schist_blue",
        grinder_gravel = "unilib:gravel_schist_blue",
        hardness = 4,
        not_super_flag = true,
    })

    unilib.register_stone_smooth({
        -- Textures from UGBC, blueschist_sandstone_*.png. Original code. Creates
        --      unilib:stone_sandstone_schist_blue
        part_name = "sandstone_schist_blue",
        orig_name = nil,

        replace_mode = mode,
        cobble_mode = "optional_cobble",
        description = S("Blue Schist Sandstone"),
        img_list = {top_img, bottom_img, top_img},
    })

    unilib.register_stone_block({
        -- Textures from UGBC, blueschist_sandstone_*.png. Original code. Creates
        --      unilib:stone_sandstone_schist_blue_block
        part_name = "sandstone_schist_blue",
        orig_name = nil,

        replace_mode = mode,
        description = S("Blue Schist Sandstone Block"),
        img_list = {top_img, bottom_img, "unilib_stone_sandstone_schist_blue_block.png"},
    })

    unilib.register_stone_brick({
        -- Textures from UGBC, blueschist_sandstone_*.png. Original code. Creates
        --      unilib:stone_sandstone_schist_blue_brick
        part_name = "sandstone_schist_blue",
        orig_name = nil,

        replace_mode = mode,
        description = S("Blue Schist Sandstone Bricks"),
        img_list = {top_img, bottom_img, "unilib_stone_sandstone_schist_blue_brick.png"},
    })

    if unilib.setting.sandstone_cobble_rubble_flag then

        unilib.register_stone_cobble({
            -- Textures from UGBC, blueschist_sandstone_*.png. Original code. Creates
            --      unilib:stone_sandstone_schist_blue_cobble
            part_name = "sandstone_schist_blue",
            orig_name = nil,

            replace_mode = mode,
            description = S("Blue Schist Sandstone Cobble"),
            img_list = {top_img, bottom_img, "unilib_stone_sandstone_schist_blue_cobble.png"},
        })

        unilib.register_stone_cobble_compressed({
            -- Original to unilib. Creates unilib:stone_sandstone_schist_blue_cobble_compressed
            part_name = "sandstone_schist_blue",
            orig_name = nil,

            replace_mode = mode,
            description = S("Compressed Blue Schist Sandstone Cobble"),
        })

        unilib.register_stone_cobble_condensed({
            -- Original to unilib. Creates unilib:stone_sandstone_schist_blue_cobble_condensed
            part_name = "sandstone_schist_blue",
            orig_name = nil,

            replace_mode = mode,
            description = S("Condensed Blue Schist Sandstone Cobble"),
        })

    end

end
