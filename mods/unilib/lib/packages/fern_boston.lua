---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.fern_boston = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.fern_boston.init()

    return {
        description = "Boston fern",
        notes = "Occasionally drops edible tubers",
    }

end

function unilib.pkg.fern_boston.exec()

    unilib.register_node("unilib:fern_boston", "ethereal:fern", mode, {
        -- From ethereal:fern
        description = unilib.annotate(S("Boston Fern"), "Nephrolepis exaltata"),
        tiles = {"unilib_fern_boston.png"},
        groups = {attached_node = 1, flammable = 2, flora = 1, snappy = 3},
        sounds = unilib.sound_table.leaves,

        buildable_to = true,
        drawtype = "plantlike",
        drop = {
            max_items = 1,
            items = {
                {items = {"unilib:fern_boston_tuber"}, rarity = 6},
                {items = {"unilib:fern_boston"}}
            }
        },
        inventory_image = "unilib_fern_boston.png",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-5 / 16, -0.5, -5 / 16, 5 / 16, 0.67, 5 / 16},
        },
        sunlight_propagates = true,
        visual_scale = 1.4,
        walkable = false,
        waving = 1,
        wield_image = "unilib_fern_boston.png",
    })
    unilib.register_craftitem("unilib:fern_boston_tuber", "ethereal:fern_tubers", mode, {
        -- From ethereal:fern_tubers
        description = S("Boston Fern Tubers"),
        inventory_image = "unilib_fern_boston_tuber.png",
        groups = {flammable = 2, food_tuber = 1},

        on_use = unilib.cuisine_eat_on_use("unilib:fern_boston_tuber", 1),
    })
    -- (not compatible with flowerpots)

end
