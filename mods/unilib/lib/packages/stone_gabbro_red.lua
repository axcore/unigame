---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    PFAA
-- Code:    Artistic-2.0
-- Media:   Artistic-2.0
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_gabbro_red = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.pfaa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_gabbro_red.init()

    return {
        description = "Red gabbro",
    }

end

function unilib.pkg.stone_gabbro_red.exec()

    unilib.register_stone({
        -- Original to unilib
        part_name = "gabbro_red",
        description = S("Red Gabbro"),

        category = "intrusive",
        grinder_flag = true,
        hardness = 4,
    })

    unilib.register_stone_smooth({
        -- Texture from PFAA, veryStrongStone_gabbro.png. Original code. Creates
        --      unilib:stone_gabbro_red
        part_name = "gabbro_red",
        orig_name = nil,

        replace_mode = mode,
        cobble_mode = "smooth",
        description = S("Red Gabbro"),
    })

    unilib.register_stone_block({
        -- Textures adapted from PFAA. Original code. Creates unilib:stone_gabbro_red_block
        part_name = "gabbro_red",
        orig_name = nil,

        replace_mode = mode,
        description = S("Red Gabbro Block"),
        img_list = {"unilib_stone_gabbro_red.png^unilib_stone_block_overlay.png"},
    })

    unilib.register_stone_brick({
        -- Textures adapted from PFAA. Original code. Creates unilib:stone_gabbro_red_brick
        part_name = "gabbro_red",
        orig_name = nil,

        replace_mode = mode,
        description = S("Red Gabbro Bricks"),
        img_list = {"unilib_stone_gabbro_red.png^unilib_stone_brick_overlay.png"},
    })

end
