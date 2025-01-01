---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.plant_kelp_yellow = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.plant_kelp_yellow.init()

    return {
        description = "Yellow kelp",
    }

end

function unilib.pkg.plant_kelp_yellow.exec()

    unilib.register_node("unilib:plant_kelp_yellow", "lib_ecology:plant_kelp_01", mode, {
        -- Adapted from farlands, mapgen:kelp1. Replaces the GLEM node "lib_ecology:plant_kelp_01"
        --      whose texture was identical to ordinary kelp
        description = S("Yellow Kelp"),
        tiles = {"unilib_plant_kelp_yellow.png"},
        groups = {attached_node = 1, flammable = 1, sea = 1, snappy = 3},
        sounds = unilib.global.sound_table.leaves,

        drawtype = "plantlike",
        inventory_image = "unilib_plant_kelp_yellow.png",
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

    unilib.register_node("unilib:plant_kelp_yellow_thick", nil, mode, {
        -- Adapted from farlands, mapgen:kelp2
        description = S("Thick Yellow Kelp"),
        tiles = {"unilib_plant_kelp_yellow_thick.png"},
        groups = {attached_node = 1, flammable = 1, sea = 1, snappy = 3},
        sounds = unilib.global.sound_table.leaves,

        drawtype = "plantlike",
        inventory_image = "unilib_plant_kelp_yellow_thick.png",
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
