---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    herbs
-- Code:    GPL 3.0
-- Media:   GPL 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_digitalis_yellow = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.herbs.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_digitalis_yellow.init()

    return {
        description = "Yellow digitalis",
    }

end

function unilib.pkg.flower_digitalis_yellow.exec()

    unilib.register_node("unilib:flower_digitalis_yellow", "herbs:digitalis_yellow", mode, {
        -- From herbs:digitalis_yellow
        description = unilib.annotate(S("Yellow Digitalis"), "Digitalis"),
        tiles = {"unilib_flower_digitalis_yellow.png"},
        groups = {
            attached_node = 1, color_yellow = 1, flammable = 1, flora = 1, flower = 1, snappy = 3,
        },
        sounds = unilib.sound_table.leaves,

        buildable_to = true,
        drawtype = "plantlike",
        inventory_image = "unilib_flower_digitalis_yellow.png",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-2 / 16, -0.5, -2 / 16, 2 / 16, 5 / 16, 2 / 16},
        },
        sunlight_propagates = true,
        walkable = false,
        waving = 1,
        wield_image = "unilib_flower_digitalis_yellow.png",
    })
    unilib.register_flower_in_pot("unilib:flower_digitalis_yellow", "herbs:digitalis_yellow")

    unilib.register_decoration("herbs_flower_digitalis_yellow", {
        -- From herbs/mapgen.lua
        deco_type = "simple",
        decoration = "unilib:flower_digitalis_yellow",

        noise_params = {
            octaves = 3,
            offset = -0.02,
            persist = 0.6,
            scale = 0.04,
            seed = 7245998,
            spread = {x = 200, y = 200, z = 200},
        },
        sidelen = 16,
    })

end
