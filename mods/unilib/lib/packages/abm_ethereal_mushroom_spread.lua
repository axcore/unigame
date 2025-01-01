---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.abm_ethereal_mushroom_spread = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.abm_ethereal_mushroom_spread.init()

    return {
        description = "Replacement ABM from ethereal-ng, replacing the one specified by the" ..
                " \"abm_standard_mushroom_spread\" package",
        depends = "shared_standard",
        excludes = "abm_standard_mushroom_spread",
    }

end

function unilib.pkg.abm_ethereal_mushroom_spread.post()

    unilib.register_abm({
        -- From ethereal-ng/dirt.lua
        label = "Mushroom spread [abm_ethereal_mushroom_spread]",
        nodenames = {"group:mushroom"},

        chance = 50,
        interval = 11,

        action = function(...)
            unilib.pkg.shared_standard.mushroom_spread(...)
        end,
    })

end
