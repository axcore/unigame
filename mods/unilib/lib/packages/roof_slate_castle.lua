---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    castle/castle_masonry
-- Code:    MIT
-- Media:   CC-BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.roof_slate_castle = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.castle_masonry.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.roof_slate_castle.init()

    return {
        description = "Castle roofing slates",
        depends = {"decor_block_tar", "gravel_ordinary"},
    }

end

function unilib.pkg.roof_slate_castle.exec()

    unilib.register_node("unilib:roof_slate_castle", "castle_masonry:roofslate", mode, {
        -- From castle_masonry:roofslate
        description = S("Castle Roofing Slates"),
        tiles = {"unilib_roof_slate_castle.png"},
        groups = {attached_node = 1, cracky = 3},
        -- N.B. glass in original code
        sounds = unilib.sound_table.stone,

        climbable = true,
        drawtype = "raillike",
        inventory_image = "unilib_roof_slate_castle.png",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-1/2, -1/2, -1/2, 1/2, -1/2 + 1/16, 1/2},
        },
        walkable = false,
    })
    -- N.B. original code uses tar from homedecor/building_blocks
    unilib.register_craft({
        -- From castle_masonry:roofslate
        output = "unilib:roof_slate_castle 4",
        recipe = {
            {"unilib:decor_block_tar", "unilib:gravel_ordinary"},
            {"unilib:gravel_ordinary", "unilib:decor_block_tar"},
        },
    })
    unilib.register_craft( {
        -- From castle_masonry:roofslate
        output = "unilib:roof_slate_castle 4",
        recipe = {
            {"unilib:gravel_ordinary", "unilib:decor_block_tar"},
            {"unilib:decor_block_tar", "unilib:gravel_ordinary"},
        },
    })

end
