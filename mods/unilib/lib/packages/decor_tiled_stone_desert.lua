---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xdecor
-- Code:    BSD
-- Media:   WTFPL/CC BY-SA/CC BY 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.decor_tiled_stone_desert = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.xdecor.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.decor_tiled_stone_desert.init()

    return {
        description = "Decorative desert stone tile",
        depends = "stone_desert",
    }

end

function unilib.pkg.decor_tiled_stone_desert.exec()

    local c_cobble = "unilib:stone_desert_cobble"

    unilib.register_node("unilib:decor_tiled_stone_desert", "xdecor:desertstone_tile", mode, {
        -- From xdecor:coalstone_tile
        description = S("Decorative Desert Stone Tile"),
        tiles = {"unilib_decor_tiled_stone_desert.png"},
        groups = {cracky = 1},
        sounds = unilib.global.sound_table.stone,

        -- N.B. is_ground_content = false not in original code; added to match other decor items
        is_ground_content = false,
        paramtype2 = "facedir",
    })
    unilib.register_craft({
        -- Original to unilib, to match the recipe in the "decor_tiled_stone" package (and
        --      superseding the recipe provided by xdecor)
        output = "unilib:decor_tiled_stone_desert 9",
        recipe = {
            {c_cobble, c_cobble, c_cobble},
            {c_cobble, "unilib:stone_desert", c_cobble},
            {c_cobble, c_cobble, c_cobble},
        },
    })

end
