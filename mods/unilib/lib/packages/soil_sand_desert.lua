---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.soil_sand_desert = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.soil_sand_desert.init()

    return {
        description = "Desert sand soil",
        depends = "sand_desert",
    }

end

function unilib.pkg.soil_sand_desert.exec()

    unilib.register_node("unilib:soil_sand_desert", "farming:desert_sand_soil", mode, {
        -- From farming:desert_sand_soil
        description = S("Desert Sand Soil"),
        tiles = {
            "unilib_soil_sand_desert.png",
            "unilib_sand_desert.png",
        },
        -- N.B. desert_soil = 1 not in original code. Note that desert = 1 is not used by unilib,
        --      but is retained for backwards compatibility
        groups = {
            crumbly = 3, desert = 1, desert_soil = 1, falling_node = 1, field = 1,
            not_in_creative_inventory = 1, sand = 1, soil = 2,
        },
        sounds = unilib.sound_table.sand,

        drop = "unili:sand_desert",
        soil = {
            base = "unilib:sand_desert",
            dry = "unilib:soil_sand_desert",
            wet = "unilib:soil_sand_desert_wet"
        }
    })

    unilib.register_node("unilib:soil_sand_desert_wet", "farming:desert_sand_soil_wet", mode, {
        -- From farming:desert_sand_soil_wet
        description = S("Wet Desert Sand Soil"),
        tiles = {"unilib_soil_sand_desert_wet.png", "unilib_soil_sand_desert_wet_side.png"},
        -- N.B. desert_soil = 1 not in original code. Note that desert = 1 is not used by unilib,
        --      but is retained for backwards compatibility
        groups = {
            crumbly = 3, desert = 1, desert_soil = 1, falling_node = 1 , field = 1,
            not_in_creative_inventory = 1, sand = 1, soil = 3, wet = 1,
        },
        sounds = unilib.sound_table.sand,

        drop = "unili:sand_desert",
        soil = {
            base = "unilib:sand_desert",
            dry = "unilib:soil_sand_desert",
            wet = "unilib:soil_sand_desert_wet"
        }
    })

end
