---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    nsspf
-- Code:    LGPL
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_nsspf_mushroom_common_ink_cap = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.nsspf.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_nsspf_mushroom_common_ink_cap.init()

    return {
        description = "Common ink cap mushroom as decoration",
        depends = {"dirt_ordinary", "mushroom_common_ink_cap"},
    }

end

function unilib.pkg.deco_nsspf_mushroom_common_ink_cap.post()

    unilib.register_decoration_complete("nsspf_mushroom_common_ink_cap", nil, {
        -- Original to unilib, replacing the collection of ABMs in the original nsspf code
        -- Completes decoration in package "mushroom_common_ink_cap"
        place_on = {"unilib:dirt_ordinary", "unilib:dirt_ordinary_with_turf"},
        y_max = unilib.constant.y_max,
        y_min = 1,
    })

end
