---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_braid_garlic = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_braid_garlic.init()

    return {
        description = "Garlic braid",
        depends = "produce_garlic_normal",
    }

end

function unilib.pkg.misc_braid_garlic.exec()

    unilib.register_node("unilib:misc_braid_garlic", "farming:garlic_braid", mode, {
        -- From farming:garlic_braid
        description = S("Garlic Braid"),
        tiles = {
            "unilib_misc_braid_garlic_top.png",
            "unilib_misc_braid_garlic.png",
            "unilib_misc_braid_garlic_side.png^[transformFx",
            "unilib_misc_braid_garlic_side.png",
            "unilib_misc_braid_garlic.png",
            "unilib_misc_braid_garlic.png"
        },
        -- N.B. removed vessel = 1 from original code
--      groups = {dig_immediate = 3, flammable = 3, vessel = 1},
        groups = {dig_immediate = 3, flammable = 3},
        sounds = unilib.global.sound_table.leaves,

        drawtype = "nodebox",
        inventory_image = "unilib_misc_braid_garlic.png",
        -- N.B. is_ground_content = false not in original code
        is_ground_content = false,
        node_box = {
            type = "fixed",
            fixed = {
                    {-0.13, -0.45, 0.5, 0.13, 0.45, 0.24},
            },
        },
        paramtype = "light",
        paramtype2 = "facedir",
        use_texture_alpha = "clip",
        wield_image = "unilib_misc_braid_garlic.png",
    })
    unilib.register_craft_3x3({
        -- From farming:garlic_braid
        output = "unilib:misc_braid_garlic",
        ingredient = "unilib:produce_garlic_normal_harvest",
    })
    unilib.register_craft({
        -- From farming:garlic_braid
        type = "shapeless",
        output = "unilib:produce_garlic_normal_harvest 9",
        recipe = {"unilib:misc_braid_garlic"},
    })

end
