---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.item_worm_juicy = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.item_worm_juicy.init()

    return {
        description = "Juicy worm",
        notes = "Used as bait on a fishing rod",
        suggested = {
            "dirt_ordinary",                    -- group:soil
        },
    }

end

function unilib.pkg.item_worm_juicy.exec()

    unilib.register_craftitem("unilib:item_worm_juicy", "ethereal:worm", mode, {
        -- From ethereal:worm
        description = S("Juicy Worm"),
        inventory_image = "unilib_item_worm_juicy.png",

        wield_image = "unilib_item_worm_juicy.png"
    })
    unilib.register_craft({
        -- From ethereal:worm
        output = "unilib:item_worm_juicy",
        -- N.B. original code uses default:dirt
        recipe = {
            {"group:soil", "group:soil"},
        },
    })

end
