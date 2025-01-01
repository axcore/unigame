---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    bbq
-- Code:    LGPL-2.1+
-- Media:   CC-BY-SA-3.0/CC-BY-3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_bag_charcoal = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.bbq.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_bag_charcoal.init()

    return {
        description = "Bag of charcoal",
        notes = "Once crafted, can be used as a fuel",
        depends = "material_charcoal_artificial_briquette",
    }

end

function unilib.pkg.misc_bag_charcoal.exec()

    unilib.register_node("unilib:misc_bag_charcoal", "bbq:charcoal_bag", mode, {
        -- From bbq:charcoal_bag
        description = S("Bag of Charcoal"),
        tiles = {
            "unilib_misc_bag_charcoal_top.png",
            "unilib_misc_bag_charcoal_top.png",
            "unilib_misc_bag_charcoal_side.png",
            "unilib_misc_bag_charcoal_side.png",
            "unilib_misc_bag_charcoal_back.png",
            "unilib_misc_bag_charcoal.png",
        },
        groups = {attached_node = 1, dig_immediate = 3},
        sounds = unilib.global.sound_table.leaves,

        drawtype = "nodebox",
        inventory_image = "unilib_misc_bag_charcoal.png",
        -- N.B. is_ground_content = false not in original code
        is_ground_content = false,
        node_box = {
            type = "fixed",
            fixed = {
                {-0.21, -0.5, -0.1, 0.21, 0.22, 0.1},
                {-0.235, 0.22, -0.025, 0.235, 0.25, 0.025},
            },
        },
        paramtype = "light",
        paramtype2 = "facedir",
        sunlight_propagates = true,
        use_texture_alpha = "clip",
        wield_image = "unilib_misc_bag_charcoal.png",
    })
    unilib.register_craft_3x3({
        -- From bbq:charcoal_bag
        output = "unilib:misc_bag_charcoal",
        ingredient = "unilib:material_charcoal_artificial_briquette",
    })
    unilib.register_craft({
        -- From bbq:charcoal_bag
        type = "fuel",
        recipe = "unilib:misc_bag_charcoal",
        burntime = 150,
    })

end
