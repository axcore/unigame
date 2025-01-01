---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    PFAA
-- Code:    Artistic-2.0
-- Media:   Artistic-2.0
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_slate_black = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.pfaa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_slate_black.init()

    return {
        description = "Black slate",
    }

end

function unilib.pkg.stone_slate_black.exec()

    unilib.register_stone({
        -- Original to unilib
        part_name = "slate_black",
        description = S("Black Slate"),

        category = "metamorphic",
        colour = "#3A3A3A",
        grinder_flag = true,
        hardness = 2,
    })

    unilib.register_stone_smooth({
        -- Texture from PFAA, mediumStone_slate.png. Original code. Creates unilib:stone_slate_black
        part_name = "slate_black",
        orig_name = nil,

        replace_mode = mode,
        description = S("Black Slate"),
    })

    unilib.register_stone_block({
        -- Textures adapted from PFAA. Original code. Creates unilib:stone_slate_black_block
        part_name = "slate_black",
        orig_name = nil,

        replace_mode = mode,
        description = S("Black Slate Block"),
        img_list = {"unilib_stone_slate_black.png^unilib_stone_block_overlay.png"},
    })

    unilib.register_stone_brick({
        -- Textures adapted from PFAA. Original code. Creates unilib:stone_slate_black_brick
        part_name = "slate_black",
        orig_name = nil,

        replace_mode = mode,
        description = S("Black Slate Bricks"),
        img_list = {"unilib_stone_slate_black.png^unilib_stone_brick_overlay.png"},
    })

    unilib.register_stone_cobble({
        -- Textures adapted from PFAA. Original code. Creates unilib:stone_slate_black_cobble
        part_name = "slate_black",
        orig_name = nil,

        replace_mode = mode,
        description = S("Black Slate Cobble"),
        img_list = {"unilib_stone_slate_black.png^unilib_stone_cobble_overlay.png"},
    })

    unilib.register_stone_cobble_compressed({
        -- Original to unilib. Creates unilib:stone_slate_black_cobble_compressed
        part_name = "slate_black",
        orig_name = nil,

        replace_mode = mode,
        description = S("Compressed Black Slate Cobble"),
    })

    unilib.register_stone_cobble_condensed({
        -- Original to unilib. Creates unilib:stone_slate_black_cobble_condensed
        part_name = "slate_black",
        orig_name = nil,

        replace_mode = mode,
        description = S("Condensed Black Slate Cobble"),
    })

end
