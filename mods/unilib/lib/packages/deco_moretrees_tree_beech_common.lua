---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    moretrees
-- Code:    LGPL 3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_moretrees_tree_beech_common = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.moretrees.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_moretrees_tree_beech_common.init()

    return {
        description = "Common beech tree as decoration",
        depends = {"dirt_ordinary", "tree_beech_common"},
    }

end

function unilib.pkg.deco_moretrees_tree_beech_common.post()

    -- N.B. no y_min in the original code
    unilib.register_decoration_complete("convert_tree_beech_common", nil, {
        -- From moretrees/init.lua
        -- Completes decoration in package "tree_beech_common"
        place_on = "unilib:dirt_ordinary_with_turf",
        y_max = unilib.constant.y_max,
        y_min = 1,
    })

end
