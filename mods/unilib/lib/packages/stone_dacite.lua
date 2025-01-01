---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    UGBC
-- Code:    GPLv2
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_dacite = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ugbc.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_dacite.init()

    return {
        description = "Dacite",
    }

end

function unilib.pkg.stone_dacite.exec()

    local top_img = "unilib_stone_dacite.png"

    unilib.register_stone({
        -- Original to unilib
        part_name = "dacite",
        description = S("Dacite"),

        category = "extrusive",
        colour = "#7C7C7C",
        grinder_flag = true,
        hardness = 2,
    })

    unilib.register_stone_smooth({
        -- Texture from UGBC, dacite.png. Original code. Creates unilib:stone_dacite
        part_name = "dacite",
        orig_name = nil,

        replace_mode = mode,
        description = S("Dacite"),
    })

    unilib.register_stone_block({
        -- Texture from UGBC, dacite_slab_top.png. Original code. Creates unilib:stone_dacite_block
        part_name = "dacite",
        orig_name = nil,

        replace_mode = mode,
        description = S("Dacite Block"),
        slab_img_list = {top_img, top_img, "unilib_stone_dacite_slab.png"},
    })

    unilib.register_stone_brick({
        -- Texture from UGBC, dacite_brick.png. Original code. Creates unilib:stone_dacite_brick
        part_name = "dacite",
        orig_name = nil,

        replace_mode = mode,
        description = S("Dacite Bricks"),
    })

    unilib.register_stone_cobble({
        -- Texture from UGBC, dacite_cobble.png. Original code. Creates unilib:stone_dacite_cobble
        part_name = "dacite",
        orig_name = nil,

        replace_mode = mode,
        description = S("Dacite Cobble"),
    })

    unilib.register_stone_cobble_compressed({
        -- Original to unilib. Creates unilib:stone_dacite_cobble_compressed
        part_name = "dacite",
        orig_name = nil,

        replace_mode = mode,
        description = S("Compressed Dacite Cobble"),
    })

    unilib.register_stone_cobble_condensed({
        -- Original to unilib. Creates unilib:stone_dacite_cobble_condensed
        part_name = "dacite",
        orig_name = nil,

        replace_mode = mode,
        description = S("Condensed Dacite Cobble"),
    })

end
