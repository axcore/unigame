---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    UGBC
-- Code:    GPLv2
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_sandstone_marble_cream = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ugbc.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_sandstone_marble_cream.init()

    return {
        description = "Cream marble sandstone",
    }

end

function unilib.pkg.stone_sandstone_marble_cream.exec()

    local top_img = "unilib_stone_sandstone_marble_cream_top.png"
    local bottom_img = "unilib_stone_sandstone_marble_cream_bottom.png"

    unilib.register_stone({
        -- Original to unilib
        part_name = "sandstone_marble_cream",
        description = S("Cream Marble Sandstone"),

        category = "sedimentary",
        colour = "#F4EED3",
        grinder_flag = true,
        grinder_powder = "unilib:sand_marble_cream",
        grinder_gravel = "unilib:gravel_marble_cream",
        hardness = 4,
        not_super_flag = true,
    })

    unilib.register_stone_smooth({
        -- Textures from UGBC, marble_sandstone_*.png. Original code. Creates
        --      unilib:stone_sandstone_marble_cream
        part_name = "sandstone_marble_cream",
        orig_name = nil,

        replace_mode = mode,
        cobble_mode = "optional_cobble",
        description = S("Cream Marble Sandstone"),
        img_list = {top_img, bottom_img, top_img},
    })

    unilib.register_stone_block({
        -- Textures from UGBC, marble_sandstone_*.png. Original code. Creates
        --      unilib:stone_sandstone_marble_cream_block
        part_name = "sandstone_marble_cream",
        orig_name = nil,

        replace_mode = mode,
        description = S("Cream Marble Sandstone Block"),
        img_list = {top_img, bottom_img, "unilib_stone_sandstone_marble_cream_block.png"},
    })

    unilib.register_stone_brick({
        -- Textures from UGBC, marble_sandstone_*.png. Original code. Creates
        --      unilib:stone_sandstone_marble_cream_brick
        part_name = "sandstone_marble_cream",
        orig_name = nil,

        replace_mode = mode,
        description = S("Cream Marble Sandstone Bricks"),
        img_list = {top_img, bottom_img, "unilib_stone_sandstone_marble_cream_brick.png"},
    })

    if unilib.setting.sandstone_cobble_rubble_flag then

        unilib.register_stone_cobble({
            -- Textures from UGBC, marble_sandstone_*.png. Original code. Creates
            --      unilib:stone_sandstone_marble_cream_cobble
            part_name = "sandstone_marble_cream",
            orig_name = nil,

            replace_mode = mode,
            description = S("Cream Marble Sandstone Cobble"),
            img_list = {top_img, bottom_img, "unilib_stone_sandstone_marble_cream_cobble.png"},
        })

        unilib.register_stone_cobble_compressed({
            -- Original to unilib. Creates unilib:stone_sandstone_marble_cream_cobble_compressed
            part_name = "sandstone_marble_cream",
            orig_name = nil,

            replace_mode = mode,
            description = S("Compressed Cream Marble Sandstone Cobble"),
        })

        unilib.register_stone_cobble_condensed({
            -- Original to unilib. Creates unilib:stone_sandstone_marble_cream_cobble_condensed
            part_name = "sandstone_marble_cream",
            orig_name = nil,

            replace_mode = mode,
            description = S("Condensed Cream Marble Sandstone Cobble"),
        })

    end

end
