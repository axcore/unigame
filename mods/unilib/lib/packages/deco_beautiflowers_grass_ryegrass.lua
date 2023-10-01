---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    beautiflowers
-- Code:    GPLv3.0
-- Media:   CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_beautiflowers_grass_ryegrass = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.beautiflowers.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_beautiflowers_grass_ryegrass.init()

    return {
        description = "Ryegrass as decoration",
        depends = {"dirt_ordinary", "grass_ryegrass"},
    }

end

function unilib.pkg.deco_beautiflowers_grass_ryegrass.post()

    for i = 1, 10 do

        unilib.register_decoration_now("beautiflowers_grass_ryegrass_" .. tostring(i), nil, {
            -- From beautiflowers/spawn.lua
            -- Completes decoration in package "grass_ryegrass"
            place_on = {"unilib:dirt_ordinary", "unilib:dirt_ordinary_with_turf"},
            spawn_by = "unilib:dirt_ordinary_with_turf",
            y_max = 30000,
            y_min = 1,
        })

    end

end
