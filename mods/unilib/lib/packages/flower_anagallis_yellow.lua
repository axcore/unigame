---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    herbs
-- Code:    GPL 3.0
-- Media:   GPL 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_anagallis_yellow = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.herbs.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_anagallis_yellow.init()

    return {
        description = "Yellow anagallis",
    }

end

function unilib.pkg.flower_anagallis_yellow.exec()

    unilib.register_node("unilib:flower_anagallis_yellow", "herbs:anagallis_yellow", mode, {
        -- From herbs:anagallis_yellow
        description = unilib.utils.annotate(S("Yellow Anagallis"), "Anagallis"),
        tiles = {"unilib_flower_anagallis_yellow.png"},
        groups = {
            attached_node = 1, color_yellow = 1, colour_yellow = 1, flammable = 1, flora = 1,
            flower = 1, snappy = 3,
        },
        sounds = unilib.global.sound_table.leaves,

        buildable_to = true,
        drawtype = "plantlike",
        inventory_image = "unilib_flower_anagallis_yellow.png",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-4 / 16, -0.5, -4 / 16, 4 / 16, 5 / 16, 4 / 16},
        },
        sunlight_propagates = true,
        walkable = false,
        waving = 1,
        wield_image = "unilib_flower_anagallis_yellow.png",
    })
    unilib.register_flower_in_pot("unilib:flower_anagallis_yellow", "herbs:anagallis_yellow")

    unilib.register_decoration_generic("herbs_flower_anagallis_yellow", {
        -- From herbs/mapgen.lua
        deco_type = "simple",
        decoration = "unilib:flower_anagallis_yellow",

        noise_params = {
            octaves = 3,
            offset = -0.02,
            persist = 0.6,
            scale = 0.04,
            seed = 3003485,
            spread = {x = 200, y = 200, z = 200},
        },
        sidelen = 16,
    })

end
