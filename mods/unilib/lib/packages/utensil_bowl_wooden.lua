---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
--
-- From:    thirsty
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA-4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.utensil_bowl_wooden = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.utensil_bowl_wooden.init()

    return {
        description = "Wooden bowl",
        notes = "Can be used on water to increase the player's hydration",
    }

end

function unilib.pkg.utensil_bowl_wooden.exec()

    unilib.register_craftitem(
        -- From farming:bowl
        "unilib:utensil_bowl_wooden",
        {"farming:bowl", "ethereal:bowl", "thirsty:wooden_bowl"},
        mode,
        {
            description = S("Wooden Bowl"),
            inventory_image = "unilib_utensil_bowl_wooden.png",
            groups = {flammable = 2, food_bowl = 1},
        }
    )
    -- N.B. Original craft recipe conflicts with recipe in "bucket_wood" package
    --[[
    unilib.register_craft({
        -- From farming:bowl
        output = "unilib:utensil_bowl_wooden 4",
        recipe = {
            {"group:wood", "", "group:wood"},
            {"", "group:wood", ""},
        },
    })
    ]]--
    unilib.register_craft({
        -- From farming:bowl
        output = "unilib:utensil_bowl_wooden 6",
        recipe = {
            {"group:wood", "", "group:wood"},
            {"group:wood", "group:wood", "group:wood"},
        },
    })
    unilib.register_craft({
        -- From farming:bowl
        type = "fuel",
        recipe = "unilib:utensil_bowl_wooden",
        burntime = 10,
    })
    -- From "thirsty" mod
    unilib.hydration_enable_drinking_from_container("unilib:utensil_bowl_wooden", 25)

end
