---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    valleys_c
-- Code:    GPL 3.0/BSD/WTFPL
-- Media:   GPL 3.0/BSD/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_orchid = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.valleys_c.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_orchid.init()

    return {
        description = "Orchid",
    }

end

function unilib.pkg.flower_orchid.exec()

    unilib.register_node("unilib:flower_orchid", "valleys_c:orchid", mode, {
        -- From valleys_c:orchid
        description = unilib.annotate(S("Orchid"), "Orchis"),
        tiles = {"unilib_flower_orchid.png"},
        groups = {
            attached_node = 1, color_white = 1, flammable = 2, flora = 1, flower = 1, snappy = 3,
        },
        sounds = unilib.sound_table.leaves,

        drawtype = "plantlike",
        inventory_image = "unilib_flower_orchid.png",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.5, -0.5, -0.5, 0.5, -0.3125, 0.5},
        },
        sunlight_propagates = true,
        walkable = false,
        waving = 1,
    })
    unilib.register_flower_in_pot("unilib:flower_orchid", "valleys_c:orchid")

    unilib.register_decoration("valleys_c_flower_orchid", {
        -- From valleys_c, deco_plants.lua
        deco_type = "simple",
        decoration = "unilib:flower_orchid",

        noise_params = {
            octaves = 3,
            offset = -0.02,
            persist = 0.6,
            scale = 0.03,
            seed = 3944,
            spread = {x = 200, y = 200, z = 200},
        },
        sidelen = 16,
    })

end
