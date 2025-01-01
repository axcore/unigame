---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    valleys_c
-- Code:    GPL 3.0/BSD/WTFPL
-- Media:   GPL 3.0/BSD/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_hibiscus = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.valleys_c.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_hibiscus.init()

    return {
        description = "Hibiscus",
    }

end

function unilib.pkg.flower_hibiscus.exec()

    unilib.register_node("unilib:flower_hibiscus", "valleys_c:hibiscus", mode, {
        -- From valleys_c:hibiscus
        description = unilib.utils.annotate(S("Hibiscus"), "Hibiscus"),
        tiles = {"unilib_flower_hibiscus.png"},
        groups = {
            attached_node = 1, color_white = 1, colour_white = 1, flammable = 2, flora = 1,
            flower = 1, snappy = 3,
        },
        sounds = unilib.global.sound_table.leaves,

        drawtype = "plantlike",
        inventory_image = "unilib_flower_hibiscus.png",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.5, -0.5, -0.5, 0.5, -0.3125, 0.5},
        },
        walkable = false,
        waving = 1,
    })
    unilib.register_flower_in_pot("unilib:flower_hibiscus", "valleys_c:hibiscus")

    unilib.register_decoration_generic("valleys_c_flower_hibiscus", {
        -- From valleys_c, deco_plants.lua
        deco_type = "simple",
        decoration = "unilib:flower_hibiscus",

        noise_params = {
            octaves = 3,
            offset = -0.02,
            persist = 0.6,
            scale = 0.03,
            seed = 7831,
            spread = {x = 200, y = 200, z = 200},
        },
        sidelen = 16,
    })

end
