---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    beautiflowers
-- Code:    GPLv3.0
-- Media:   CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_beautiflowers_plant_shrub_bonsai = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.beautiflowers.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_beautiflowers_plant_shrub_bonsai.init()

    return {
        description = "Bonsai tree as decoration",
        depends = {"plant_shrub_bonsai", "stone_ordinary"},
    }

end

function unilib.pkg.deco_beautiflowers_plant_shrub_bonsai.post()

    for i = 1, 5 do

        unilib.register_decoration_complete(
            -- From beautiflowers/spawn.lua
            -- Completes decoration in package "plant_shrub_bonsai"
            "beautiflowers_plant_shrub_bonsaid_" .. tostring(i),
            nil,
            {
                place_on = {
                    "unilib:stone_ordinary",
                    "unilib:stone_ordinary_cobble",
                    "unilib:stone_ordinary_cobble_mossy",
                },
                y_max = 30000,
                y_min = 30,
            }
        )

    end

end
