---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    UGBC
-- Code:    GPLv2
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_greywacke_pale = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ugbc.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_greywacke_pale.init()

    return {
        description = "Pale greywacke",
    }

end

function unilib.pkg.stone_greywacke_pale.exec()

    unilib.register_stone({
        -- Original to unilib
        part_name = "greywacke_pale",
        description = S("Pale Greywacke"),

        category = "sedimentary",
        colour = "#7F8073",
        grinder_flag = true,
        hardness = 3,
    })

    unilib.register_stone_smooth({
        -- Texture from UGBC, greywacke.png. Original code. Creates unilib:stone_greywacke_pale
        part_name = "greywacke_pale",
        orig_name = nil,

        replace_mode = mode,
        description = S("Pale Greywacke"),
    })

    unilib.register_stone_block({
        -- Original to unilib. Creates unilib:stone_greywacke_pale_block
        part_name = "greywacke_pale",
        orig_name = nil,

        replace_mode = mode,
        description = S("Pale Greywacke Block"),
        img_list = {"unilib_stone_greywacke_pale.png^unilib_stone_block_overlay.png"},
    })

    unilib.register_stone_brick({
        -- Original to unilib. Creates unilib:stone_greywacke_pale_brick
        part_name = "greywacke_pale",
        orig_name = nil,

        replace_mode = mode,
        description = S("Pale Greywacke Bricks"),
        img_list = {"unilib_stone_greywacke_pale.png^unilib_stone_brick_overlay.png"},
    })

    unilib.register_stone_cobble({
        -- Original to unilib. Creates unilib:stone_greywacke_pale_cobble
        part_name = "greywacke_pale",
        orig_name = nil,

        replace_mode = mode,
        description = S("Pale Greywacke Cobble"),
        img_list = {"unilib_stone_greywacke_pale.png^unilib_stone_cobble_overlay.png"},
    })

    unilib.register_stone_cobble_compressed({
        -- Original to unilib. Creates unilib:stone_greywacke_pale_cobble_compressed
        part_name = "greywacke_pale",
        orig_name = nil,

        replace_mode = mode,
        description = S("Compressed Pale Greywacke Cobble"),
    })

    unilib.register_stone_cobble_condensed({
        -- Original to unilib. Creates unilib:stone_greywacke_pale_cobble_condensed
        part_name = "greywacke_pale",
        orig_name = nil,

        replace_mode = mode,
        description = S("Condensed Pale Greywacke Cobble"),
    })

end
