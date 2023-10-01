---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.override_ethereal_utensil = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.override_ethereal_utensil.init()

    return {
        description = "Overrides the bowl from farming_redo with a nicer texture",
        depends = "utensil_bowl_wooden",
    }

end

function unilib.pkg.override_ethereal_utensil.exec()

    unilib.override_item("unilib:utensil_bowl_wooden", {
        inventory_image = "unilib_utensil_bowl_wooden_ethereal.png",
    })

end
