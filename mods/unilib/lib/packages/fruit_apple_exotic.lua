---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.fruit_apple_exotic = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.fruit_apple_exotic.init()

    return {
        description = "Exotic apple",
        optional = "dye_basic",
    }

end

function unilib.pkg.fruit_apple_exotic.exec()

    unilib.register_node("unilib:fruit_apple_exotic", "fruit:apple", mode, {
        -- From fruit:apple
        description = S("Exotic Apple"),
        tiles = {"unilib_fruit_apple_exotic.png"},
        -- N.B. no food_apple in original code
        groups = {dig_immediate = 3, food_apple = 1, oddly_breakable_by_hand = 1, snappy = 1},
        sounds = unilib.sound_table.leaves,

        drawtype = "plantlike",
        inventory_image = "unilib_fruit_apple_exotic.png",
        paramtype = "light",
        wield_image = "unilib_fruit_apple_exotic.png",

        on_use = unilib.cuisine_eat_on_use("unilib:fruit_apple_exotic", 2),
    })
    if unilib.dye_from_fruit_flag and unilib.pkg_executed_table["dye_basic"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            output = "unilib:dye_red",
            recipe = {
                {"unilib:fruit_apple_exotic"},
            },
        })

    end

    -- N.B. No call to unilib.setup_regrowing_fruit(), as this fruit is implemented as an ore

end
