---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    UGBC
-- Code:    GPLv2
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_sandstone_dacite = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ugbc.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_sandstone_dacite.init()

    return {
        description = "Dacite",
    }

end

function unilib.pkg.stone_sandstone_dacite.exec()

    local top_img = "unilib_stone_sandstone_dacite_top.png"
    local bottom_img = "unilib_stone_sandstone_dacite_bottom.png"

    unilib.register_stone({
        -- Original to unilib
        part_name = "sandstone_dacite",
        description = S("Dacite Sandstone"),

        category = "sedimentary",
        colour = "#C0BEA5",
        grinder_flag = true,
        grinder_powder = "unilib:sand_dacite",
        grinder_gravel = "unilib:gravel_dacite",
        hardness = 4,
        not_super_flag = true,
    })

    unilib.register_stone_smooth({
        -- Textures from UGBC, dacite_sandstone_*.png. Original code. Creates
        --      unilib:stone_sandstone_dacite
        part_name = "sandstone_dacite",
        orig_name = nil,

        replace_mode = mode,
        cobble_mode = "optional_cobble",
        description = S("Dacite Sandstone"),
        img_list = {top_img, bottom_img, top_img},
    })

    unilib.register_stone_block({
        -- Textures from UGBC, dacite_sandstone_*.png. Original code. Creates
        --      unilib:stone_sandstone_dacite_block
        part_name = "sandstone_dacite",
        orig_name = nil,

        replace_mode = mode,
        description = S("Dacite Sandstone Block"),
        img_list = {top_img, bottom_img, "unilib_stone_sandstone_dacite_block.png"},
    })

    unilib.register_stone_brick({
        -- Textures from UGBC, dacite_sandstone_*.png. Original code. Creates
        --      unilib:stone_sandstone_dacite_brick
        part_name = "sandstone_dacite",
        orig_name = nil,

        replace_mode = mode,
        description = S("Dacite Sandstone Bricks"),
        img_list = {top_img, bottom_img, "unilib_stone_sandstone_dacite_brick.png"},
    })

    if unilib.setting.sandstone_cobble_rubble_flag then

        unilib.register_stone_cobble({
            -- Textures from UGBC, dacite_sandstone_*.png. Original code. Creates
            --      unilib:stone_sandstone_dacite_cobble
            part_name = "sandstone_dacite",
            orig_name = nil,

            replace_mode = mode,
            description = S("Dacite Sandstone Cobble"),
            img_list = {top_img, bottom_img, "unilib_stone_sandstone_dacite_cobble.png"},
        })

        unilib.register_stone_cobble_compressed({
            -- Original to unilib. Creates unilib:stone_sandstone_dacite_cobble_compressed
            part_name = "sandstone_dacite",
            orig_name = nil,

            replace_mode = mode,
            description = S("Compressed Dacite Sandstone Cobble"),
        })

        unilib.register_stone_cobble_condensed({
            -- Original to unilib. Creates unilib:stone_sandstone_dacite_cobble_condensed
            part_name = "sandstone_dacite",
            orig_name = nil,

            replace_mode = mode,
            description = S("Condensed Dacite Sandstone Cobble"),
        })

    end

end
