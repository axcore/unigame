---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    PFAA
-- Code:    Artistic-2.0
-- Media:   Artistic-2.0
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_diorite_dark = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.pfaa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_diorite_dark.init()

    return {
        description = "Dark diorite",
    }

end

function unilib.pkg.stone_diorite_dark.exec()

    unilib.register_stone({
        -- Original to unilib
        part_name = "diorite_dark",
        description = S("Dark Diorite"),

        category = "intrusive",
        grinder_flag = true,
        hardness = 4,
    })

    unilib.register_stone_smooth({
        -- Texture from PFAA, veryStrongStone_diorite.png. Original code. Creates
        --      unilib:stone_diorite_dark
        part_name = "diorite_dark",
        orig_name = nil,

        replace_mode = mode,
        cobble_mode = "smooth",
        description = S("Dark Diorite"),
    })

    unilib.register_stone_block({
        -- Textures adapted from PFAA. Original code. Creates unilib:stone_diorite_dark_block
        part_name = "diorite_dark",
        orig_name = nil,

        replace_mode = mode,
        description = S("Dark Diorite Block"),
        img_list = {"unilib_stone_diorite_dark.png^unilib_stone_block_overlay.png"},
    })

    unilib.register_stone_brick({
        -- Textures adapted from PFAA. Original code. Creates unilib:stone_diorite_dark_brick
        part_name = "diorite_dark",
        orig_name = nil,

        replace_mode = mode,
        description = S("Dark Diorite Bricks"),
        img_list = {"unilib_stone_diorite_dark.png^unilib_stone_brick_overlay.png"},
    })

end
