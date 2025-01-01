---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    PFAA
-- Code:    Artistic-2.0
-- Media:   Artistic-2.0
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_claystone_red = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.pfaa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_claystone_red.init()

    return {
        description = "Red Claystone",
    }

end

function unilib.pkg.stone_claystone_red.exec()

    unilib.register_stone({
        -- Original to unilib
        part_name = "claystone_red",
        description = S("Red Claystone"),

        category = "sedimentary",
        colour = "#D9B396",
        grinder_flag = true,
        hardness = 1,
    })

    unilib.register_stone_smooth({
        -- Texture from PFAA, weakStone_claystone.png. Original code. Creates
        --      unilib:stone_claystone_red
        part_name = "claystone_red",
        orig_name = nil,

        replace_mode = mode,
        cobble_mode = "rubble",
        description = S("Red Claystone"),
    })

    unilib.register_stone_block({
        -- Textures adapted from PFAA. Original code. Creates unilib:stone_claystone_red_block
        part_name = "claystone_red",
        orig_name = nil,

        replace_mode = mode,
        description = S("Red Claystone Block"),
        img_list = {"unilib_stone_claystone_red.png^unilib_stone_block_overlay.png"},
    })

    unilib.register_stone_brick({
        -- Textures adapted from PFAA. Original code. Creates unilib:stone_claystone_red_brick
        part_name = "claystone_red",
        orig_name = nil,

        replace_mode = mode,
        description = S("Red Claystone Bricks"),
        img_list = {"unilib_stone_claystone_red.png^unilib_stone_brick_overlay.png"},
    })

    unilib.register_stone_rubble({
        -- Textures adapted from PFAA. Original code. Creates unilib:stone_claystone_red_rubble
        part_name = "claystone_red",
        orig_name = nil,

        replace_mode = mode,
        description = S("Red Claystone Rubble"),
        img_list = {"unilib_stone_claystone_red.png^unilib_stone_rubble_overlay.png"},
    })

    unilib.register_stone_rubble_compressed({
        -- Original to unilib. Creates unilib:stone_claystone_red_rubble_compressed
        part_name = "claystone_red",
        orig_name = nil,

        replace_mode = mode,
        description = S("Compressed Red Claystone Rubble"),
    })

    unilib.register_stone_rubble_condensed({
        -- Original to unilib. Creates unilib:stone_claystone_red_rubble_condensed
        part_name = "claystone_red",
        orig_name = nil,

        replace_mode = mode,
        description = S("Condensed Red Claystone Rubble"),
    })

end
