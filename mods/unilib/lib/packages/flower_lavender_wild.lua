---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    plants
-- Code:    WTFPL
-- Media:   WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_lavender_wild = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.plants.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_lavender_wild.init()

    return {
        description = "Wild lavender",
    }

end

function unilib.pkg.flower_lavender_wild.exec()

    unilib.register_node("unilib:flower_lavender_wild", "plants:lavender_wild", mode, {
        -- From plants:lavender_wild
        description = unilib.annotate(S("Wild Lavender"), "Lavandula"),
        tiles = {"unilib_flower_lavender_wild.png"},
        -- N.B. Replaced original groups with standard flower groups
--      groups = {attached_node = 1, flammable = 2, snappy = 3},
        groups = {
            attached_node = 1, color_violet = 1, flammable = 1, flora = 1, flower = 1, snappy = 3,
        },
        sounds = unilib.sound_table.leaves,

        buildable_to = true,
        drawtype = "plantlike",
        inventory_image = "unilib_flower_lavender_wild.png",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.25, -0.5, -0.25, 0.25, -3/16, 0.25},
        },
        sunlight_propagates = true,
        visual_scale = 1.3,
        walkable = false,
    })
    unilib.register_flower_in_pot("unilib:flower_lavender_wild", "plants:lavender_wild")

    unilib.register_decoration("plants_flower_lavender_wild", {
        -- Original to unilib, based on decorations in the "flowers" mod
        deco_type = "simple",
        decoration = "unilib:flower_lavender_wild",

        noise_params = {
            octaves = 3,
            offset = -0.02,
            persist = 0.6,
            scale = 0.04,
            seed = 23483,      -- New random seed, generated for unilib
            spread = {x = 200, y = 200, z = 200},
        },
        sidelen = 16,
    })

end
