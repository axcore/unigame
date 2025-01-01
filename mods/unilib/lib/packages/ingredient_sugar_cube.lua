---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo (20241118 update)
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.ingredient_sugar_cube = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ingredient_sugar_cube.init()

    return {
        description = "Sugar cube",
        optional = "ingredient_sugar_normal",
    }

end

function unilib.pkg.ingredient_sugar_cube.exec()

    unilib.register_node("unilib:ingredient_sugar_cube", "farming:sugar_cube", mode, {
        -- From farming:sugar_cube
        description = S("Sugar Cube"),
        tiles = {"unilib_ingredient_sugar_cube.png"},
        groups = {crumbly = 2},
        sounds = unilib.global.sound_table.gravel,

        floodable = true,
        is_ground_content = false,
    })
    unilib.register_craft_3x3({
        -- From farming:sugar_cube
        output = "unilib:ingredient_sugar_cube",
        -- N.B. Original recipe used "farming:sugar" only
        ingredient = "group:food_sugar",
    })
    if unilib.global.pkg_executed_table["ingredient_sugar_normal"] ~= nil then

        -- (N.B. The side-effect of this recipe is a method for converting other types of sugar into
        --      normal sugar)
        unilib.register_craft({
            -- From farming:sugar_cube
            output = "unilib:ingredient_sugar_normal 9",
            recipe = {
                {"unilib:ingredient_sugar_cube"},
            },
        })

    end

end
