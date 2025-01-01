---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    castle/castle_masonry
-- Code:    MIT
-- Media:   CC-BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.decor_stone_castle_dungeon = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.castle_masonry.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.decor_stone_castle_dungeon.init()

    return {
        description = "Castle dungeon stone",
        depends = {"stone_obsidian", "stone_ordinary"},
    }

end

function unilib.pkg.decor_stone_castle_dungeon.exec()

    unilib.register_node(
        -- From castle_masonry:dungeon_stone
        "unilib:decor_stone_castle_dungeon",
        "castle_masonry:dungeon_stone",
        mode,
        {
            description = S("Castle Dungeon Stone"),
            tiles = {"unilib_decor_stone_castle_dungeon.png"},
            groups = {cracky = 2},
            sounds = unilib.global.sound_table.stone,

            drawtype = "normal",
            -- N.B. is_ground_content = false not in original code; added to match other decor items
            is_ground_content = false,
            paramtype = "light",
        }
    )
    unilib.register_craft({
        -- From castle_masonry:dungeon_stone
        output = "unilib:decor_stone_castle_dungeon 2",
        recipe = {
            {"unilib:stone_ordinary_brick", "unilib:stone_obsidian"},
        },
    })
    unilib.register_craft({
        -- From castle_masonry:dungeon_stone
        output = "unilib:decor_stone_castle_dungeon 2",
        recipe = {
            {"unilib:stone_ordinary_brick"},
            {"unilib:stone_obsidian"},
        },
    })
    unilib.register_stairs("unilib:decor_stone_castle_dungeon")

end
