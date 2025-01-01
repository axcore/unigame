---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    plants
-- Code:    WTFPL
-- Media:   WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_crocus_autumn = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.plants.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_crocus_autumn.init()

    return {
        description = "Autumn crocus",
    }

end

function unilib.pkg.flower_crocus_autumn.exec()

    unilib.register_node("unilib:flower_crocus_autumn", "plants:colchicum_wild", mode, {
        -- From plants:colchicum_wild
        description = unilib.utils.annotate(S("Autumn Crocus"), "Colchicum autumnale"),
        tiles = {"unilib_flower_crocus_autumn.png"},
        -- N.B. Replaced original groups with standard flower groups
--      groups = {attached_node = 1, flammable = 2, snappy = 3},
        groups = {
            attached_node = 1, color_violet = 1, colour_violet = 1, flammable = 1, flora = 1,
            flower = 1, snappy = 3,
        },
        sounds = unilib.global.sound_table.leaves,

        buildable_to = true,
        drawtype = "plantlike",
        inventory_image = "unilib_flower_crocus_autumn.png",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.25, -0.5, -0.25, 0.25, -3/16, 0.25},
        },
        sunlight_propagates = true,
        visual_scale = 1.3,
        walkable = false,
    })
    unilib.register_flower_in_pot("unilib:flower_crocus_autumn", "plants:colchicum_wild")

    unilib.register_decoration_generic("plants_flower_crocus_autumn", {
        -- Original to unilib, based on decorations in the "flowers" mod
        deco_type = "simple",
        decoration = "unilib:flower_crocus_autumn",

        noise_params = {
            octaves = 3,
            offset = -0.02,
            persist = 0.6,
            scale = 0.04,
            seed = 24716,      -- New random seed, generated for unilib
            spread = {x = 200, y = 200, z = 200},
        },
        sidelen = 16,
    })

end
