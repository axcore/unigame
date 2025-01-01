---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.plant_kelp_ordinary_gaia = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.plant_kelp_ordinary_gaia.init()

    return {
        description = "Ordinary kelp, modified for the \"gaia\" remix",
        excludes = "plant_kelp_ordinary",
    }

end

function unilib.pkg.plant_kelp_ordinary_gaia.exec()

    unilib.register_node("unilib:plant_kelp_ordinary", "default:sand_with_kelp", mode, {
        -- Adapted from farlands, mapgen:kelp1, but using the texture from minetest_game
        description = S("Ordinary Kelp"),
        tiles = {"unilib_plant_kelp_ordinary.png"},
        groups = {attached_node = 1, flammable = 1, sea = 1, snappy = 3},
        sounds = unilib.global.sound_table.leaves,

        drawtype = "plantlike",
        inventory_image = "unilib_plant_kelp_ordinary.png",
        is_ground_content = false,
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

    unilib.register_node("unilib:plant_kelp_ordinary_thick", nil, mode, {
        -- Adapted from farlands, mapgen:kelp2, using an original texture
        description = S("Thick Ordinary Kelp"),
        tiles = {"unilib_plant_kelp_ordinary_thick.png"},
        groups = {attached_node = 1, flammable = 1, sea = 1, snappy = 3},
        sounds = unilib.global.sound_table.leaves,

        drawtype = "plantlike",
        inventory_image = "unilib_plant_kelp_ordinary_thick.png",
        is_ground_content = false,
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
