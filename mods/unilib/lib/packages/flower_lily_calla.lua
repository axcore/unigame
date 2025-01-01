---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    valleys_c
-- Code:    GPL 3.0/BSD/WTFPL
-- Media:   GPL 3.0/BSD/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_lily_calla = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.valleys_c.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_lily_calla.init()

    return {
        description = "Calla lily",
    }

end

function unilib.pkg.flower_lily_calla.exec()

    unilib.register_node("unilib:flower_lily_calla", "valleys_c:calla_lily", mode, {
        -- From valleys_c:calla_lily
        description = unilib.utils.annotate(S("Calla Lily"), "Zantedeschia aethiopica"),
        tiles = {"unilib_flower_lily_calla.png"},
        groups = {
            attached_node = 1, color_white = 1, colour_white = 1, flammable = 2, flora = 1,
            flower = 1, snappy = 3,
        },
        sounds = unilib.global.sound_table.leaves,

        drawtype = "plantlike",
        inventory_image = "unilib_flower_lily_calla.png",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.5, -0.5, -0.5, 0.5, -0.3125, 0.5},
        },
        sunlight_propagates = true,
        walkable = false,
        waving = 1,
    })
    unilib.register_flower_in_pot("unilib:flower_lily_calla", "valleys_c:calla_lily")

    unilib.register_decoration_generic("valleys_c_flower_lily_calla", {
        -- From valleys_c, deco_plants.lua
        deco_type = "simple",
        decoration = "unilib:flower_lily_calla",

        noise_params = {
            octaves = 3,
            offset = -0.02,
            persist = 0.6,
            scale = 0.03,
            seed = 7985,
            spread = {x = 200, y = 200, z = 200},
        },
        sidelen = 16,
    })

end
