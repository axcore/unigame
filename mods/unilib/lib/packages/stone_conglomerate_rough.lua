---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    PFAA
-- Code:    Artistic-2.0
-- Media:   Artistic-2.0
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_conglomerate_rough = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.pfaa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_conglomerate_rough.init()

    return {
        description = "Rough conglomerate",
    }

end

function unilib.pkg.stone_conglomerate_rough.exec()

    unilib.register_stone({
        -- Original to unilib
        part_name = "conglomerate_rough",
        description = S("Rough Conglomerate"),

        category = "sedimentary",
        grinder_flag = false,
        hardness = 1,
    })

    unilib.register_stone_smooth({
        -- Texture from PFAA, weakStone_conglomerate.png. Original code. Creates
        --      unilib:stone_conglomerate_rough
        part_name = "conglomerate_rough",
        orig_name = nil,

        replace_mode = mode,
        cobble_mode = "rubble",
        description = S("Rough Conglomerate"),
    })

    unilib.register_stone_block({
        -- Textures adapted from PFAA. Original code. Creates unilib:stone_conglomerate_rough_block
        part_name = "conglomerate_rough",
        orig_name = nil,

        replace_mode = mode,
        description = S("Rough Conglomerate Block"),
        img_list = {"unilib_stone_conglomerate_rough.png^unilib_stone_block_overlay.png"},
    })

    unilib.register_stone_brick({
        -- Textures adapted from PFAA. Original code. Creates unilib:stone_conglomerate_rough_brick
        part_name = "conglomerate_rough",
        orig_name = nil,

        replace_mode = mode,
        description = S("Rough Conglomerate Bricks"),
        img_list = {"unilib_stone_conglomerate_rough.png^unilib_stone_brick_overlay.png"},
    })

    unilib.register_stone_rubble({
        -- Textures adapted from PFAA. Original code. Creates unilib:stone_conglomerate_rough_rubble
        part_name = "conglomerate_rough",
        orig_name = nil,

        replace_mode = mode,
        description = S("Rough Conglomerate Rubble"),
        img_list = {"unilib_stone_conglomerate_rough.png^unilib_stone_rubble_overlay.png"},
    })

end
