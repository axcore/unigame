---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    GLEMr11
-- Code:    LGPL 2.1
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.mushroom_shaggy_mane = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.glemr11.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mushroom_shaggy_mane.init()

    return {
        description = "Shaggy mane mushroom",
    }

end

function unilib.pkg.mushroom_shaggy_mane.exec()

    unilib.register_node("unilib:mushroom_shaggy_mane", "lib_ecology:mushroom_shaggy_mane", mode, {
        -- From GLEMr11, lib_ecology:mushroom_shaggy_mane
        description = S("Shaggy Mane Mushroom"),
        tiles = {"unilib_mushroom_shaggy_mane.png"},
        -- N.B. mushroom = 1 not in original code
        groups = {
            attached_node = 1, flammable = 1, flora = 1, leaves = 1, mushroom = 1,
            oddly_breakable_by_hand = 1, snappy = 3,
        },
        -- N.B. No sounds in original code
        sounds = unilib.sound_table.leaves,

        buildable_to = false,
        drawtype = "plantlike",
        -- N.B. floodable no longer required, because of unilib's flooding effects
--      floodable = true,
        -- N.B. inventory_image not in original code
        inventory_image = "unilib_mushroom_shaggy_mane.png",
        is_ground_content = false,
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.3, -0.5, -0.3, 0.3, 0, 0.3},
        },
        sunlight_propagates = true,
        visual_scale = 2,
        walkable = false,
        waving = 1,
        wield_scale = {x = 0.5, y = 0.5, z = 0.5},
    })
    unilib.register_mushroom_in_pot(
        "unilib:mushroom_shaggy_mane", "lib_ecology:mushroom_shaggy_mane"
    )

end
