---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    nsspf
-- Code:    LGPL
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_nsspf_mushroom_morel_black = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.nsspf.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_nsspf_mushroom_morel_black.init()

    return {
        description = "Black morel mushroom as decoration",
        depends = {"dirt_ordinary", "mushroom_morel_black", "tree_aspen"},
    }

end

function unilib.pkg.deco_nsspf_mushroom_morel_black.post()

    unilib.register_decoration_now("nsspf_mushroom_morel_black", nil, {
        -- Original to unilib, replacing the collection of ABMs in the original nsspf code
        -- Completes decoration in package "mushroom_morel_black"
        place_on = "unilib:dirt_ordinary_with_turf",
        spawn_by = "unilib:tree_aspen_trunk",
        y_max = unilib.y_max,
        y_min = 1,
    })

end
