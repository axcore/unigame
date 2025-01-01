---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    moretrees
-- Code:    LGPL 3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_moretrees_tree_palm_date = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.moretrees.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_moretrees_tree_palm_date.init()

    return {
        description = "Date palm tree as decoration",
        depends = {"liquid_water_ordinary", "sand_desert", "tree_palm_date"},
    }

end

function unilib.pkg.deco_moretrees_tree_palm_date.post()

    -- N.B. This decoration combines the two decorations in original moretrees code
    unilib.register_decoration_complete("convert_tree_palm_date", nil, {
        -- From moretrees/init.lua
        -- Completes decoration in package "palm_date_large"
        place_on = "unilib:sand_desert",
        spawn_by = "unilib:liquid_water_ordinary_source",
        y_max = 30,
        y_min = -1,
    })

end
