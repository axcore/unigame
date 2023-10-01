---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    moretrees
-- Code:    LGPL 3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_moretrees_tree_palm_exposed = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.moretrees.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_moretrees_tree_palm_exposed.init()

    return {
        description = "Exposed palm tree as decoration",
        depends = {"liquid_water_ordinary", "sand_ordinary", "tree_palm_exposed"},
    }

end

function unilib.pkg.deco_moretrees_tree_palm_exposed.post()

    unilib.register_decoration_now("convert_tree_palm_exposed", nil, {
        -- From moretrees/init.lua
        -- Completes decoration in package "tree_palm_exposed"
        place_on = "unilib:sand_ordinary",
        spawn_by = "unilib:liquid_water_ordinary_source",
        y_max = 1,
        y_min = -1,
    })

end
