---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_default_dirt_dry = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.default.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_default_dirt_dry.init()

    return {
        description = "Dry dirt as decoration",
        depends = {"biome_default_savanna", "dirt_dry"},
    }

end

function unilib.pkg.deco_default_dirt_dry.post()

    -- Notes from default:
    -- Savanna bare dirt patches
    -- Must come before all savanna decorations that are placed on dry grass
    -- Noise is similar to long dry grass noise, but scale inverted, to appear where long dry grass
    --      is least dense and shortest
    unilib.register_decoration_complete("default_dirt_dry", nil, {
        -- From default/mapgen.lua
        -- Completes decoration in package "dirt_dry"
        biomes = "default_savanna",
        place_on = "unilib:dirt_dry_with_turf_dry",
        y_max = unilib.constant.y_max,
        y_min = 1,
    })

end
