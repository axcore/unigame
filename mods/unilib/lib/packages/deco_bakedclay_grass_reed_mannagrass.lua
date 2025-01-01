---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    bakedclay
-- Code:    MIT
-- Media:   CC
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_bakedclay_grass_reed_mannagrass = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.bakedclay.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_bakedclay_grass_reed_mannagrass.init()

    return {
        description = "Reed mannagrass as decoration",
        depends = "grass_reed_mannagrass",
        at_least_one = {"dirt_ordinary", "sand_ordinary"},
    }

end

function unilib.pkg.deco_bakedclay_grass_reed_mannagrass.post()

    unilib.register_decoration_complete("bakedclay_grass_reed_mannagrass", nil, {
        -- From bakedclay/init.lua
        -- Completes decoration in package "grass_reed_mannagrass"
        num_spawn_by = 1,
        place_on = {"unilib:dirt_ordinary_with_turf", "unilib:sand_ordinary"},
        spawn_by = "group:water",
        y_max = 15,
        y_min = 1,
    })

end
