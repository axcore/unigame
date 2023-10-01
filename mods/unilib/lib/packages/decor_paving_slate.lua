---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    GLEMr6
-- Code:    LGPL 2.1
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.decor_paving_slate = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.glemr6.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.decor_paving_slate.init()

    return {
        description = "Paving slates",
        depends = "roof_slate_normal",
    }

end

function unilib.pkg.decor_paving_slate.exec()

    unilib.register_node(
        -- Texture from castle/castle_masonry, castle_slate.png. Code from GLEMr6,
        --      lib_materials:stone_castle_slate
        "unilib:decor_paving_slate",
        "lib_materials:stone_castle_slate",
        mode,
        {
            description = S("Paving Slates"),
            tiles = {"unilib_roof_slate_castle.png"},
            groups = {cracky = 3, stone = 1},
            sounds = unilib.sound_table.stone,
        }
    )
    unilib.register_craft_2x2x4({
        -- Original to unilib
        output = "unilib:decor_paving_normal",
        ingredient = "unilib:roof_slate_normal",
    })
    -- N.B. no stairs in original code
    unilib.register_stairs("unilib:decor_paving_slate")

end
