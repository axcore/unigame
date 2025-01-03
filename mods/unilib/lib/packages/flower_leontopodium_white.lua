---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    herbs
-- Code:    GPL 3.0
-- Media:   GPL 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_leontopodium_white = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.herbs.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_leontopodium_white.init()

    return {
        description = "White leontopodium",
    }

end

function unilib.pkg.flower_leontopodium_white.exec()

    unilib.register_node("unilib:flower_leontopodium_white", "herbs:leontopodium_white", mode, {
        -- From herbs:leontopodium_white
        description = unilib.utils.annotate(S("White Leontopodium"), "Leontopodium"),
        tiles = {"unilib_flower_leontopodium_white.png"},
        groups = {
            attached_node = 1, color_grey = 1, colour_grey = 1, flammable = 1, flora = 1,
            flower = 1, snappy = 3,
        },
        sounds = unilib.global.sound_table.leaves,

        buildable_to = true,
        drawtype = "plantlike",
        inventory_image = "unilib_flower_leontopodium_white.png",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-4 / 16, -0.5, -4 / 16, 4 / 16, 2 / 16, 4 / 16},
        },
        sunlight_propagates = true,
        walkable = false,
        waving = 1,
        wield_image = "unilib_flower_leontopodium_white.png",
    })
    unilib.register_flower_in_pot("unilib:flower_leontopodium_white", "herbs:leontopodium_white")

    unilib.register_decoration_generic("herbs_flower_leontopodium_white", {
        -- From herbs/mapgen.lua
        deco_type = "simple",
        decoration = "unilib:flower_leontopodium_white",

        noise_params = {
            octaves = 3,
            offset = -0.02,
            persist = 0.6,
            scale = 0.04,
            seed = 2204695,
            spread = {x = 200, y = 200, z = 200},
        },
        sidelen = 16,
    })

end
