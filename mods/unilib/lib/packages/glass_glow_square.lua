---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    darkage
-- Code:    WTFPL
-- Media:   WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.glass_glow_square = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.darkage.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.glass_glow_square.init()

    return {
        description = "Square glow glass",
        depends = {"glass_clean_square", "torch_ordinary"},
    }

end

function unilib.pkg.glass_glow_square.exec()

    unilib.register_node("unilib:glass_glow_square", "darkage:glow_glass_square", mode, {
        -- From darkage:glow_glass_square
        description = S("Square Glow Glass"),
        tiles = {"unilib_glass_glow_square.png"},
        groups = {cracky = 3, oddly_breakable_by_hand = 3},
        sounds = unilib.sound_table.glass,

        drawtype = "glasslike",
        inventory_image = minetest.inventorycube("unilib_glass_glow_square.png"),
        light_source = unilib.light_max - 3,
        paramtype = "light",
        sunlight_propagates = true,
        use_texture_alpha = "clip",
    })
    unilib.register_craft({
        -- From darkage:glow_glass_square
        type = "shaped",
        output = "unilib:glass_glow_square",
        recipe = {
            {"unilib:glass_clean_square"},
            {"unilib:torch_ordinary"}
        }
    })
    unilib.register_craft({
        -- From darkage:glow_glass_square
        output = "unilib:glass_clean_square",
        recipe = {
            {"unilib:glass_glow_square"},
        }
    })

end
