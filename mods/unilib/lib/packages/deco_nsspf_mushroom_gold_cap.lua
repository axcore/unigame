---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    nsspf
-- Code:    LGPL
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_nsspf_mushroom_gold_cap = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.nsspf.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_nsspf_mushroom_gold_cap.init()

    return {
        description = "Gold cap mushroom as decoration",
        depends = {"dirt_ordinary", "mushroom_gold_cap"},
    }

end

function unilib.pkg.deco_nsspf_mushroom_gold_cap.post()

    unilib.register_decoration_now("nsspf_mushroom_gold_cap", nil, {
        -- Original to unilib, replacing the collection of ABMs in the original nsspf code
        -- Completes decoration in package "mushroom_gold_cap"
        place_on = {"unilib:dirt_ordinary", "unilib:dirt_ordinary_with_turf"},
        y_max = unilib.y_max,
        y_min = 1,
    })

end
