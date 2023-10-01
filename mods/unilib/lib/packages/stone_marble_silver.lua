---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    PFAA
-- Code:    Artistic-2.0
-- Media:   Artistic-2.0
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_marble_silver = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.pfaa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_marble_silver.init()

    return {
        description = "Silver marble",
    }

end

function unilib.pkg.stone_marble_silver.exec()

    unilib.register_stone({
        -- Original to unilib
        part_name = "marble_silver",
        description = S("Silver Marble"),

        category = "metamorphic",
        grinder_flag = true,
        hardness = 3,
    })

    unilib.register_stone_smooth({
        -- Texture from PFAA, strongStone_marble.png. Original code. Creates
        --  unilib:stone_marble_silver
        part_name = "marble_silver",
        orig_name = nil,

        replace_mode = mode,
        description = S("Silver Marble"),
        -- N.B. marble = 1 not in original code
        group_table = {marble = 1},
    })

    unilib.register_stone_block({
        -- Textures adapted from PFAA. Original code. Creates unilib:stone_marble_silver_block
        part_name = "marble_silver",
        orig_name = nil,

        replace_mode = mode,
        description = S("Silver Marble Block"),
        img_list = {"unilib_stone_marble_silver.png^unilib_stone_block_overlay.png"},
    })

    unilib.register_stone_brick({
        -- Textures adapted from PFAA. Original code. Creates unilib:stone_marble_silver_brick
        part_name = "marble_silver",
        orig_name = nil,

        replace_mode = mode,
        description = S("Silver Marble Bricks"),
        img_list = {"unilib_stone_marble_silver.png^unilib_stone_brick_overlay.png"},
    })

    unilib.register_stone_cobble({
        -- Textures adapted from PFAA. Original code. Creates unilib:stone_marble_silver_cobble
        part_name = "marble_silver",
        orig_name = nil,

        replace_mode = mode,
        description = S("Silver Marble Cobble"),
        img_list = {"unilib_stone_marble_silver.png^unilib_stone_cobble_overlay.png"},
    })

end
