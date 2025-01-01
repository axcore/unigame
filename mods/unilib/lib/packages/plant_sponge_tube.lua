---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.plant_sponge_tube = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.plant_sponge_tube.init()

    return {
        description = "Tube sponge",
    }

end

function unilib.pkg.plant_sponge_tube.exec()

    unilib.register_node("unilib:plant_sponge_tube", "australia:tube_sponge", mode, {
        -- From australia:tube_sponge
        description = unilib.utils.annotate(S("Tube Sponge"), "Pipestela candelabra"),
        tiles = {"unilib_plant_sponge_tube.png"},
        groups = {attached_node = 1, coral = 1, sea = 1, snappy = 3},
        sounds = unilib.global.sound_table.leaves,

        buildable_to = false,
        climbable = true,
        drawtype = "plantlike",
        drowning = 1,
        inventory_image = "unilib_plant_sponge_tube.png",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.5, -0.5, -0.5, 0.5, -0.3125, 0.5},
        },
        sunlight_propagates = true,
        visual_scale = 1.0,
        walkable = false,
        waving = 0,
        wield_image = "unilib_plant_sponge_tube.png",

        -- N.B. No .on_place() in original code
        on_place = function(itemstack, placer, pointed_thing)

            return unilib.misc.place_in_medium(
                itemstack, placer, pointed_thing,
                {need_under = "group:sand"}
            )

        end,
    })
    -- (not compatible with flowerpots)

    unilib.register_decoration_spare("unilib:plant_sponge_tube")

end
