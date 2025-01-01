---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    GLEMr4
-- Code:    LGPL 2.1
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.plant_shrub_scorched = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.glemr4.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.plant_shrub_scorched.init()

    return {
        description = "Scorched shrub",
    }

end

function unilib.pkg.plant_shrub_scorched.exec()

    unilib.register_node("unilib:plant_shrub_scorched", "lib_ecology:plant_shrub_scorched", mode, {
        -- From GLEMr4, lib_ecology:plant_shrub_scorched
        description = S("Scorched Shrub"),
        tiles = {"unilib_plant_shrub_scorched.png"},
        -- N.B. flora = 1 not in original code
        groups = {flammable = 1, flora = 1, leaves = 1, oddly_breakable_by_hand = 1, snappy = 3},
        sounds = unilib.global.sound_table.leaves,

        drawtype = "plantlike",
        -- N.B. floodable no longer required, because of unilib's flooding effects
--      floodable = true,
        -- N.B. inventory_image not in original code
        inventory_image = "unilib_plant_shrub_scorched.png",
        -- N.B. removed is_ground_content = false to match other plants
--      is_ground_content = false,
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.4, -0.4, -0.4, 0.4, 0.4, 0.4},
        },
        sunlight_propagates = false,
        visual_scale = 1.2,
        walkable = false,
        waving = 1,
    })
    unilib.register_plant_in_pot("unilib:plant_shrub_scorched", "lib_ecology:plant_shrub_scorched")

    unilib.register_decoration_spare("unilib:plant_shrub_scorched")

end
