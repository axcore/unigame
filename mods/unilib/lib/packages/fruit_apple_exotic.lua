---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.fruit_apple_exotic = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farlands.add_mode

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
        sounds = unilib.global.sound_table.leaves,

        drawtype = "plantlike",
        inventory_image = "unilib_fruit_apple_exotic.png",
        -- N.B. is_ground_content = false not in original code; added to match other fruit
        is_ground_content = false,
        paramtype = "light",
        wield_image = "unilib_fruit_apple_exotic.png",

        -- N.B. No .after_place_node in original code
        after_place_node = function(pos, placer)

            if placer:is_player() then
                core.set_node(pos, {name = "unilib:fruit_apple_exotic", param2 = 1})
            end

        end,

        on_use = unilib.cuisine.eat_on_use("unilib:fruit_apple_exotic", 2),
    })
    if unilib.setting.dye_from_fruit_flag and
            unilib.global.pkg_executed_table["dye_basic"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            output = "unilib:dye_red",
            recipe = {
                {"unilib:fruit_apple_exotic"},
            },
        })

    end

    unilib.register_juice({
        ingredient = "unilib:fruit_apple_exotic",
        juice_description = S("Apple"),
        juice_type = "apple",
        rgb = "#ecff56",

        orig_flag = false,
    })

    -- N.B. No call to unilib.register_regrowing_fruit(), as this fruit is implemented as an ore

end
