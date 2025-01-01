---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    UGBC
-- Code:    GPLv2
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_migmatite = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ugbc.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_migmatite.init()

    return {
        description = "Migmatite",
    }

end

function unilib.pkg.stone_migmatite.exec()

    local top_img = "unilib_stone_migmatite.png"

    unilib.register_stone({
        -- Original to unilib
        part_name = "migmatite",
        description = S("Migmatite"),

        category = "metamorphic",
        colour = "#797A7C",
        grinder_flag = true,
        hardness = 3,
    })

    unilib.register_stone_smooth({
        -- Texture from UGBC, migmatite.png. Original code. Creates unilib:stone_migmatite
        part_name = "migmatite",
        orig_name = nil,

        replace_mode = mode,
        description = S("Migmatite"),
    })

    unilib.register_stone_block({
        -- Texture from UGBC, migmatite_slab_top.png. Original code. Creates
        --      unilib:stone_migmatite_block
        part_name = "migmatite",
        orig_name = nil,

        replace_mode = mode,
        description = S("Migmatite Block"),
        slab_img_list = {top_img, top_img, "unilib_stone_migmatite_slab.png"},
    })

    unilib.register_stone_brick({
        -- Texture from UGBC, migmatite_brick.png. Original code. Creates
        --      unilib:stone_migmatite_brick
        part_name = "migmatite",
        orig_name = nil,

        replace_mode = mode,
        description = S("Migmatite Bricks"),
    })

    unilib.register_stone_cobble({
        -- Texture from UGBC, migmatite_cobble.png. Original code. Creates
        --      unilib:stone_migmatite_cobble
        part_name = "migmatite",
        orig_name = nil,

        replace_mode = mode,
        description = S("Migmatite Cobble"),
    })

    unilib.register_stone_cobble_compressed({
        -- Original to unilib. Creates unilib:stone_migmatite_cobble_compressed
        part_name = "migmatite",
        orig_name = nil,

        replace_mode = mode,
        description = S("Compressed Migmatite Cobble"),
    })

    unilib.register_stone_cobble_condensed({
        -- Original to unilib. Creates unilib:stone_migmatite_cobble_condensed
        part_name = "migmatite",
        orig_name = nil,

        replace_mode = mode,
        description = S("Condensed Migmatite Cobble"),
    })

end
