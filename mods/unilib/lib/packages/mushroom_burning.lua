---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    underch
-- Code:    CC0
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mushroom_burning = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.underch.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mushroom_burning.init()

    return {
        description = "Burning mushroom",
    }

end

function unilib.pkg.mushroom_burning.exec()

    unilib.register_node("unilib:mushroom_burning", "underch:burning_mushroom", mode, {
        -- From underch:burning_mushroom
        description = S("Burning Mushroom"),
        tiles = {{
            name = "unilib_mushroom_burning.png",
            animation = {
                type = "vertical_frames",
                aspect_w = 16,
                aspect_h = 16,
                length = 0.5,
            },
        }},
        -- N.B. food_mushroom = 1, mushroom = 1 not in original code
        groups = {attached_node = 1, food_mushroom = 1, mushroom = 1, snappy = 3},
        sounds = unilib.sound_table.leaves,

        buildable_to = true,
        damage_per_second = 1,
        drawtype = "plantlike",
        inventory_image = "[combine:16x16:0,0=unilib_mushroom_burning.png",
        light_source = 8,
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-4 / 16, -0.5, -4 / 16, 4 / 16, 1 / 16, 4 / 16},
        },
        sunlight_propagates = true,
        walkable = false,
        wield_image = "[combine:16x16:0,0=unilib_mushroom_burning.png",

        -- N.B. No call to unilib.cuisine_eat_on_use(); checking food history doesn't matter for
        --      poisonous foods
        on_use = minetest.item_eat(-2),
    })
    unilib.register_mushroom_in_pot("unilib:mushroom_burning", "underch:burning_mushroom")

end
