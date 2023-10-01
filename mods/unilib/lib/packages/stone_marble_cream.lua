---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    UGBC
-- Code:    GPLv2
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_marble_cream = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ugbc.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_marble_cream.init()

    return {
        description = "Cream marble",
        notes = "The textures from the original mod have been tweaked, so that we don't have" ..
                " quite so many white-ish marbles",
    }

end

function unilib.pkg.stone_marble_cream.exec()

    local top_img = "unilib_stone_marble_cream.png"

    unilib.register_stone({
        -- Original to unilib
        part_name = "marble_cream",
        description = S("Cream Marble"),

        category = "metamorphic",
        grinder_flag = true,
        hardness = 3,
    })

    unilib.register_stone_smooth({
        -- Texture from UGBC, marble.png. Original code. Creates unilib:stone_marble_cream
        part_name = "marble_cream",
        orig_name = nil,

        replace_mode = mode,
        description = S("Cream Marble"),
        -- N.B. marble = 1 not in original code
        group_table = {marble = 1},
    })

    unilib.register_stone_block({
        -- Texture from UGBC, marble_slab_top.png. Original code. Creates
        --      unilib:stone_marble_cream_block
        part_name = "marble_cream",
        orig_name = nil,

        replace_mode = mode,
        description = S("Cream Marble Block"),
        slab_img_list = {top_img, top_img, "unilib_stone_marble_cream_slab.png"},
    })

    unilib.register_stone_brick({
        -- Texture from UGBC, marble_brick.png. Original code. Creates
        --      unilib:stone_marble_cream_brick
        part_name = "marble_cream",
        orig_name = nil,

        replace_mode = mode,
        description = S("Cream Marble Bricks"),
    })

    unilib.register_stone_cobble({
        -- Texture from UGBC, marble_cobble.png. Original code. Creates
        --      unilib:stone_marble_cream_cobble
        part_name = "marble_cream",
        orig_name = nil,

        replace_mode = mode,
        description = S("Cream Marble Cobble"),
    })

end
