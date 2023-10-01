---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.decor_stone_tiles = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.decor_stone_tiles.init()

    return {
        description = "Old stone tiles",
        depends = "stone_ordinary",
        optional = "dirt_ordinary",
        suggested = {
            "moss_green",                       -- group:moss, group:moss_block
        },
    }

end

function unilib.pkg.decor_stone_tiles.exec()

    unilib.register_node("unilib:decor_stone_tiles", "decoblocks:old_stone_tiles", mode, {
        -- From farlands, decoblocks:old_stone_tiles
        description = S("Old Stone Tiles"),
        tiles = {"unilib_decor_stone_tiles.png"},
        groups = {cracky = 3, stone = 2},
        sounds = unilib.sound_table.stone,
    })
    unilib.register_craft({
        -- From farlands, decoblocks:old_stone_tiles
        output = "unilib:decor_stone_tiles 4",
        recipe = {
            {"unilib:stone_ordinary_block", "unilib:stone_ordinary_block"},
            {"unilib:stone_ordinary_block", "unilib:stone_ordinary_block"},
        },
    })

    if unilib.pkg_executed_table["dirt_ordinary"] ~= nil then

        unilib.register_node(
            -- From farlands, decoblocks:old_stone_tiles_with_dirt
            "unilib:decor_stone_tiles_with_dirt",
            "decoblocks:old_stone_tiles_with_dirt",
            mode,
            {
                description = S("Old Stone Tiles With Dirt"),
                tiles = {"unilib_decor_stone_tiles_with_dirt.png"},
                groups = {cracky = 3, stone = 2},
                sounds = unilib.sound_table.stone,
            }
        )
        unilib.register_craft({
            -- From farlands, decoblocks:old_stone_tiles_with_dirt
            type = "shapeless",
            output = "unilib:decor_stone_tiles_with_dirt 2",
            recipe = {
                "unilib:decor_stone_tiles",
                "unilib:dirt_ordinary",
                "unilib:decor_stone_tiles",
            },
        })

    end

    unilib.register_node(
        -- From farlands, decoblocks:moss_old_stone_tiles
        "unilib:decor_stone_tiles_with_moss",
        "decoblocks:moss_old_stone_tiles",
        mode,
        {
            description = S("Mossy Old Stone Tiles"),
            tiles = {"unilib_decor_stone_tiles_with_moss.png"},
            groups = {cracky = 3, stone = 2},
            sounds = unilib.sound_table.stone,
        }
    )
    unilib.register_craft({
        -- Original to unilib
        type = "shapeless",
        output = "unilib:decor_stone_tiles_with_moss 2",
        recipe = {
            "unilib:decor_stone_tiles",
            "group:moss",
            "unilib:decor_stone_tiles",
        },
    })
    unilib.register_craft({
        -- Original to unilib
        type = "shapeless",
        output = "unilib:decor_stone_tiles_with_moss 2",
        recipe = {
            "unilib:decor_stone_tiles",
            "group:moss_block",
            "unilib:decor_stone_tiles",
        },
    })

end
