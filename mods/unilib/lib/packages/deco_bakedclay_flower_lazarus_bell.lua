---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    bakedclay
-- Code:    MIT
-- Media:   CC
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_bakedclay_flower_lazarus_bell = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.bakedclay.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_bakedclay_flower_lazarus_bell.init()

    return {
        description = "Lazarus Bell as decoration",
        depends = {"dirt_ordinary", "flower_lazarus_bell", "tree_jungle"},
    }

end

function unilib.pkg.deco_bakedclay_flower_lazarus_bell.exec()

    unilib.register_decoration_now("bakedclay_flower_lazarus_bell", nil, {
        -- From bakedclay/init.lua
        -- Completes decoration in package "flower_lazarus_bell"
        num_spawn_by = 1,
        place_on = {
            "unilib:dirt_ordinary_with_litter_rainforest",
            "unilib:dirt_ordinary_with_turf",
        },
        spawn_by = "unilib:tree_jungle_trunk",
        y_max = 90,
        y_min = 1,
    })

end
