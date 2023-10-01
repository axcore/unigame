---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    castle/castle_masonry
-- Code:    MIT
-- Media:   CC-BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.decor_stone_castle_wall = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.castle_masonry.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.decor_stone_castle_wall.init()

    return {
        description = "Castle wall",
        depends = {"stone_desert", "stone_ordinary"},
    }

end

function unilib.pkg.decor_stone_castle_wall.exec()

    unilib.register_node("unilib:decor_stone_castle_wall", "castle_masonry:stonewall", mode, {
        -- From castle_masonry:stonewall
        description = S("Castle Wall"),
        tiles = {"unilib_decor_stone_castle_wall.png"},
        groups = {cracky = 3},
        sounds = unilib.sound_table.stone,

        drawtype = "normal",
        drop = "unilib:decor_stone_castle_wall",
        paramtype = "light",
        sunlight_propagates = false,
    })
    unilib.register_craft({
        -- From castle_masonry:stonewall
        output = "unilib:decor_stone_castle_wall",
        recipe = {
            {"unilib:stone_ordinary_cobble"},
            {"unilib:stone_desert"},
        },
    })
    unilib.register_stairs("unilib:decor_stone_castle_wall")

end
