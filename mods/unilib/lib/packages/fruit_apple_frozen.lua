---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    snow
-- Code:    GPL 3.0
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.fruit_apple_frozen = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.snow.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.fruit_apple_frozen.init()

    return {
        description = "Frozen apple",
        depends = "fruit_apple",
    }

end

function unilib.pkg.fruit_apple_frozen.exec()

    unilib.register_node("unilib:fruit_apple_frozen", "snow:apple", mode, {
        -- From snow:apple
        description = S("Frozen Apple"),
        tiles = {"unilib_fruit_apple_frozen.png"},
        groups = {
            dig_immediate = 3, flammable = 1, fleshy = 3, food_apple = 1, leafdecay = 3,
            leafdecay_drop = 1,
        },
        sounds = unilib.global.sound_table.leaves,

        drawtype = "plantlike",
        -- N.B. Unlike original code, frozen apples are now pickable and eatable
--      drop = "unilib:fruit_apple",
        -- N.B. No inventory_image in original code
        inventory_image = "unilib_fruit_apple_frozen.png",
        -- N.B. no is_ground_content in original code
        is_ground_content = false,
        paramtype = "light",
        -- N.B. paramtyp2 removed for consistency with unilib:fruit_apple
--      paramtype2 = "degrotate",
        selection_box = {
            type = "fixed",
            fixed = {-3 / 16, -7 / 16, -3 / 16, 3 / 16, 4 / 16, 3 / 16},
        },
        sunlight_propagates = true,
        walkable = false,

        -- N.B. No .after_place_node in original code
        after_place_node = function(pos, placer)

            if placer:is_player() then
                core.set_node(pos, {name = "unilib:fruit_apple_frozen", param2 = 1})
            end

        end,

        -- N.B. No .on_use() in original code
        on_use = unilib.cuisine.eat_on_use("unilib:fruit_apple_frozen", 1),
    })

end
