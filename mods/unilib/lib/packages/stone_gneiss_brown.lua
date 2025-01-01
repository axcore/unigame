---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    PFAA
-- Code:    Artistic-2.0
-- Media:   Artistic-2.0
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_gneiss_brown = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.pfaa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_gneiss_brown.init()

    return {
        description = "Brown gneiss",
    }

end

function unilib.pkg.stone_gneiss_brown.exec()

    unilib.register_stone({
        -- Original to unilib
        part_name = "gneiss_brown",
        description = S("Brown Gneiss"),

        category = "metamorphic",
        colour = "#605544",
        grinder_flag = true,
        hardness = 3,
    })

    unilib.register_stone_smooth({
        -- Texture from PFAA, strongStone_gneiss.png. Original code. Creates
        --      unilib:stone_gneiss_brown
        part_name = "gneiss_brown",
        orig_name = nil,

        replace_mode = mode,
        description = S("Brown Gneiss"),
    })

    unilib.register_stone_block({
        -- Textures adapted from PFAA. Original code. Creates unilib:stone_gneiss_brown_block
        part_name = "gneiss_brown",
        orig_name = nil,

        replace_mode = mode,
        description = S("Brown Gneiss Block"),
        img_list = {"unilib_stone_gneiss_brown.png^unilib_stone_block_overlay.png"},
    })

    unilib.register_stone_brick({
        -- Textures adapted from PFAA. Original code. Creates unilib:stone_gneiss_brown_brick
        part_name = "gneiss_brown",
        orig_name = nil,

        replace_mode = mode,
        description = S("Brown Gneiss Bricks"),
        img_list = {"unilib_stone_gneiss_brown.png^unilib_stone_brick_overlay.png"},
    })

    unilib.register_stone_cobble({
        -- Textures adapted from PFAA. Original code. Creates unilib:stone_gneiss_brown_cobble
        part_name = "gneiss_brown",
        orig_name = nil,

        replace_mode = mode,
        description = S("Brown Gneiss Cobble"),
        img_list = {"unilib_stone_gneiss_brown.png^unilib_stone_cobble_overlay.png"},
    })

    unilib.register_stone_cobble_compressed({
        -- Original to unilib. Creates unilib:stone_gneiss_brown_cobble_compressed
        part_name = "gneiss_brown",
        orig_name = nil,

        replace_mode = mode,
        description = S("Compressed Brown Gneiss Cobble"),
    })

    unilib.register_stone_cobble_condensed({
        -- Original to unilib. Creates unilib:stone_gneiss_brown_cobble_condensed
        part_name = "gneiss_brown",
        orig_name = nil,

        replace_mode = mode,
        description = S("Condensed Brown Gneiss Cobble"),
    })

end
