---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.soil_ordinary = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.soil_ordinary.init()

    return {
        description = "Ordinary soil",
        depends = "dirt_ordinary",
    }

end

function unilib.pkg.soil_ordinary.exec()

    unilib.register_node("unilib:soil_ordinary", "farming:soil", mode, {
        -- From farming:soil
        description = S("Ordinary Soil"),
        tiles = {
            "unilib_dirt_ordinary.png^unilib_soil_overlay.png",
            "unilib_dirt_ordinary.png",
        },
        -- N.B. ordinary_soil = 1 not in original code. Note that grassland = 1 is not used by
        --      unilib, but is retained for backwards compatibility
        groups = {
            crumbly = 3, field = 1, grassland = 1, not_in_creative_inventory = 1,
            ordinary_soil = 1, soil = 2,
        },
        sounds = unilib.sound_table.dirt,

        drop = "unilib:dirt_ordinary",
        soil = {
            base = "unilib:dirt_ordinary",
            dry = "unilib:soil_ordinary",
            wet = "unilib:soil_ordinary_wet"
        }
    })

    unilib.register_node("unilib:soil_ordinary_wet", "farming:soil_wet", mode, {
        -- From farming:soil_wet
        description = S("Wet Ordinary Soil"),
        tiles = {
            "unilib_dirt_ordinary.png^unilib_soil_wet_overlay.png",
            "unilib_dirt_ordinary.png^unilib_soil_wet_side_overlay.png",
        },
        -- N.B. ordinary_soil = 1 not in original code. Note that grassland = 1 is not used by
        --      unilib, but is retained for backwards compatibility
        groups = {
            crumbly = 3, field = 1, grassland = 1, not_in_creative_inventory = 1,
            ordinary_soil = 1, soil = 3, wet = 1,
        },
        sounds = unilib.sound_table.dirt,

        drop = "unilib:dirt_ordinary",
        soil = {
            base = "unilib:dirt_ordinary",
            dry = "unilib:soil_ordinary",
            wet = "unilib:soil_ordinary_wet"
        }
    })

end
