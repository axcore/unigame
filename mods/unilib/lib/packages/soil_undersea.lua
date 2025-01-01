---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aqua_farming
-- Code:    GPL 3.0
-- Media:   CC-BY-3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.soil_undersea = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.aqua_farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.soil_undersea.init()

    return {
        description = "Undersea soil",
        notes = "Can be used to grow undersea crops. Does not occur naturally; must be crafted",
                " then placed in a suitable underwater location",
        depends = {"gravel_ordinary", "sand_silver"},
    }

end

function unilib.pkg.soil_undersea.exec()

    unilib.register_node("unilib:soil_undersea", "aqua_farming:water_soil", mode, {
        -- From aqua_farming:water_soil
        description = S("Undersea Soil"),
        -- N.B. In the original code, the soil and the first crop growth stage looked identical;
        --      here we distinguish them with two separate textures
        tiles = {"unilib_soil_undersea.png"},
        groups = {crumbly = 3, falling_node = 1, sand = 1},
        sounds = unilib.global.sound_table.sand,

        drop = "unilib:sand_silver",
    })
    unilib.register_craft({
        -- From aqua_farming:water_soil
        output = "unilib:soil_undersea 2",
        recipe = {
            {"unilib:gravel_ordinary", "group:seafood", "group:sand"},
        },
    })

end
