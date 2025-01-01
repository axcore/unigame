---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    GLEMr11
-- Code:    LGPL 2.1
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.plant_heath_purple = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.glemr11.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.plant_heath_purple.init()

    return {
        description = "Purple heath plant",
    }

end

function unilib.pkg.plant_heath_purple.exec()

    unilib.register_node("unilib:plant_heath_purple", "lib_ecology:plant_heath_purple", mode, {
        -- From GLEMr11, lib_ecology:plant_heath_purple
        description = unilib.utils.annotate(S("Purple Heath Plant"), "Erica"),
        tiles = {"unilib_plant_heath_purple.png"},
        groups = {
            attached_node = 1, flammable = 1, flora = 1, leaves = 1, oddly_breakable_by_hand = 1,
            snappy = 3,
        },
        -- N.B. No sounds in original code
        sounds = unilib.global.sound_table.leaves,

        buildable_to = false,
        drawtype = "plantlike",
        -- N.B. floodable no longer required, because of unilib's flooding effects
--      floodable = true,
        -- N.B. inventory_image not in original code
        inventory_image = "unilib_plant_heath_purple.png",
        -- N.B. removed is_ground_content = false to match other plants
--      is_ground_content = false,
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.3, -0.5, -0.3, 0.3, 0, 0.3},
        },
        sunlight_propagates = true,
        visual_scale = 2,
        walkable = false,
        waving = 1,
    })
    unilib.register_plant_in_pot("unilib:plant_heath_purple", "lib_ecology:plant_heath_purple")

    unilib.register_decoration_spare("unilib:plant_heath_purple")

end
