---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    moretrees
-- Code:    LGPL 3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_moretrees_tree_fir_douglas = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.moretrees.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_moretrees_tree_fir_douglas.init()

    return {
        description = "Douglas fir tree as decoration",
        depends = {"dirt_ordinary", "tree_fir_douglas"},
    }

end

function unilib.pkg.deco_moretrees_tree_fir_douglas.post()

    unilib.register_decoration_complete("convert_tree_fir_douglas", nil, {
        -- From moretrees/init.lua
        -- Completes decoration in package "tree_fir_douglas"
        place_on = "unilib:dirt_ordinary_with_turf",
        y_max = unilib.constant.y_max,
        y_min = 25,
    })

    -- N.B. The original code uses biome_lib to place the tree on actual snow; the code in this
    --      package is an approximation of that behaviour
    unilib.register_decoration_complete("convert_tree_fir_douglas_on_snow", nil, {
        -- From moretrees/init.lua
        -- Completes decoration in package "tree_fir_douglas"
        place_on = "unilib:dirt_ordinary_with_cover_snow",
    })

end

