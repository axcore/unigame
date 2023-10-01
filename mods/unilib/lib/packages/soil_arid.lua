---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.soil_arid = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.soil_arid.init()

    return {
        description = "Arid soil",
        depends = "dirt_dry",
    }

end

function unilib.pkg.soil_arid.exec()

    unilib.register_node("unilib:soil_arid", "farming:dry_soil", mode, {
        -- From farming:dry_soil
        description = S("Arid Soil"),
        tiles = {
            "unilib_dirt_dry.png^unilib_soil_overlay.png",
            "unilib_dirt_dry.png",
        },
        -- N.B. arid_soil = 1 not in original code. Note that savanna = 1 is not used by unilib,
        --      but is retained for compatibility
        groups = {
            arid_soil = 1, crumbly = 3, field = 1, not_in_creative_inventory = 1, savanna = 1,
            soil = 2,
        },
        sounds = unilib.sound_table.dirt,

        drop = "unilib:dirt_dry",
        soil = {
            base = "unilib:dirt_dry",
            dry = "unilib:soil_arid",
            wet = "unilib:soil_arid_wet",
        }
    })

    unilib.register_node("unilib:soil_arid_wet", "farming:dry_soil_wet", mode, {
        -- From farming:dry_soil_wet
        description = S("Wet Arid Soil"),
        tiles = {
            "unilib_dirt_dry.png^unilib_soil_wet_overlay.png",
            "unilib_dirt_dry.png^unilib_soil_wet_side_overlay.png",
        },
        -- N.B. arid_soil = 1 not in original code. Note that savanna = 1 is not used by unilib,
        --      but is retained for compatibility
        groups = {
            arid_soil = 1, crumbly = 3, field = 1, not_in_creative_inventory = 1, savanna = 1,
            soil = 3, wet = 1,
        },
        sounds = unilib.sound_table.dirt,

        drop = "unilib:dirt_dry",
        soil = {
            base = "unilib:dirt_dry",
            dry = "unilib:soil_arid",
            wet = "unilib:soil_arid_wet",
        }
    })

end
