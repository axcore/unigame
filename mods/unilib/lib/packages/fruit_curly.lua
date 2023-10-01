---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    moreplants
-- Code:    LGPL 2.1+
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.fruit_curly = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.moreplants.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.fruit_curly.init()

    return {
        description = "Curly fruit",
        optional = "dye_basic",
    }

end

function unilib.pkg.fruit_curly.exec()

    unilib.register_craftitem("unilib:fruit_curly", "moreplants:curlyfruit", mode, {
        -- From moreplants:curlyfruit
        description = S("Curly Fruit"),
        inventory_image = "unilib_fruit_curly.png",
        -- N.B. No groups in original code
        groups = {food_curly_fruit = 1},

        on_use = unilib.cuisine_eat_on_use("unilib:fruit_curly", 1),
    })
    if unilib.dye_from_fruit_flag and unilib.pkg_executed_table["dye_basic"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            output = "unilib:dye_brown",
            recipe = {
                {"unilib:fruit_curly"},
            },
        })

    end

    -- N.B. No call to unilib.setup_regrowing_fruit(), as this fruit does not grow on a tree

end
