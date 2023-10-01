---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    castle/castle_masonry
-- Code:    MIT
-- Media:   CC-BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.decor_stone_castle_corner = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.castle_masonry.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.decor_stone_castle_corner.init()

    return {
        description = "Castle wall corner",
        depends = {"decor_stone_castle_wall", "stone_sandstone_ordinary"},
    }

end

function unilib.pkg.decor_stone_castle_corner.exec()

    unilib.register_node(
        -- From castle_masonry:stonewall_corner
        "unilib:decor_stone_castle_corner",
        "castle_masonry:stonewall_corner",
        mode,
        {
            description = S("Castle Wall Corner"),
            tiles = {
                "unilib_decor_stone_castle_corner_3.png^[transformR90",
                "unilib_decor_stone_castle_corner_3.png^[transformR180",
                "unilib_decor_stone_castle_corner_1.png",
                "unilib_decor_stone_castle_wall.png",
                "unilib_decor_stone_castle_wall.png",
                "unilib_decor_stone_castle_corner_2.png",
            },
            groups = {cracky = 3},
            sounds = unilib.sound_table.stone,

            drawtype = "normal",
            paramtype = "light",
            paramtype2 = "facedir",
        }
    )
    unilib.register_craft({
        -- From castle_masonry:stonewall_corner
        output = "unilib:decor_stone_castle_corner",
        recipe = {
            {"", "unilib:decor_stone_castle_wall"},
            {"unilib:decor_stone_castle_wall", "unilib:stone_sandstone_ordinary"},
        }
    })

end
