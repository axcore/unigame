---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    UGBC
-- Code:    GPLv2
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_sandstone_granite_ebony = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ugbc.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_sandstone_granite_ebony.init()

    return {
        description = "Ebony granite sandstone",
    }

end

function unilib.pkg.stone_sandstone_granite_ebony.exec()

    local top_img = "unilib_stone_sandstone_granite_ebony_top.png"
    local bottom_img = "unilib_stone_sandstone_granite_ebony_bottom.png"

    unilib.register_stone({
        -- Original to unilib
        part_name = "sandstone_granite_ebony",
        description = S("Ebony Granite Sandstone"),

        category = "sedimentary",
        colour = "#79755C",
        grinder_flag = true,
        grinder_powder = "unilib:sand_granite_ebony",
        grinder_gravel = "unilib:gravel_granite_ebony",
        hardness = 4,
        not_super_flag = true,
    })

    unilib.register_stone_smooth({
        -- Textures from UGBC, black_granite_sandstone_*.png. Original code. Creates
        --      unilib:stone_sandstone_granite_ebony
        part_name = "sandstone_granite_ebony",
        orig_name = nil,

        replace_mode = mode,
        cobble_mode = "optional_cobble",
        description = S("Ebony Granite Sandstone"),
        img_list = {top_img, bottom_img, top_img},
    })

    unilib.register_stone_block({
        -- Textures from UGBC, black_granite_sandstone_*.png. Original code. Creates
        --      unilib:stone_sandstone_granite_ebony_block
        part_name = "sandstone_granite_ebony",
        orig_name = nil,

        replace_mode = mode,
        description = S("Ebony Granite Sandstone Block"),
        img_list = {top_img, bottom_img, "unilib_stone_sandstone_granite_ebony_block.png"},
    })

    unilib.register_stone_brick({
        -- Textures from UGBC, black_granite_sandstone_*.png. Original code. Creates
        --      unilib:stone_sandstone_granite_ebony_brick
        part_name = "sandstone_granite_ebony",
        orig_name = nil,

        replace_mode = mode,
        description = S("Ebony Granite Sandstone Bricks"),
        img_list = {top_img, bottom_img, "unilib_stone_sandstone_granite_ebony_brick.png"},
    })

    if unilib.setting.sandstone_cobble_rubble_flag then

        unilib.register_stone_cobble({
            -- Textures from UGBC, black_granite_sandstone_*.png. Original code. Creates
            --      unilib:stone_sandstone_granite_ebony_cobble
            part_name = "sandstone_granite_ebony",
            orig_name = nil,

            replace_mode = mode,
            description = S("Ebony Granite Sandstone Cobble"),
            img_list = {top_img, bottom_img, "unilib_stone_sandstone_granite_ebony_cobble.png"},
        })

        unilib.register_stone_cobble_compressed({
            -- Original to unilib. Creates unilib:stone_sandstone_granite_ebony_cobble_compressed
            part_name = "sandstone_granite_ebony",
            orig_name = nil,

            replace_mode = mode,
            description = S("Compressed Ebony Granite Sandstone Cobble"),
        })

        unilib.register_stone_cobble_condensed({
            -- Original to unilib. Creates unilib:stone_sandstone_granite_ebony_cobble_condensed
            part_name = "sandstone_granite_ebony",
            orig_name = nil,

            replace_mode = mode,
            description = S("Condensed Ebony Granite Sandstone Cobble"),
        })

    end

end
