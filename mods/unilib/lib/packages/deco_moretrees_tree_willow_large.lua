---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    moretrees
-- Code:    LGPL 3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_moretrees_tree_willow_large = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.moretrees.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_moretrees_tree_willow_large.init()

    return {
        description = "Large willow tree as decoration",
        depends = {"dirt_ordinary", "liquid_water_ordinary", "tree_willow_large"},
    }

end

function unilib.pkg.deco_moretrees_tree_willow_large.post()

    unilib.register_decoration_now("convert_tree_willow_large", nil, {
        -- From moretrees/init.lua
        -- Completes decoration in package "tree_willow_large"
        place_on = "unilib:dirt_ordinary_with_turf",
        spawn_by = "unilib:liquid_water_ordinary_source",
        y_max = 5,
        y_min = -5,
    })

end
