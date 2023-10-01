---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.fruit_berry_exotic = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.fruit_berry_exotic.init()

    return {
        description = "Exotic berry",
        optional = "dye_basic",
    }

end

function unilib.pkg.fruit_berry_exotic.exec()

    unilib.register_craftitem("unilib:fruit_berry_exotic", "fruit:berry", mode, {
        -- From farlands, fruit:berry
        description = S("Exotic Berry"),
        inventory_image = "unilib_fruit_berry_exotic.png",
        -- N.B. No groups in original code
        groups = {food_berry = 1},

        on_use = unilib.cuisine_eat_on_use("unilib:fruit_berry_exotic", 1),
    })
    if unilib.dye_from_fruit_flag and unilib.pkg_executed_table["dye_basic"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            output = "unilib:dye_red",
            recipe = {
                {"unilib:fruit_berry_exotic"},
            },
        })

    end

    -- N.B. No call to unilib.setup_regrowing_fruit(), as this fruit grows on a bush

end
