---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_fire = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_fire.init()

    return {
        description = "Fire flower",
        notes = "Igniter/fuel, and reduces player health when punched. Can be crafted into" ..
                " fire flower dust",
    }

end

function unilib.pkg.flower_fire.exec()

    unilib.register_node("unilib:flower_fire", "ethereal:fire_flower", mode, {
        -- From ethereal:fire_flower
        description = S("Fire Flower"),
        tiles = {"unilib_flower_fire.png"},
        -- N.B. Added standard flower groups, but retained igniter = 2
--      groups = {igniter = 2, oddly_breakable_by_hand = 3, snappy = 1},
        groups = {
            attached_node = 1, color_red = 1, colour_red = 1, flammable = 1, flora = 1, flower = 1,
            igniter = 2, snappy = 3,
        },
        sounds = unilib.global.sound_table.leaves,

        buildable_to = true,
        damage_per_second = 2,
        drawtype = "plantlike",
        inventory_image = "unilib_flower_fire.png",
        light_source = 5,
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-5 / 16, -0.5, -5 / 16, 5 / 16, 1 / 2, 5 / 16}
        },
        sunlight_propagates = true,
        walkable = false,
        wield_image = "unilib_flower_fire.png",

        on_punch = function(pos, node, puncher)

            puncher:punch(
                puncher,
                1.0,
                {
                    full_punch_interval = 1.0,
                    damage_groups = {fleshy = 2},
                },
                nil
            )

        end
    })
    unilib.register_craft({
        -- From ethereal:fire_flower
        type = "fuel",
        recipe = "unilib:flower_fire",
        burntime = 20,
    })
    unilib.register_flower_in_pot("unilib:flower_fire", "ethereal:fire_flower")

    -- N.B. In original, described as "Fire Dust"; this has been updated in unilib for realism
    unilib.register_craftitem("unilib:flower_fire_dust", "ethereal:fire_dust", mode, {
        -- From ethereal:fire_dust
        description = S("Fire Flower Dust"),
        inventory_image = "unilib_flower_fire_dust.png"
    })
    unilib.register_craft({
        -- From ethereal:fire_dust
        output = "unilib:flower_fire_dust 2",
        recipe = {
            {"unilib:flower_fire"},
        },
    })
    unilib.register_craft({
        -- From ethereal:fire_dust
        type = "fuel",
        recipe = "unilib:flower_fire_dust",
        burntime = 10,
    })

    unilib.register_decoration_spare("unilib:flower_fire")

end
