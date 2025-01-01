---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.plant_kelp_spiny = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.plant_kelp_spiny.init()

    return {
        description = "Spiny kelp",
        depends = "stone_ordinary_with_kelp",
        at_least_one = "liquid_water_ordinary",
    }

end

function unilib.pkg.plant_kelp_spiny.exec()

    unilib.register_node("unilib:plant_kelp_spiny", "australia:kelp_brown", mode, {
        -- From australia:kelp_brown
        description = unilib.utils.annotate(S("Spiny Kelp"), "Ecklonia radiata"),
        tiles = {"unilib_plant_kelp_spiny.png"},
        groups = {sea = 1, seaplants = 1, snappy = 3},
        sounds = unilib.global.sound_table.leaves,

        climbable = true,
        drawtype = "plantlike",
        drowning = 1,
        inventory_image = "unilib_plant_kelp_spiny.png",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.5, -0.5, -0.5, 0.5, -0.3125, 0.5},
        },
        sunlight_propagates = true,
        walkable = false,
        waving = 1,
        wield_image = "unilib_plant_kelp_spiny.png",

        -- N.B. No .on_place() in original code
        on_place = function(itemstack, placer, pointed_thing)

            return unilib.misc.place_in_medium(
                itemstack, placer, pointed_thing,
                {need_under = "unilib:stone_ordinary_with_kelp_spiny"}
            )

        end,
    })
    -- (not compatible with flowerpots)

    -- (Spawn on suitable stone)
    unilib.register_abm({
        -- From australia:kelp_brown
        label = "Spawn kelp [plant_kelp_spiny]",
        nodenames = {"unilib:stone_ordinary_with_kelp_spiny"},

        chance = 5,
        interval = 15,

        action = function(pos)

            local yp = {x = pos.x, y = pos.y + 1, z = pos.z}
            if core.get_node(yp).name == "unilib:liquid_water_ordinary_source" then

                pos.y = pos.y + 1
                core.add_node(pos, {name = "unilib:plant_kelp_spiny"})

            else

                return

            end

        end
    })

end
