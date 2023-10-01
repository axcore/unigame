---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.override_unilib_salt_water = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.override_unilib_salt_water.init()

    return {
        description = "Overrides ordinary water from minetest_game to make a salt water, so that" ..
                " water in seas can't be drunk or used in craft recipes for foods",
        depends = "liquid_water_ordinary",
    }

end

function unilib.pkg.override_unilib_salt_water.exec()

    unilib.generic_liquid_table.water_ordinary.description = S("Salt Water")
    unilib.generic_liquid_table.water_ordinary.group_table.potable_bucket = nil
    unilib.generic_liquid_table.water_ordinary.potable_flag = false

    unilib.override_item("unilib:liquid_water_ordinary_source", {
        description = S("Salt Water Source"),
    })

    unilib.override_item("unilib:liquid_water_ordinary_flowing", {
        description = S("Flowing Salt Water"),
    })

end
