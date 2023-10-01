---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    PFAA
-- Code:    Artistic-2.0
-- Media:   Artistic-2.0
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_carbonatite = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.pfaa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_carbonatite.init()

    return {
        description = "Carbonatite",
    }

end

function unilib.pkg.stone_carbonatite.exec()

    unilib.register_stone({
        -- Original to unilib
        part_name = "carbonatite",
        description = S("Carbonatite"),

        category = "extrusive",
        grinder_flag = true,
        hardness = 1,
    })

    unilib.register_stone_smooth({
        -- Texture from PFAA, weakStone_carbonatite.png. Original code. Creates
        --      unilib:stone_carbonatite
        part_name = "carbonatite",
        orig_name = nil,

        replace_mode = mode,
        cobble_mode = "rubble",
        description = S("Carbonatite"),
    })

    unilib.register_stone_block({
        -- Textures adapted from PFAA. Original code. Creates unilib:stone_carbonatite_block
        part_name = "carbonatite",
        orig_name = nil,

        replace_mode = mode,
        description = S("Carbonatite Block"),
        img_list = {"unilib_stone_carbonatite.png^unilib_stone_block_overlay.png"},
    })

    unilib.register_stone_brick({
        -- Textures adapted from PFAA. Original code. Creates unilib:stone_carbonatite_brick
        part_name = "carbonatite",
        orig_name = nil,

        replace_mode = mode,
        description = S("Carbonatite Bricks"),
        img_list = {"unilib_stone_carbonatite.png^unilib_stone_brick_overlay.png"},
    })

    unilib.register_stone_rubble({
        -- Textures adapted from PFAA. Original code. Creates unilib:stone_carbonatite_rubble
        part_name = "carbonatite",
        orig_name = nil,

        replace_mode = mode,
        description = S("Carbonatite Rubble"),
        img_list = {"unilib_stone_carbonatite.png^unilib_stone_rubble_overlay.png"},
    })

end
