---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    GLEMr11
-- Code:    LGPL 2.1
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.mushroom_parasol_shaggy = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.glemr11.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mushroom_parasol_shaggy.init()

    return {
        description = "Shaggy parasol mushroom",
    }

end

function unilib.pkg.mushroom_parasol_shaggy.exec()

    unilib.register_node("unilib:mushroom_parasol_shaggy", "lib_ecology:mushroom_parasol", mode, {
        -- From GLEMr11, lib_ecology:mushroom_parasol
        description = S("Parasol Mushroom"),
        tiles = {"unilib_mushroom_parasol_shaggy.png"},
        -- N.B. mushroom = 1 not in original code
        groups = {
            attached_node = 1, flammable = 1, flora = 1, leaves = 1, mushroom = 1,
            oddly_breakable_by_hand = 1, snappy = 3,
        },
        -- N.B. No sounds in original code
        sounds = unilib.global.sound_table.leaves,

        buildable_to = false,
        drawtype = "plantlike",
        -- N.B. floodable no longer required, because of unilib's flooding effects
--      floodable = true,
        -- N.B. removed is_ground_content = false to match other mushrooms
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
        wield_scale = {x = 0.5, y = 0.5, z = 0.5},
    })
    unilib.register_mushroom_in_pot(
        "unilib:mushroom_parasol_shaggy", "lib_ecology:mushroom_parasol"
    )

    unilib.register_decoration_spare("unilib:mushroom_parasol_shaggy")

end
