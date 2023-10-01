---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_default_tree_acacia_log = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.default.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_default_tree_acacia_log.init()

    return {
        description = "Acacia tree log as decoration",
        depends = {"biome_default_savanna", "dirt_dry", "tree_acacia"},
    }

end

function unilib.pkg.deco_default_tree_acacia_log.post()

    unilib.register_decoration_now("default_tree_acacia_log", nil, {
        -- From default/mapgen.lua
        -- Completes decoration in package "tree_acacia"
        biomes = "default_savanna",
        num_spawn_by = 8,
        place_on = "unilib:dirt_dry_with_turf_dry",
        spawn_by = "unilib:dirt_dry_with_turf_dry",
        y_max = unilib.y_max,
        y_min = 1,
    })

end
