---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    PFAA
-- Code:    Artistic-2.0
-- Media:   Artistic-2.0
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_basalt_red = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.pfaa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_basalt_red.init()

    return {
        description = "Red basalt",
    }

end

function unilib.pkg.stone_basalt_red.exec()

    unilib.register_stone({
        -- Original to unilib
        part_name = "basalt_red",
        description = S("Red Basalt"),

        category = "extrusive",
        colour = "#3B3131",
        grinder_flag = true,
        hardness = 3,
    })

    unilib.register_stone_smooth({
        -- Texture from PFAA, strongStone_basalt.png. Original code. Creates
        --      unilib:stone_basalt_red
        part_name = "basalt_red",
        orig_name = nil,

        replace_mode = mode,
        description = S("Red Basalt"),
    })

    unilib.register_stone_block({
        -- Textures adapted from PFAA. Original code. Creates unilib:stone_basalt_red_block
        part_name = "basalt_red",
        orig_name = nil,

        replace_mode = mode,
        description = S("Red Basalt Block"),
        img_list = {"unilib_stone_basalt_red.png^unilib_stone_block_overlay.png"},
    })

    unilib.register_stone_brick({
        -- Textures adapted from PFAA. Original code. Creates unilib:stone_basalt_red_brick
        part_name = "basalt_red",
        orig_name = nil,

        replace_mode = mode,
        description = S("Red Basalt Bricks"),
        img_list = {"unilib_stone_basalt_red.png^unilib_stone_brick_overlay.png"},
    })

    unilib.register_stone_cobble({
        -- Textures adapted from PFAA. Original code. Creates unilib:stone_basalt_red_cobble
        part_name = "basalt_red",
        orig_name = nil,

        replace_mode = mode,
        description = S("Red Basalt Cobble"),
        img_list = {"unilib_stone_basalt_red.png^unilib_stone_cobble_overlay.png"},
    })

    unilib.register_stone_cobble_compressed({
        -- Original to unilib. Creates unilib:stone_basalt_red_cobble_compressed
        part_name = "basalt_red",
        orig_name = nil,

        replace_mode = mode,
        description = S("Compressed Red Basalt Cobble"),
    })

    unilib.register_stone_cobble_condensed({
        -- Original to unilib. Creates unilib:stone_basalt_red_cobble_condensed
        part_name = "basalt_red",
        orig_name = nil,

        replace_mode = mode,
        description = S("Condensed Red Basalt Cobble"),
    })

end
