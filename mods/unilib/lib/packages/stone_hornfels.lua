---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    PFAA
-- Code:    Artistic-2.0
-- Media:   Artistic-2.0
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_hornfels = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.pfaa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_hornfels.init()

    return {
        description = "Hornfels",
    }

end

function unilib.pkg.stone_hornfels.exec()

    unilib.register_stone({
        -- Original to unilib
        part_name = "hornfels",
        description = S("Hornfels"),

        category = "metamorphic",
        grinder_flag = true,
        hardness = 4,
    })

    unilib.register_stone_smooth({
        -- Texture from PFAA, veryStrongStone_hornfels.png. Original code. Creates
        --      unilib:stone_hornfels
        part_name = "hornfels",
        orig_name = nil,

        replace_mode = mode,
        cobble_mode = "smooth",
        description = S("Hornfels"),
    })

    unilib.register_stone_block({
        -- Textures adapted from PFAA. Original code. Creates unilib:stone_hornfels_block
        part_name = "hornfels",
        orig_name = nil,

        replace_mode = mode,
        description = S("Hornfels Block"),
        img_list = {"unilib_stone_hornfels.png^unilib_stone_block_overlay.png"},
    })

    unilib.register_stone_brick({
        -- Textures adapted from PFAA. Original code. Creates unilib:stone_hornfels_brick
        part_name = "hornfels",
        orig_name = nil,

        replace_mode = mode,
        description = S("Hornfels Bricks"),
        img_list = {"unilib_stone_hornfels.png^unilib_stone_brick_overlay.png"},
    })

end
