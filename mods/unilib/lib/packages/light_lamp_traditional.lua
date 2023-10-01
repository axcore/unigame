---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xdecor
-- Code:    BSD
-- Media:   WTFPL/CC BY-SA/CC BY 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.light_lamp_traditional = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.xdecor.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.light_lamp_traditional.init()

    return {
        description = "Traditional lamp",
        depends = {"metal_iron", "torch_ordinary"},
    }

end

function unilib.pkg.light_lamp_traditional.exec()

    unilib.register_node("unilib:light_lamp_traditional", "xdecor:lantern", mode, {
        -- From xdecor:lantern
        description = S("Traditional Lantern"),
        tiles = {
            {
                name = "unilib_light_lamp_traditional.png",
                animation = {
                    type = "vertical_frames",
                    length = 1.5,
                },
            },
        },
        groups = {attached_node = 1, snappy = 3},
        sounds = unilib.sound_table.node,

        drawtype = "plantlike",
        inventory_image = "unilib_light_lamp_traditional_inv.png",
        light_source = 13,
        paramtype = "light",
        paramtype2 = "wallmounted",
        selection_box = {
            type = "fixed",
            fixed = {
                {-0.25, -0.5, -0.25, 0.25, 0.5, 0.25},
            },
        },
        sunlight_propagates = true,
        walkable = false,
        wield_image = "unilib_light_lamp_traditional_inv.png",
    })
    unilib.register_craft({
        -- From xdecor:lantern
        output = "unilib:light_lamp_traditional",
        recipe = {
            {"unilib:metal_iron_lump"},
            {"unilib:torch_ordinary"},
            {"unilib:metal_iron_lump"},
        },
    })

end
