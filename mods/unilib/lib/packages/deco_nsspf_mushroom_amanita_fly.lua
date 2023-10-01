---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    nsspf
-- Code:    LGPL
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_nsspf_mushroom_amanita_fly = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.nsspf.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_nsspf_mushroom_amanita_fly.init()

    return {
        description = "Fly amanita mushroom as decoration",
        depends = {"dirt_ordinary", "mushroom_amanita_fly", "tree_pine"},
    }

end

function unilib.pkg.deco_nsspf_mushroom_amanita_fly.post()

    unilib.register_decoration_now("nsspf_mushroom_amanita_fly", nil, {
        -- Original to unilib, replacing the collection of ABMs in the original nsspf code
        -- Completes decoration in package "mushroom_amanita_fly"
        place_on = {
            "unilib:dirt_ordinary_with_litter_coniferous",
            "unilib:dirt_ordinary_with_cover_snow",
        },
        spawn_by = "unilib:tree_pine_trunk",
        y_max = unilib.y_max,
        y_min = 1,
    })

end
