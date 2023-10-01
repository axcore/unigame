---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    GLEMr11
-- Code:    LGPL 2.1
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.plant_cactus_prickly_pear = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.glemr11.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.plant_cactus_prickly_pear.init()

    return {
        description = "Prickly pear cactus",
    }

end

function unilib.pkg.plant_cactus_prickly_pear.exec()

    unilib.register_node(
        -- From GLEMr11, lib_ecology:cactus_prickly_pear
        "unilib:plant_cactus_prickly_pear",
        "lib_ecology:cactus_prickly_pear",
        mode,
        {
            description = S("Prickly Pear Cactus"),
            tiles = {"unilib_plant_cactus_prickly_pear.png"},
            groups = {
                attached_node = 1, flammable = 1, flora = 1, leaves = 1,
                oddly_breakable_by_hand = 1, snappy = 3,
            },
            -- N.B. No sounds in original code
            sounds = unilib.sound_table.leaves,

            buildable_to = false,
            damage_per_second = 1,
            drawtype = "plantlike",
            -- N.B. floodable no longer required, because of unilib's flooding effects
--          floodable = true,
            -- N.B. inventory_image not in original code
            inventory_image = "unilib_plant_cactus_prickly_pear.png",
            is_ground_content = false,
            paramtype = "light",
            selection_box = {
                type = "fixed",
                fixed = {-0.3, -0.5, -0.3, 0.3, 0, 0.3},
            },
            sunlight_propagates = true,
            visual_scale = 4,
            walkable = false,
            waving = 1,
            wield_scale = {x = 0.5, y = 0.5, z = 0.5},
        }
    )
    unilib.register_plant_in_pot(
        "unilib:plant_cactus_prickly_pear", "lib_ecology:cactus_prickly_pear"
    )

end
