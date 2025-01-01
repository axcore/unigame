---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xdecor
-- Code:    BSD
-- Media:   WTFPL/CC BY-SA/CC BY 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.decor_tiled_coal = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.xdecor.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.decor_tiled_coal.init()

    return {
        description = "Decorative coal tile",
        depends = {"mineral_coal", "stone_ordinary"},
    }

end

function unilib.pkg.decor_tiled_coal.exec()

    unilib.register_node("unilib:decor_tiled_coal", "xdecor:coalstone_tile", mode, {
        -- From xdecor:coalstone_tile
        description = S("Decorative Coal Tile"),
        tiles = {"unilib_decor_tiled_coal.png"},
        groups = {cracky = 1},
        sounds = unilib.global.sound_table.stone,

        -- N.B. is_ground_content = false not in original code; added to match other decor items
        is_ground_content = false,
        paramtype2 = "facedir",
    })
    unilib.register_craft({
        -- From xdecor:coalstone_tile
        output = "unilib:decor_tiled_coal 4",
        recipe = {
            {"unilib:mineral_coal_block", "unilib:stone_ordinary"},
            {"unilib:stone_ordinary", "unilib:mineral_coal_block"},
        },
    })

end
