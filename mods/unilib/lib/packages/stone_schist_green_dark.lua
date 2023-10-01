---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    PFAA
-- Code:    Artistic-2.0
-- Media:   Artistic-2.0
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_schist_green_dark = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.pfaa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_schist_green_dark.init()

    return {
        description = "Dark green schist",
    }

end

function unilib.pkg.stone_schist_green_dark.exec()

    unilib.register_stone({
        -- Original to unilib
        part_name = "schist_green_dark",
        description = S("Dark Green Schist"),

        category = "metamorphic",
        grinder_flag = true,
        hardness = 3,
    })

    unilib.register_stone_smooth({
        -- Texture from PFAA, strongStone_greenschist.png. Original code. Creates
        --      unilib:stone_schist_green_dark
        part_name = "schist_green_dark",
        orig_name = nil,

        replace_mode = mode,
        description = S("Dark Green Schist"),
    })

    unilib.register_stone_block({
        -- Textures adapted from PFAA. Original code. Creates unilib:stone_schist_green_dark_block
        part_name = "schist_green_dark",
        orig_name = nil,

        replace_mode = mode,
        description = S("Dark Green Schist Block"),
        img_list = {"unilib_stone_schist_green_dark.png^unilib_stone_block_overlay.png"},
    })

    unilib.register_stone_brick({
        -- Textures adapted from PFAA. Original code. Creates unilib:stone_schist_green_dark_brick
        part_name = "schist_green_dark",
        orig_name = nil,

        replace_mode = mode,
        description = S("Dark Green Schist Bricks"),
        img_list = {"unilib_stone_schist_green_dark.png^unilib_stone_brick_overlay.png"},
    })

    unilib.register_stone_cobble({
        -- Textures adapted from PFAA. Original code. Creates unilib:stone_schist_green_dark_cobble
        part_name = "schist_green_dark",
        orig_name = nil,

        replace_mode = mode,
        description = S("Dark Green Schist Cobble"),
        img_list = {"unilib_stone_schist_green_dark.png^unilib_stone_cobble_overlay.png"},
    })

end
