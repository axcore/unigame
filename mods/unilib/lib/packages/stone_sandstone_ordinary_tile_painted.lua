---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_sandstone_ordinary_tile_painted = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_sandstone_ordinary_tile_painted.init()

    return {
        description = "Ordinary sandstone painted tile",
        depends = {"dye_basic", "stone_sandstone_ordinary"},
    }

end

function unilib.pkg.stone_sandstone_ordinary_tile_painted.exec()

    unilib.register_node(
        -- From farlands, decoblocks:painted_sandstone_tile
        "unilib:stone_sandstone_ordinary_tile_painted",
        "decoblocks:painted_sandstone_tile",
        mode,
        {
            description = S("Painted Ordinary Sandstone Tile"),
            tiles = {"unilib_stone_sandstone_ordinary.png^unilib_stone_tile_floor_overlay.png"},
            groups = {cracky = 3, stone = 2},
            sounds = unilib.global.sound_table.stone,

            -- N.B. is_ground_content = false not in original code
            is_ground_content = false,
            paramtype2 = "facedir",
        }
    )
    unilib.register_craft({
        -- Original to unilib
        type = "shapeless",
        output = "unilib:stone_sandstone_ordinary_tile_painted",
        recipe = {"unilib:stone_sandstone_ordinary", "unilib:dye_orange", "unilib:dye_white"},
    })

end
