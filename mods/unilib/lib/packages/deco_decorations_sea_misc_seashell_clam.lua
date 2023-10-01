---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    decorations_sea
-- Code:    GPLv3
-- Media:   CC BY 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_decorations_sea_misc_seashell_clam = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.decorations_sea.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_decorations_sea_misc_seashell_clam.init()

    return {
        description = "Clam seashell as decoration",
        depends = {"liquid_water_ordinary", "misc_seashell_clam", "sand_ordinary"},
    }

end

function unilib.pkg.deco_decorations_sea_misc_seashell_clam.post()

    unilib.register_decoration_now("decoration_sea_misc_seashell_clam_1", nil, {
        -- From decorations_sea/mapgen.lua
        -- Completes decoration in package "misc_seashell_clam"
        biomes = unilib.pkg.shared_decorations_sea.warm_biome_list,
        num_spawn_by = 1,
        place_on = "unilib:sand_ordinary",
        spawn_by = "unilib:liquid_water_ordinary_source",
        y_max = 1,
        y_min = -32,
    })

    unilib.register_decoration_now("decoration_sea_misc_seashell_clam_2", nil, {
        -- From decorations_sea/mapgen.lua
        -- Completes decoration in package "misc_seashell_clam"
        biomes = unilib.pkg.shared_decorations_sea.temperate_biome_list,
        num_spawn_by = 1,
        place_on = "unilib:sand_ordinary",
        spawn_by = "unilib:liquid_water_ordinary_source",
        y_max = 1,
        y_min = -32,
    })

end
