---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.abm_ethereal_mushroom_spread = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.abm_ethereal_mushroom_spread.init()

    return {
        description = "Replacment \"mushroom_spread\" ABM",
    }

end

function unilib.pkg.abm_ethereal_mushroom_spread.post()

    unilib.abm_replace_table.mushroom_spread = function()

        unilib.register_abm({
            -- From ethereal-ng/dirt.lua
            label = "Mushroom spread [abm_ethereal_mushroom_spread]",
            nodenames = {"group:mushroom"},

            chance = 50,
            interval = 11,

            -- (Function in ..lib/shared/flowers.lua)
            action = function(...)
                unilib.mushroom_spread(...)
            end,
        })

    end

end
