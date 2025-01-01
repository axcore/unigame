---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    castle/castle_masonry
-- Code:    MIT
-- Media:   CC-BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.decor_paving_normal = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.castle_masonry.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.decor_paving_normal.init()

    return {
        description = "Normal paving stone",
        depends = "stone_ordinary",
    }

end

function unilib.pkg.decor_paving_normal.exec()

    unilib.register_node(
        -- From castle_masonry:pavement_brick
        "unilib:decor_paving_normal",
        "castle_masonry:pavement_brick",
        mode,
        {
            description = S("Normal Paving Stone"),
            tiles = {"unilib_decor_paving_normal.png"},
            groups = {cracky = 2},
            sounds = unilib.global.sound_table.stone,

            drawtype = "normal",
            -- N.B. is_ground_content = false not in original code; added to match other decor items
            is_ground_content = false,
            paramtype = "light",
        }
    )
    unilib.register_craft({
        -- From castle_masonry:pavement_brick
        output = "unilib:decor_paving_normal 4",
        recipe = {
            {"unilib:stone_ordinary", "unilib:stone_ordinary_cobble"},
            {"unilib:stone_ordinary_cobble", "unilib:stone_ordinary"},
        },
    })
    -- N.B. Added a mirror recipe, because "unilib:roof_slate_castle" has one
    unilib.register_craft({
        -- Original to unilib
        output = "unilib:decor_paving_normal 4",
        recipe = {
            {"unilib:stone_ordinary_cobble", "unilib:stone_ordinary"},
            {"unilib:stone_ordinary", "unilib:stone_ordinary_cobble"},
        },
    })
    unilib.register_stairs("unilib:decor_paving_normal")

end
