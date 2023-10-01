---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.fruit_blueberry_ordinary = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.default.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.fruit_blueberry_ordinary.init()

    return {
        description = "Ordinary blueberries",
        optional = "dye_basic",
    }

end

function unilib.pkg.fruit_blueberry_ordinary.exec()

    unilib.register_craftitem("unilib:fruit_blueberry_ordinary", "default:blueberries", mode, {
        -- From default:blueberries
        description = S("Ordinary Blueberries"),
        inventory_image = "unilib_fruit_blueberry_ordinary.png",
        -- N.B. no food_blueberry in original code, but it does exist in other blueberry packages
        groups = {food_berry = 1, food_blueberries = 1, food_blueberry = 1},

        on_use = unilib.cuisine_eat_on_use("unilib:fruit_blueberry_ordinary", 2),
    })
    if unilib.dye_from_fruit_flag and unilib.pkg_executed_table["dye_basic"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            output = "unilib:dye_blue",
            recipe = {
                {"unilib:fruit_blueberry_ordinary"},
            },
        })

    end

    unilib.register_juice({
        ingredient = "unilib:fruit_blueberry_ordinary",
        juice_description = S("Ordinary Blueberry"),
        -- N.B. Original "drinks" mod used the juice type "blueberries"
        juice_type = "blueberry_ordinary",
        rgb = "#521dcb",
        orig_flag = false,
    })

    -- N.B. No call to unilib.setup_regrowing_fruit(), as this fruit grows on a bush

end
