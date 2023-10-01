---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_australia_plant_honeypot_couch = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_australia_plant_honeypot_couch.init()

    return {
        description = "Couch honeypot as decoration",
        depends = {"biome_australia_jarrah_karri_forests", "dirt_ordinary", "plant_honeypot_couch"},
    }

end

function unilib.pkg.deco_australia_plant_honeypot_couch.exec()

    unilib.register_decoration_now("australia_plant_honeypot_couch", nil, {
        -- From australia:couch_honeypot
        biomes = "australia_jarrah_karri_forests",
        place_on = "unilib:dirt_ordinary_with_turf",
        -- (no max_y, min_y)
    })

end
