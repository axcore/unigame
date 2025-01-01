---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    herbs
-- Code:    GPL 3.0
-- Media:   GPL 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_antirrhinum = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.herbs.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_antirrhinum.init()

    return {
        description = "Antirrhinum",
    }

end

function unilib.pkg.flower_antirrhinum.exec()

    unilib.register_node("unilib:flower_antirrhinum", "herbs:antirrhinum", mode, {
        -- From herbs:antirrhinum
        description = unilib.utils.annotate(S("Antirrhinum"), "Antirrhinum"),
        tiles = {"unilib_flower_antirrhinum.png"},
        groups = {
            attached_node = 1, color_pink = 1, colour_pink = 1, flammable = 1, flora = 1,
            flower = 1, snappy = 3,
        },
        sounds = unilib.global.sound_table.leaves,

        buildable_to = true,
        drawtype = "plantlike",
        inventory_image = "unilib_flower_antirrhinum.png",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-2 / 16, -0.5, -2 / 16, 2 / 16, 5 / 16, 2 / 16},
        },
        sunlight_propagates = true,
        walkable = false,
        waving = 1,
        wield_image = "unilib_flower_antirrhinum.png",
    })
    unilib.register_flower_in_pot("unilib:flower_antirrhinum", "herbs:antirrhinum")

    unilib.register_decoration_generic("herbs_flower_antirrhinum", {
        -- From herbs/mapgen.lua
        deco_type = "simple",
        decoration = "unilib:flower_antirrhinum",

        noise_params = {
            octaves = 3,
            offset = -0.02,
            persist = 0.6,
            scale = 0.04,
            seed = 7810530,
            spread = {x = 200, y = 200, z = 200},
        },
        sidelen = 16,
    })

end
