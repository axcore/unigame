---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    plantlife/cavestuff
-- Code:    LGPL v3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_cavestuff_pebble_large_stone_ordinary = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.cavestuff.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_cavestuff_pebble_large_stone_ordinary.init()

    return {
        description = "Large ordinary stone pebble as decoration",
        depends = "pebble_large",
        at_least_one = {
            "dirt_ordinary",
            "dirt_permafrost_ordinary",
            "gravel_ordinary",
            "stone_ordinary",
        },
    }

end

function unilib.pkg.deco_cavestuff_pebble_large_stone_ordinary.post()

    unilib.register_decoration_complete("cavestuff_pebble_large_stone_ordinary", nil, {
        -- From cavestuff/magpen.lua
        -- Completes decoration in package "pebble_large"
        place_on = {
            "unilib:dirt_ordinary_with_turf",
            "unilib:dirt_permafrost_ordinary_with_litter_stone",
            "unilib:gravel_ordinary",
            "unilib:stone_ordinary",
        },
    })

end
