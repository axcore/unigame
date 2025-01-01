---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cucina_vegana
-- Code:    LGPL3.0
-- Media:   LGPL3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_cucina_vegana_plant_banana_dwarf_wild = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.cucina_vegana.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_cucina_vegana_plant_banana_dwarf_wild.init()

    return {
        description = "Wild dwarf banana plant as decoration",
        depends = {"dirt_ordinary", "plant_banana_dwarf_wild", "tree_jungle"},
    }

end

function unilib.pkg.deco_cucina_vegana_plant_banana_dwarf_wild.post()

    unilib.register_decoration_complete("cucina_vegana_plant_banana_dwarf_wild", nil, {
        -- From cucina_vegana, banana.lua
        -- Completes decoration in package "plant_banana_dwarf"
        num_spawn_by = 2,
        place_on = {"unilib:dirt_ordinary", "unilib:dirt_ordinary_with_litter_rainforest"},
        spawn_by = "unilib:tree_jungle_trunk",
        y_max = 120,
        y_min = 1,
    })

end
