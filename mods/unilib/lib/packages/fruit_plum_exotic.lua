---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.fruit_plum_exotic = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.fruit_plum_exotic.init()

    return {
        description = "Exotic plum",
        optional = "dye_basic",
    }

end

function unilib.pkg.fruit_plum_exotic.exec()

    unilib.register_craftitem("unilib:fruit_plum_exotic", "fruit:plum", mode, {
        -- From farlands, fruit:plum
        description = S("Exotic Plum"),
        inventory_image = "unilib_fruit_plum_exotic.png",
        -- N.B. No groups in original code
        groups = {food_plum = 1},

        on_use = unilib.cuisine_eat_on_use("unilib:fruit_plum_exotic", 1),
    })
    if unilib.dye_from_fruit_flag and unilib.pkg_executed_table["dye_basic"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            output = "unilib:dye_violet",
            recipe = {
                {"unilib:fruit_plum_exotic"},
            },
        })

    end

    -- N.B. No call to unilib.setup_regrowing_fruit(), as this fruit is implemented as an ore

end
