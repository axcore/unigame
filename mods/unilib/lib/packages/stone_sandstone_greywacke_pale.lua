---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    UGBC
-- Code:    GPLv2
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_sandstone_greywacke_pale = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ugbc.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_sandstone_greywacke_pale.init()

    return {
        description = "Pale greywacke sandstone",
    }

end

function unilib.pkg.stone_sandstone_greywacke_pale.exec()

    local top_img = "unilib_stone_sandstone_greywacke_pale_top.png"
    local bottom_img = "unilib_stone_sandstone_greywacke_pale_bottom.png"

    unilib.register_stone({
        -- Original to unilib
        part_name = "sandstone_greywacke_pale",
        description = S("Pale Greywacke Sandstone"),

        category = "sedimentary",
        grinder_flag = true,
        grinder_powder = "unilib:sand_greywacke_pale",
        grinder_gravel = "unilib:gravel_greywacke_pale",
        hardness = 4,
        not_super_flag = true,
    })

    unilib.register_stone_smooth({
        -- Textures from UGBC, greywacke_sandstone_*.png. Original code. Creates
        --      unilib:stone_sandstone_greywacke_pale
        part_name = "sandstone_greywacke_pale",
        orig_name = nil,

        replace_mode = mode,
        cobble_mode = "optional_cobble",
        description = S("Pale Greywacke Sandstone"),
        img_list = {top_img, bottom_img, top_img},
    })

    unilib.register_stone_block({
        -- Textures from UGBC, greywacke_sandstone_*.png. Original code. Creates
        --      unilib:stone_sandstone_greywacke_pale_block
        part_name = "sandstone_greywacke_pale",
        orig_name = nil,

        replace_mode = mode,
        description = S("Pale Greywacke Sandstone Block"),
        img_list = {top_img, bottom_img, "unilib_stone_sandstone_greywacke_pale_block.png"},
    })

    unilib.register_stone_brick({
        -- Textures from UGBC, greywacke_sandstone_*.png. Original code. Creates
        --      unilib:stone_sandstone_greywacke_pale_brick
        part_name = "sandstone_greywacke_pale",
        orig_name = nil,

        replace_mode = mode,
        description = S("Pale Greywacke Sandstone Bricks"),
        img_list = {top_img, bottom_img, "unilib_stone_sandstone_greywacke_pale_brick.png"},
    })

    if unilib.sandstone_cobble_rubble_flag then

        unilib.register_stone_cobble({
            -- Textures from UGBC, greywacke_sandstone_*.png. Original code. Creates
            --      unilib:stone_sandstone_greywacke_pale_cobble
            part_name = "sandstone_greywacke_pale",
            orig_name = nil,

            replace_mode = mode,
            description = S("Pale Greywacke Sandstone Cobble"),
            img_list = {top_img, bottom_img, "unilib_stone_sandstone_greywacke_pale_cobble.png"},
        })

    end

end
