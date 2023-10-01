---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.ore_ethereal_clay_baked = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function register_ore(y_max, y_min, full_name)

    unilib.register_ore({
        -- From ethereal-ng/ores.lua
        ore_type                = "stratum",
        ore                     = full_name,
        wherein                 = "unilib:clay_baked_orange",

        biomes                  = "ethereal_mesa",
        clust_scarcity          = 1,
        y_max                   = y_max,
        y_min                   = y_min,
    })

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ore_ethereal_clay_baked.init()

    return {
        description = "Baked clay as ore",
        depends = "biome_ethereal_mesa",
        at_least_one = {"clay_baked_basic", "clay_baked_ethereal"},
    }

end

function unilib.pkg.ore_ethereal_clay_baked.post()

    -- N.B. The "ethereal_mesa" biome occurs between y = 71 and y = 1

    register_ore(10, 5, "unilib:clay_baked_red")
    register_ore(20, 15, "unilib:clay_baked_grey")
    register_ore(30, 25, "unilib:clay_baked_red")
    register_ore(40, 35, "unilib:clay_baked_grey")
    register_ore(50, 45, "unilib:clay_baked_red")
    register_ore(60, 55, "unilib:clay_baked_grey")

end
