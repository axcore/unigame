---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    valleys_c
-- Code:    GPL 3.0/BSD/WTFPL
-- Media:   GPL 3.0/BSD/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_gerbera = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.valleys_c.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_gerbera.init()

    return {
        description = "Gerbera",
    }

end

function unilib.pkg.flower_gerbera.exec()

    unilib.register_node("unilib:flower_gerbera", "valleys_c:gerbera", mode, {
        -- From valleys_c:gerbera
        description = unilib.utils.annotate(S("Gerbera"), "Gerbera"),
        tiles = {"unilib_flower_gerbera.png"},
        -- N.B. flammable = 2 in original code
        groups = {
            attached_node = 1, color_pink = 1, colour_pink = 1, flammable = 1, flora = 1,
            flower = 1, snappy = 3,
        },
        sounds = unilib.global.sound_table.leaves,

        drawtype = "plantlike",
        inventory_image = "unilib_flower_gerbera.png",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.5, -0.5, -0.5, 0.5, -0.3125, 0.5},
        },
        sunlight_propagates = true,
        walkable = false,
    })
    unilib.register_flower_in_pot("unilib:flower_gerbera", "valleys_c:gerbera")

    unilib.register_decoration_generic("valleys_c_flower_gerbera", {
        -- From valleys_c, deco_plants.lua
        deco_type = "simple",
        decoration = "unilib:flower_gerbera",

        noise_params = {
            octaves = 3,
            offset = -0.02,
            persist = 0.6,
            scale = 0.03,
            seed = 1976,
            spread = {x = 200, y = 200, z = 200},
        },
        sidelen = 16,
    })

end
