---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_daisy_silver = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_daisy_silver.init()

    return {
        description = "Silver daisy",
    }

end

function unilib.pkg.flower_daisy_silver.exec()

    unilib.register_node("unilib:flower_daisy_silver", "australia:silver_daisy", mode, {
        -- From australia:silver_daisy
        description = unilib.annotate(S("Silver Daisy"), "Olearia pannosa"),
        tiles = {"unilib_flower_daisy_silver.png"},
        -- N.B. Replaced original groups with standard flower groups
--      groups = {attached_node = 1, flammable = 2, flora = 1, snappy = 3},
        groups = {
            attached_node = 1, color_grey = 1, flammable = 1, flora = 1, flower = 1, snappy = 3,
        },
        sounds = unilib.sound_table.leaves,

        buildable_to = false,
        drawtype = "plantlike",
        inventory_image = "unilib_flower_daisy_silver.png",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.5, -0.5, -0.5, 0.5, -0.3125, 0.5},
        },
        sunlight_propagates = true,
        visual_scale = 1.0,
        walkable = false,
        waving = 1,
        wield_image = "unilib_flower_daisy_silver.png",
    })
    unilib.register_flower_in_pot("unilib:flower_daisy_silver", "australia:silver_daisy")

    unilib.register_decoration("australia_flower_daisy_silver", {
        -- From australia:silver_daisy
        deco_type = "simple",
        decoration = "unilib:flower_daisy_silver",

        fill_ratio = 0.02,
        sidelen = 80,
    })

end
