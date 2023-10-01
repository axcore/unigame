---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xdecor
-- Code:    BSD
-- Media:   WTFPL/CC BY-SA/CC BY 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.decor_tiled_wood_jointed = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.xdecor.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.decor_tiled_wood_jointed.init()

    return {
        description = "Decorative jointed wood tile",
    }

end

function unilib.pkg.decor_tiled_wood_jointed.exec()

    unilib.register_node("unilib:decor_tiled_wood_jointed", "xdecor:wood_tile", mode, {
        -- From xdecor:wood_tile
        description = S("Decorative Jointed Wood Tile"),
        tiles = {"unilib_decor_tiled_wood_jointed.png"},
        groups = {choppy = 1, flammable = 2, wood = 1},
        sounds = unilib.sound_table.wood,

        paramtype2 = "facedir",
    })
    unilib.register_craft({
        -- From xdecor:wood_tile
        output = "unilib:decor_tiled_wood_jointed 2",
        recipe = {
            {"", "group:wood", ""},
            {"group:wood", "", "group:wood"},
            {"", "group:wood", ""}
        }
    })

end
