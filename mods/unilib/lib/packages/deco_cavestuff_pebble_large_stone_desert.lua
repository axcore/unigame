---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    plantlife/cavestuff
-- Code:    LGPL v3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_cavestuff_pebble_large_stone_desert = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.cavestuff.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_cavestuff_pebble_large_stone_desert.init()

    return {
        description = "Large desert stone pebble as decoration",
        depends = "pebble_large",
        at_least_one = {"sand_desert", "stone_desert"},
    }

end

function unilib.pkg.deco_cavestuff_pebble_large_stone_desert.post()

    unilib.register_decoration_now("cavestuff_pebble_large_stone_desert", nil, {
        -- From cavestuff/magpen.lua
        -- Completes decoration in package "pebble_large"
        place_on = {"unilib:sand_desert", "unilib:stone_desert"},
    })

end
