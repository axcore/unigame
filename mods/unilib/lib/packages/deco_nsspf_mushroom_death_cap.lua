---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    nsspf
-- Code:    LGPL
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_nsspf_mushroom_death_cap = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.nsspf.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_nsspf_mushroom_death_cap.init()

    return {
        description = "Death cap mushroom as decoration",
        depends = {"dirt_ordinary", "mushroom_death_cap", "tree_pine"},
    }

end

function unilib.pkg.deco_nsspf_mushroom_death_cap.post()

    unilib.register_decoration_complete("nsspf_mushroom_death_cap", nil, {
        -- Original to unilib, replacing the collection of ABMs in the original nsspf code
        -- Completes decoration in package "mushroom_death_cap"
        place_on = {
            "unilib:dirt_ordinary_with_litter_coniferous",
            "unilib:dirt_ordinary_with_cover_snow",
        },
        spawn_by = "unilib:tree_pine_trunk",
        y_max = unilib.constant.y_max,
        y_min = 1,
    })

end
