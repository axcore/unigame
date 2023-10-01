---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    PFAA
-- Code:    Artistic-2.0
-- Media:   Artistic-2.0
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_schist_brown = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.pfaa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_schist_brown.init()

    return {
        description = "Brown schist",
    }

end

function unilib.pkg.stone_schist_brown.exec()

    unilib.register_stone({
        -- Original to unilib
        part_name = "schist_brown",
        description = S("Brown Schist"),

        category = "metamorphic",
        grinder_flag = true,
        hardness = 2,
    })

    unilib.register_stone_smooth({
        -- Texture from PFAA, mediumStone_schist.png. Original code. Creates
        --      unilib:stone_schist_brown
        part_name = "schist_brown",
        orig_name = nil,

        replace_mode = mode,
        description = S("Brown Schist"),
    })

    unilib.register_stone_block({
        -- Textures adapted from PFAA. Original code. Creates unilib:stone_schist_brown_block
        part_name = "schist_brown",
        orig_name = nil,

        replace_mode = mode,
        description = S("Brown Schist Block"),
        img_list = {"unilib_stone_schist_brown.png^unilib_stone_block_overlay.png"},
    })

    unilib.register_stone_brick({
        -- Textures adapted from PFAA. Original code. Creates unilib:stone_schist_brown_brick
        part_name = "schist_brown",
        orig_name = nil,

        replace_mode = mode,
        description = S("Brown Schist Bricks"),
        img_list = {"unilib_stone_schist_brown.png^unilib_stone_brick_overlay.png"},
    })

    unilib.register_stone_cobble({
        -- Textures adapted from PFAA. Original code. Creates unilib:stone_schist_brown_cobble
        part_name = "schist_brown",
        orig_name = nil,

        replace_mode = mode,
        description = S("Brown Schist Cobble"),
        img_list = {"unilib_stone_schist_brown.png^unilib_stone_cobble_overlay.png"},
    })

end
