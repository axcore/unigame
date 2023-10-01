---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.fruit_cactus_exotic = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.fruit_cactus_exotic.init()

    return {
        description = "Exotic cactus fruit",
        optional = "dye_basic",
    }

end

function unilib.pkg.fruit_cactus_exotic.exec()

    unilib.register_node("unilib:fruit_cactus_exotic", "fruit:cactus_fruit", mode, {
        -- From farlands, fruit:cactus_fruit
        description = S("Exotic Cactus Fruit"),
        tiles = {"unilib_fruit_cactus_exotic.png"},
        -- N.B. no food_cactus in original code
        groups = {dig_immediate = 3, fleshy = 1, food_cactus = 1, oddly_breakable_by_hand = 1},
        sounds = unilib.sound_table.leaves,

        collision_box = {
            type = "fixed",
            fixed = {
                {-0.3, -0.4, -0.3, 0.3, -0.5, 0.3},
            },
        },
        drawtype = "plantlike",
        inventory_image = "unilib_fruit_cactus_exotic_inv.png",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {
                {-0.3, -0.4, -0.3, 0.3, -0.5, 0.3},
            },
        },
        wield_image = "unilib_fruit_cactus_exotic.png",

        on_use = unilib.cuisine_eat_on_use("unilib:fruit_cactus_exotic", 2),
    })
    if unilib.dye_from_fruit_flag and unilib.pkg_executed_table["dye_basic"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            output = "unilib:dye_magenta",
            recipe = {
                {"unilib:fruit_cactus_exotic"},
            },
        })

    end

    -- N.B. No call to unilib.setup_regrowing_fruit(), as this fruit grows on a plant

end
