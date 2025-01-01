---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    UGBC
-- Code:    GPLv2
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_sandstone_migmatite = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ugbc.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_sandstone_migmatite.init()

    return {
        description = "Migmatite sandstone",
    }

end

function unilib.pkg.stone_sandstone_migmatite.exec()

    local top_img = "unilib_stone_sandstone_migmatite_top.png"
    local bottom_img = "unilib_stone_sandstone_migmatite_bottom.png"

    unilib.register_stone({
        -- Original to unilib
        part_name = "sandstone_migmatite",
        description = S("Migmatite Sandstone"),

        category = "sedimentary",
        colour = "#9D9985",
        grinder_flag = true,
        grinder_powder = "unilib:sand_migmatite",
        grinder_gravel = "unilib:gravel_migmatite",
        hardness = 4,
        not_super_flag = true,
    })

    unilib.register_stone_smooth({
        -- Textures from UGBC, migmatite_sandstone_*.png. Original code. Creates
        --      unilib:stone_sandstone_migmatite
        part_name = "sandstone_migmatite",
        orig_name = nil,

        replace_mode = mode,
        cobble_mode = "optional_cobble",
        description = S("Migmatite Sandstone"),
        img_list = {top_img, bottom_img, top_img},
    })

    unilib.register_stone_block({
        -- Textures from UGBC, migmatite_sandstone_*.png. Original code. Creates
        --      unilib:stone_sandstone_migmatite_block
        part_name = "sandstone_migmatite",
        orig_name = nil,

        replace_mode = mode,
        description = S("Migmatite Sandstone Block"),
        img_list = {top_img, bottom_img, "unilib_stone_sandstone_migmatite_block.png"},
    })

    unilib.register_stone_brick({
        -- Textures from UGBC, migmatite_sandstone_*.png. Original code. Creates
        --      unilib:stone_sandstone_migmatite_brick
        part_name = "sandstone_migmatite",
        orig_name = nil,

        replace_mode = mode,
        description = S("Migmatite Sandstone Bricks"),
        img_list = {top_img, bottom_img, "unilib_stone_sandstone_migmatite_brick.png"},
    })

    if unilib.setting.sandstone_cobble_rubble_flag then

        unilib.register_stone_cobble({
            -- Textures from UGBC, migmatite_sandstone_*.png. Original code. Creates
            --      unilib:stone_sandstone_migmatite_cobble
            part_name = "sandstone_migmatite",
            orig_name = nil,

            replace_mode = mode,
            description = S("Migmatite Sandstone Cobble"),
            img_list = {top_img, bottom_img, "unilib_stone_sandstone_migmatite_cobble.png"},
        })

        unilib.register_stone_cobble_compressed({
            -- Original to unilib. Creates unilib:stone_sandstone_migmatite_cobble_compressed
            part_name = "sandstone_migmatite",
            orig_name = nil,

            replace_mode = mode,
            description = S("Compressed Migmatite Sandstone Cobble"),
        })

        unilib.register_stone_cobble_condensed({
            -- Original to unilib. Creates unilib:stone_sandstone_migmatite_cobble_condensed
            part_name = "sandstone_migmatite",
            orig_name = nil,

            replace_mode = mode,
            description = S("Condensed Migmatite Sandstone Cobble"),
        })

    end

end
