---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    GLEMr6
-- Code:    LGPL 2.1
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.plant_kelp_yellow = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.glemr6.add_mode

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
        -- Texture from GLEMr6, lib_ecology_plant_kelp_01.png. Code adapted from the
        --      "plant_kelp_green" package for consistency
        description = S("Yellow Kelp"),
        tiles = {"unilib_plant_kelp_yellow.png"},
        groups = {attached_node = 1, flammable = 1, sea = 1, snappy = 3},
        sounds = unilib.sound_table.leaves,

        drawtype = "plantlike",
        inventory_image = "unilib_plant_kelp_yellow.png",
        is_ground_content = false,
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.2, -0.5, -0.2, 0.2, 0.5, 0.2},
        },
        sunlight_propagates = true,
        walkable = false,
        waving = 1,
    })
    -- (not compatible with flowerpots)

    unilib.register_node("unilib:plant_kelp_yellow_thick", nil, mode, {
        -- Original to unilib, code and textures adapted from farlands, mapgen:kelp2
        description = S("Thick Yellow Kelp"),
        tiles = {"unilib_plant_kelp_yellow_thick.png"},
        groups = {attached_node = 1, flammable = 1, sea = 1, snappy = 3},
        sounds = unilib.sound_table.leaves,

        drawtype = "plantlike",
        inventory_image = "unilib_plant_kelp_yellow_thick.png",
        is_ground_content = false,
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.2, -0.5, -0.2, 0.2, 0.5, 0.2},
        },
        sunlight_propagates = true,
        walkable = false,
        waving = 1,
    })

end
