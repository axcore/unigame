---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    decorations_sea
-- Code:    GPLv3
-- Media:   CC BY 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_decorations_sea_coral_block_tangerine = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.decorations_sea.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_decorations_sea_coral_block_tangerine.init()

    return {
        description = "Tangerine corals as decoration",
        depends = {"coral_block_tangerine", "liquid_water_ordinary", "sand_ordinary"},
    }

end

function unilib.pkg.deco_decorations_sea_coral_block_tangerine.post()

    for i = 1, 3 do

        unilib.register_decoration_now("decoration_sea_coral_block_tangerine_" .. i, nil, {
            -- From decorations_sea/mapgen.lua
            -- Completes decoration in package "coral_block_tangerine"
            biomes = unilib.pkg.shared_decorations_sea.warm_biome_list,
            num_spawn_by = 1,
            place_on = "unilib:sand_ordinary",
            spawn_by = "unilib:liquid_water_ordinary_source",
            y_max = -6,
            y_min = -32,
        })

    end

end
