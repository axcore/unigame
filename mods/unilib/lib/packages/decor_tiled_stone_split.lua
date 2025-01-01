---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    moreblocks
-- Code:    zlib
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.decor_tiled_stone_split = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.moreblocks.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.decor_tiled_stone_split.init()

    return {
        description = "Decorative ordinary stone split tile",
        depends = "decor_tiled_stone",
    }

end

function unilib.pkg.decor_tiled_stone_split.exec()

    unilib.register_node(
        -- From moreblocks:split_stone_tile
        "unilib:decor_tiled_stone_split",
        "moreblocks:split_stone_tile",
        mode,
        {
            description = S("Decorative Ordinary Stone Split Tile"),
            tiles = {
                "unilib_decor_tiled_stone_split_top.png",
                "unilib_decor_tiled_stone_split.png",
            },
            groups = {cracky = 3, stone = 1},
            sounds = unilib.global.sound_table.stone,

            is_ground_content = false,
            paramtype2 = "facedir",
            place_param2 = 0,
        }
    )
    unilib.register_craft({
        -- From moreblocks:split_stone_tile
        output = "unilib:decor_tiled_stone_split",
        recipe = {
            {"unilib:decor_tiled_stone"},
        },
    })
    unilib.register_stairs("unilib:decor_tiled_stone_split")

end
