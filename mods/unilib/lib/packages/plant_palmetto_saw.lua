---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    GLEMr4
-- Code:    LGPL 2.1
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.plant_palmetto_saw = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.glemr4.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.plant_palmetto_saw.init()

    return {
        description = "Saw palmetto",
    }

end

function unilib.pkg.plant_palmetto_saw.exec()

    unilib.register_node("unilib:plant_palmetto_saw", "lib_ecology:plant_palmetto_01", mode, {
        -- From GLEMr4, lib_ecology:plant_palmetto_01
        description = unilib.utils.annotate(S("Saw Palmetto"), "Serenoa repens"),
        tiles = {"unilib_plant_palmetto_saw.png"},
        groups = {attached_node = 1, flammable = 1, flora = 1, snappy = 3},
        sounds = unilib.global.sound_table.leaves,

        buildable_to = true,
        drawtype = "plantlike",
        -- N.B. floodable no longer required, because of unilib's flooding effects
--      floodable = true,
        -- N.B. inventory_image not in original code
        inventory_image = "unilib_plant_palmetto_saw.png",
        -- N.B. removed is_ground_content = false to match other plants
--      is_ground_content = false,
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.3, -0.5, -0.3, 0.3, 1, 0.3},
        },
        sunlight_propagates = true,
        visual_scale = 1.2,
        walkable = false,
        wield_scale = {x = 0.5, y = 0.5, z = 0.5},
    })
    unilib.register_plant_in_pot("unilib:plant_palmetto_saw", "lib_ecology:plant_palmetto_01")

    unilib.register_decoration_spare("unilib:plant_palmetto_saw")

end
