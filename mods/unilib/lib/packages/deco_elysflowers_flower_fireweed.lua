---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    elysflowers
-- Code:    GPL-3.0-or-later
-- Media:   CC-BY-4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_elysflowers_flower_fireweed = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.elysflowers.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_elysflowers_flower_fireweed.init()

    return {
        description = "Fireweed as decoration",
        depends = "biome_elysflowers_taiga_valley",
        at_least_one = {
            {"dirt_ordinary_with_litter_coniferous", "dirt_ordinary_with_turf"},
        },
    }

end

function unilib.pkg.deco_elysflowers_flower_fireweed.post()

    for i = 1, 4 do

        unilib.register_decoration_complete("elysflowers_flower_fireweed_" .. i, nil, {
            -- From elysflowers/init.lua
            -- Completes decoration in package "flower_fireweed"
            biomes = "elysflowers_taiga_valley",
            num_spawn_by = -1,
            place_on = {
                "unilib:dirt_ordinary_with_litter_coniferous",
                "unilib:dirt_ordinary_with_turf",
            },
            -- (no spawn_by)
            y_max = unilib.constant.y_max,
            y_min = 1,
        })

    end

end
