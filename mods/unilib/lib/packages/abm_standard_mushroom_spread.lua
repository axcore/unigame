---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    flowers
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.abm_standard_mushroom_spread = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.flowers.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.abm_standard_mushroom_spread.init()

    return {
        description = "ABM to handle mushroom spread (from minetest_game/flowers)",
        depends = "shared_standard",
    }

end

function unilib.pkg.abm_standard_mushroom_spread.post()

    -- Adapted from flowers/init.lua
    -- Mushrooms in group:mushroom only spread in low light, and strong light kills them

    unilib.register_abm({
        label = "Mushroom spread [abm_standard_mushroom_spread]",
        nodenames = {"group:mushroom"},

        chance = 150,
        interval = 11 / unilib.setting.abm_spread_factor,

        action = function(...)
            unilib.pkg.shared_standard.mushroom_spread(...)
        end,
    })
    unilib.register_obsolete_abm({
        mod_origin = "flowers",
        label = "Mushroom spread",
    })

end
