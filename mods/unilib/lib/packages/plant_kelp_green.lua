---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.plant_kelp_green = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.plant_kelp_green.init()

    return {
        description = "Green kelp",
    }

end

function unilib.pkg.plant_kelp_green.exec()

    unilib.register_node("unilib:plant_kelp_green", "mapgen:kelp1", mode, {
        -- From farlands, mapgen:kelp1
        description = S("Green Kelp"),
        tiles = {"unilib_plant_kelp_green.png"},
        groups = {attached_node = 1, flammable = 1, sea = 1, snappy = 3},
        sounds = unilib.global.sound_table.leaves,

        drawtype = "plantlike",
        inventory_image = "unilib_plant_kelp_green.png",
        -- N.B. removed is_ground_content = false to match other plants
--      is_ground_content = false,
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.2, -0.5, -0.2, 0.2, 0.5, 0.2},
        },
        sunlight_propagates = true,
        walkable = false,
        waving = 1,

        -- N.B. No .on_place() in original code
        on_place = function(itemstack, placer, pointed_thing)

            return unilib.misc.place_in_medium(
                itemstack, placer, pointed_thing,
                {need_under = "group:sand"}
            )

        end,
    })
    -- (not compatible with flowerpots)

    unilib.register_node("unilib:plant_kelp_green_thick", "mapgen:kelp2", mode, {
        -- From farlands, mapgen:kelp2
        description = S("Thick Green Kelp"),
        tiles = {"unilib_plant_kelp_green_thick.png"},
        groups = {attached_node = 1, flammable = 1, sea = 1, snappy = 3},
        sounds = unilib.global.sound_table.leaves,

        drawtype = "plantlike",
        -- N.B. Original code uses "unilib_plant_kelp_green.png" for some reason
        inventory_image = "unilib_plant_kelp_green_thick.png",
        -- N.B. removed is_ground_content = false to match other plants
--      is_ground_content = false,
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.2, -0.5, -0.2, 0.2, 0.5, 0.2},
        },
        sunlight_propagates = true,
        walkable = false,
        waving = 1,

        -- N.B. No .on_place() in original code
        on_place = function(itemstack, placer, pointed_thing)

            return unilib.misc.place_in_medium(
                itemstack, placer, pointed_thing,
                {need_under = "group:sand"}
            )

        end,
    })

end
