---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_default_tree_jungle = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.default.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_default_tree_jungle.init()

    return {
        description = "Jungle tree as decoration",
        depends = {"biome_default_rainforest", "tree_jungle"},
        at_least_one = {"dirt_ordinary", "dirt_ordinary_with_litter_rainforest"},
    }

end

function unilib.pkg.deco_default_tree_jungle.post()

    if unilib.global.pkg_executed_table["dirt_ordinary_with_litter_rainforest"] ~= nil then

        unilib.register_decoration_complete("default_tree_jungle", nil, {
            -- From default/mapgen.lua
            -- Completes decoration in package "tree_jungle"
            biomes = "default_rainforest",
            place_on = "unilib:dirt_ordinary_with_litter_rainforest",
            y_max = unilib.constant.y_max,
            y_min = 1,
        })

        -- Due to 32 node height, altitude is limited and presence depends on chunksize
        local chunksize = tonumber(core.get_mapgen_setting("chunksize"))
        if chunksize >= 5 then

            unilib.register_decoration_complete("default_tree_jungle_emergent", nil, {
                -- From default/mapgen.lua
                -- Completes decoration in package "tree_jungle"
                biomes = "default_rainforest",
                place_on = "unilib:dirt_ordinary_with_litter_rainforest",
                y_max = 32,
                y_min = 1,
            })

        end

    end

    if unilib.global.pkg_executed_table["dirt_ordinary"] ~= nil then

        unilib.register_decoration_complete("default_tree_jungle_swamp", nil, {
            -- From default/mapgen.lua
            -- Completes decoration in package "tree_jungle"
            biomes = "default_rainforest_swamp",
            place_on = "unilib:dirt_ordinary",
            y_max = 0,
            y_min = -1,
        })

    end

end
