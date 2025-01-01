---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    valleys_c
-- Code:    GPL 3.0/BSD/WTFPL
-- Media:   GPL 3.0/BSD/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_bird_of_paradise = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.valleys_c.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_bird_of_paradise.init()

    return {
        description = "Bird of paradise",
    }

end

function unilib.pkg.flower_bird_of_paradise.exec()

    unilib.register_node("unilib:flower_bird_of_paradise", "valleys_c:bird_of_paradise", mode, {
        -- From valleys_c:bird_of_paradise
        description = unilib.utils.annotate(S("Bird of Paradise"), "Strelitzia reginae"),
        tiles = {"unilib_flower_bird_of_paradise.png"},
        -- N.B. Replaced original groups with standard flower groups
--      groups = {attached_node = 1, flammable = 2, flora = 1, flower = 1, snappy = 3},
        groups = {
            attached_node = 1, color_brown = 1, colour_brown = 1, flammable = 1, flora = 1,
            flower = 1, snappy = 3,
        },
        sounds = unilib.global.sound_table.leaves,

        drawtype = "plantlike",
        inventory_image = "unilib_flower_bird_of_paradise.png",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.5, -0.5, -0.5, 0.5, -0.3125, 0.5},
        },
        sunlight_propagates = true,
        walkable = false,
    })
    unilib.register_flower_in_pot("unilib:flower_bird_of_paradise", "valleys_c:bird_of_paradise")

    unilib.register_decoration_generic("valleys_c_flower_bird_of_paradise", {
        -- From valleys_c, deco_plants.lua
        deco_type = "simple",
        decoration = "unilib:flower_bird_of_paradise",

        noise_params = {
            octaves = 3,
            offset = -0.02,
            persist = 0.6,
            scale = 0.03,
            seed = 8402,
            spread = {x = 200, y = 200, z = 200},
        },
        sidelen = 16,
    })

end
