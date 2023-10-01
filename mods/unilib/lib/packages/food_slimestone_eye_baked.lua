---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    bakedeye
-- Code:    MIT
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.food_slimestone_eye_baked = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.bakedeye.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_slimestone_eye_baked.init()

    return {
        description = "Baked slimestone eye",
        at_least_one = {
            "stone_slate_red_extra",
            "stone_slimestone_green_extra",
            "stone_slimestone_purple_extra",
            "stone_slimestone_red_extra",
        },
    }

end

function unilib.pkg.food_slimestone_eye_baked.exec()

    if unilib.pkg_executed_table["stone_slate_red_extra"] ~= nil or
            unilib.pkg_executed_table["stone_slimestone_green_extra"] ~= nil or
            unilib.pkg_executed_table["stone_slimestone_purple_extra"] ~= nil or
            unilib.pkg_executed_table["stone_slimestone_red_extra"] ~= nil then

        unilib.register_craftitem("unilib:food_slimestone_eye_baked", "bakedeye:food", mode, {
            -- From bakedeye:food
            description = S("Baked Eye"),
            inventory_image = "unilib_food_slimestone_eye_baked.png",
            -- N.B. No groups in original code
            groups = {food_slimestone_eye = 1},

            on_use = unilib.cuisine_eat_on_use("unilib:food_slimestone_eye_baked", 3),
        })
        if unilib.pkg_executed_table["stone_slimestone_black_extra"] ~= nil then

            unilib.register_craft({
                -- From bakedeye:food
                type = "cooking",
                output = "unilib:food_slimestone_eye_baked",
                recipe = "unilib:stone_slimestone_black_eye",
            })

        end
        if unilib.pkg_executed_table["stone_slimestone_green_extra"] ~= nil then

            unilib.register_craft({
                -- From bakedeye:food
                type = "cooking",
                output = "unilib:food_slimestone_eye_baked",
                recipe = "unilib:stone_slimestone_green_eye",
            })

        end
        if unilib.pkg_executed_table["stone_slimestone_purple_extra"] ~= nil then

            unilib.register_craft({
                -- From bakedeye:food
                type = "cooking",
                output = "unilib:food_slimestone_eye_baked",
                recipe = "unilib:stone_slimestone_purple_eye",
            })

        end
        if unilib.pkg_executed_table["stone_slimestone_red_extra"] ~= nil then

            unilib.register_craft({
                -- From bakedeye:food
                type = "cooking",
                output = "unilib:food_slimestone_eye_baked",
                recipe = "unilib:stone_slimestone_red_eye",
            })

        end

    end

end
