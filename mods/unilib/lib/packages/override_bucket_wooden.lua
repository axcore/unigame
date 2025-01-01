---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    underch
-- Code:    CC0
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.override_bucket_wooden = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.underch.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.override_bucket_wooden.init()

    return {
        description = "Provide an additional crafting recipe for wooden bowls",
        depends = {"bucket_wood", "utensil_bowl_wooden"},
     }

end

function unilib.pkg.override_bucket_wooden.exec()

    unilib.register_craft({
        -- From farming:bowl
        type = "shapeless",
        output = "unilib:utensil_bowl_wooden 4",
        recipe = {"unilib:bucket_wood_empty"},
    })

end
