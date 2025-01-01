---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    UGBC
-- Code:    GPLv2
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_sandstone_quartzite_red = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ugbc.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_sandstone_quartzite_red.init()

    return {
        description = "Red quartzite",
    }

end

function unilib.pkg.stone_sandstone_quartzite_red.exec()

    local top_img = "unilib_stone_sandstone_quartzite_red_top.png"
    local bottom_img = "unilib_stone_sandstone_quartzite_red_bottom.png"

    unilib.register_stone({
        -- Original to unilib
        part_name = "sandstone_quartzite_red",
        description = S("Red Quartzite Sandstone"),

        category = "sedimentary",
        colour = "#B6A484",
        grinder_flag = true,
        grinder_powder = "unilib:sand_quartzite_red",
        grinder_gravel = "unilib:gravel_quartzite_red",
        hardness = 4,
        not_super_flag = true,
    })

    unilib.register_stone_smooth({
        -- Textures from UGBC, quartzite_sandstone_*.png. Original code. Creates
        --      unilib:stone_sandstone_quartzite_red
        part_name = "sandstone_quartzite_red",
        orig_name = nil,

        replace_mode = mode,
        cobble_mode = "optional_cobble",
        description = S("Red Quartzite Sandstone"),
        img_list = {top_img, bottom_img, top_img},
    })

    unilib.register_stone_block({
        -- Textures from UGBC, quartzite_sandstone_*.png. Original code. Creates
        --      unilib:stone_sandstone_quartzite_red_block
        part_name = "sandstone_quartzite_red",
        orig_name = nil,

        replace_mode = mode,
        description = S("Red Quartzite Sandstone Block"),
        img_list = {top_img, bottom_img, "unilib_stone_sandstone_quartzite_red_block.png"},
    })

    unilib.register_stone_brick({
        -- Textures from UGBC, quartzite_sandstone_*.png. Original code. Creates
        --      unilib:stone_sandstone_quartzite_red_brick
        part_name = "sandstone_quartzite_red",
        orig_name = nil,

        replace_mode = mode,
        description = S("Red Quartzite Sandstone Bricks"),
        img_list = {top_img, bottom_img, "unilib_stone_sandstone_quartzite_red_brick.png"},
    })

    if unilib.setting.sandstone_cobble_rubble_flag then

        unilib.register_stone_cobble({
            -- Textures from UGBC, quartzite_sandstone_*.png. Original code. Creates
            --      unilib:stone_sandstone_quartzite_red_cobble
            part_name = "sandstone_quartzite_red",
            orig_name = nil,

            replace_mode = mode,
            description = S("Red Quartzite Sandstone Cobble"),
            img_list = {top_img, bottom_img, "unilib_stone_sandstone_quartzite_red_cobble.png"},
        })

        unilib.register_stone_cobble_compressed({
            -- Original to unilib. Creates unilib:stone_sandstone_quartzite_red_cobble_compressed
            part_name = "sandstone_quartzite_red",
            orig_name = nil,

            replace_mode = mode,
            description = S("Compressed Red Quartzite Sandstone Cobble"),
        })

        unilib.register_stone_cobble_condensed({
            -- Original to unilib. Creates unilib:stone_sandstone_quartzite_red_cobble_condensed
            part_name = "sandstone_quartzite_red",
            orig_name = nil,

            replace_mode = mode,
            description = S("Condensed Red Quartzite Sandstone Cobble"),
        })

    end

end
