---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    moreblocks
-- Code:    zlib
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.decor_tiled_stone = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.moreblocks.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.decor_tiled_stone.init()

    return {
        description = "Decorative stone tile",
        depends = "stone_ordinary",
    }

end

function unilib.pkg.decor_tiled_stone.exec()

    local c_cobble = "unilib:stone_ordinary_cobble"

    unilib.register_node("unilib:decor_tiled_stone", "moreblocks:stone_tile", mode, {
        -- From moreblocks:stone_tile
        description = S("Decorative Stone Tile"),
        tiles = {"unilib_decor_tiled_stone.png"},
        groups = {cracky = 3, stone = 1},
        sounds = unilib.sound_table.stone,

        is_ground_content = false,
    })
    unilib.register_craft({
        -- From moreblocks:stone_tile
        output = "unilib:decor_tiled_stone 9",
        recipe = {
            {c_cobble, c_cobble, c_cobble},
            {c_cobble, "unilib:stone_ordinary", c_cobble},
            {c_cobble, c_cobble, c_cobble},
        }
    })
    unilib.register_stairs("unilib:decor_tiled_stone")

end
