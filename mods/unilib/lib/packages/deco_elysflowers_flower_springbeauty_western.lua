---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    elysflowers
-- Code:    GPL-3.0-or-later
-- Media:   CC-BY-4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_elysflowers_flower_springbeauty_western = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.elysflowers.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_elysflowers_flower_springbeauty_western.init()

    return {
        description = "Western springbeauty as decoration",
        depends = {"dirt_ordinary_with_turf", "gravel_ordinary"},
        at_least_one = {"biome_default_savanna", "biome_ethereal_savanna"},
    }

end

function unilib.pkg.deco_elysflowers_flower_springbeauty_western.post()

    unilib.register_decoration_complete("elysflowers_flower_springbeauty_western", nil, {
        -- From elysflowers/init.lua
        -- Completes decoration in package "flower_springbeauty_western"
        biomes = {"default_savanna", "ethereal_savanna"},
        num_spawn_by = 1,
        place_on = "unilib:gravel_ordinary",
        spawn_by = "unilib:dirt_ordinary_with_turf",
        y_max = unilib.constant.y_max,
        y_min = 1,
    })

end
