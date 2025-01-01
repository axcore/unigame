---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.mushroom_white_glowing = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mushroom_white_glowing.init()

    return {
        description = "Glowing white mushroom",
    }

end

function unilib.pkg.mushroom_white_glowing.exec()

    unilib.register_node("unilib:mushroom_white_glowing", "mapgen:glowing_mushroom_white", mode, {
        -- From farlands, mapgen:glowing_mushroom_white
        description = S("Glowing White Mushroom"),
        tiles = {"unilib_mushroom_white_glowing.png"},
        -- N.B. mushroom = 1 not in original code
        groups = {attached_node = 1, flammable = 1, flora = 1, mushroom = 1, snappy = 3},
        sounds = unilib.global.sound_table.leaves,

        buildable_to = true,
        drawtype = "plantlike",
        inventory_image = "unilib_mushroom_white_glowing.png",
        -- N.B. removed is_ground_content = false to match other mushrooms
--      is_ground_content = false,
        light_source = 9,
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5},
        },
        sunlight_propagates = true,
        walkable = false,
    })
    unilib.register_mushroom_in_pot(
        "unilib:mushroom_white_glowing", "mapgen:glowing_mushroom_white"
    )

    unilib.register_decoration_spare("unilib:mushroom_white_glowing")

end
