---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_ethereal_flower_lazarus_bell = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_ethereal_flower_lazarus_bell.init()

    return {
        description = "Lazarus bell as decoration",
        depends = {"flower_lazarus_bell", "tree_jungle"},
        at_least_one = {"dirt_ordinary", "dirt_ordinary_with_turf_rainforest"},
    }

end

function unilib.pkg.deco_ethereal_flower_lazarus_bell.post()

    if unilib.global.pkg_executed_table["dirt_ordinary"] ~= nil or
            unilib.global.pkg_executed_table["dirt_ordinary_with_turf_rainforest"] ~= nil then

        unilib.register_decoration_complete(
            -- From ethereal-ng/decor.lua
            -- Completes decoration in package "flower_lazarus_bell"
            "bakedclay_flower_lazarus_bell",
            "ethereal_flower_lazarus_bell",
            {
                place_on = {
                    "unilib:dirt_ordinary_with_litter_rainforest",
                    "unilib:dirt_ordinary_with_turf_rainforest",
                },
                num_spawn_by = 1,
                spawn_by = "unilib:tree_jungle_trunk",
                y_max = 90,
                y_min = 1,
            }
        )

    end

end
