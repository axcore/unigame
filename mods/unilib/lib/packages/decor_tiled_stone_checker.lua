---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    moreblocks
-- Code:    zlib
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.decor_tiled_stone_checker = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.moreblocks.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.decor_tiled_stone_checker.init()

    return {
        description = "Decorative checkered stone tile",
        depends = {"decor_tiled_stone_split", "stone_ordinary"},
    }

end

function unilib.pkg.decor_tiled_stone_checker.exec()

    unilib.register_node(
        -- From moreblocks:checker_stone_tile
        "unilib:decor_tiled_stone_checker",
        "moreblocks:checker_stone_tile",
        mode,
        {
            description = S("Decorative Checkered Stone Tile"),
            tiles = {"unilib_decor_tiled_stone_checker.png"},
            groups = {cracky = 3, stone = 1},
            sounds = unilib.sound_table.stone,

            is_ground_content = false,
        }
    )
    unilib.register_craft({
        -- From moreblocks:checker_stone_tile
        output = "unilib:decor_tiled_stone_checker",
        recipe = {
            {"unilib:decor_tiled_stone_split"},
        }
    })
    -- Notes from moreblocks:
    -- When approaching the craft below, loop back to ordinary cobblestone, which can then be used
    --      to craft stone tiles again
    unilib.register_craft({
        -- From moreblocks:checker_stone_tile
        output = "unilib:stone_ordinary_cobble",
        recipe = {
            {"unilib:decor_tiled_stone_checker"},
        }
    })
    unilib.register_stairs("unilib:decor_tiled_stone_checker")

end
