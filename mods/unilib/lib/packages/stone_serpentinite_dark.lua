---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    PFAA
-- Code:    Artistic-2.0
-- Media:   Artistic-2.0
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_serpentinite_dark = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.pfaa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_serpentinite_dark.init()

    return {
        description = "Dark Serpentinite",
    }

end

function unilib.pkg.stone_serpentinite_dark.exec()

    unilib.register_stone({
        -- Original to unilib
        part_name = "serpentinite_dark",
        description = S("Dark Serpentinite"),

        category = "metamorphic",
        grinder_flag = true,
        hardness = 2,
    })

    unilib.register_stone_smooth({
        -- Texture from PFAA, mediumStone_serpentinite.png. Original code. Creates
        --      unilib:stone_serpentinite_dark
        part_name = "serpentinite_dark",
        orig_name = nil,

        replace_mode = mode,
        description = S("Dark Serpentinite"),
    })

    unilib.register_stone_block({
        -- Textures adapted from PFAA. Original code. Creates unilib:stone_serpentinite_dark_block
        part_name = "serpentinite_dark",
        orig_name = nil,

        replace_mode = mode,
        description = S("Dark Serpentinite Block"),
        img_list = {"unilib_stone_serpentinite_dark.png^unilib_stone_block_overlay.png"},
    })

    unilib.register_stone_brick({
        -- Textures adapted from PFAA. Original code. Creates unilib:stone_serpentinite_dark_brick
        part_name = "serpentinite_dark",
        orig_name = nil,

        replace_mode = mode,
        description = S("Dark Serpentinite Bricks"),
        img_list = {"unilib_stone_serpentinite_dark.png^unilib_stone_brick_overlay.png"},
    })

    unilib.register_stone_cobble({
        -- Textures adapted from PFAA. Original code. Creates unilib:stone_serpentinite_dark_cobble
        part_name = "serpentinite_dark",
        orig_name = nil,

        replace_mode = mode,
        description = S("Dark Serpentinite Cobble"),
        img_list = {"unilib_stone_serpentinite_dark.png^unilib_stone_cobble_overlay.png"},
    })

end
