---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_australia_plant_honeypot_couch = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_australia_plant_honeypot_couch.init()

    return {
        description = "Couch honeypot as decoration",
        depends = {"biome_australia_jarrah_karri_forests", "plant_honeypot_couch"},
        at_least_one = {"dirt_custom_antipodean", "dirt_ordinary"},
    }

end

function unilib.pkg.deco_australia_plant_honeypot_couch.post()

    unilib.register_decoration_complete("australia_plant_honeypot_couch", nil, {
        -- From australia:couch_honeypot
        biomes = "australia_jarrah_karri_forests",
        place_on = {
            "unilib:dirt_ordinary_with_turf",
            "unilib:dirt_antipodean_dark_with_turf_jarrah_karri_forests",
        },
        -- (no max_y, min_y)
    })

end
