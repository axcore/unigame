---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    darkage
-- Code:    WTFPL
-- Media:   WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.glass_glow_rhombus = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.darkage.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.glass_glow_rhombus.init()

    return {
        description = "Rhombus glow glass",
        depends = {"glass_clean_rhombus", "torch_ordinary"},
    }

end

function unilib.pkg.glass_glow_rhombus.exec()

    unilib.register_node("unilib:glass_glow_rhombus", "darkage:glow_glass", mode, {
        -- From darkage:glow_glass
        description = S("Rhombus Glow Glass"),
        tiles = {"unilib_glass_glow_rhombus.png"},
        groups = {cracky = 3, oddly_breakable_by_hand = 3},
        sounds = unilib.global.sound_table.glass,

        drawtype = "glasslike",
        inventory_image = core.inventorycube("unilib_glass_glow_rhombus.png"),
        -- N.B. is_ground_content = false not in original code; added to match other glass items
        is_ground_content = false,
        light_source = unilib.constant.light_max - 3,
        paramtype = "light",
        sunlight_propagates = true,
        use_texture_alpha = "clip",

    })
    unilib.register_craft({
        -- From darkage:glow_glass
        type = "shaped",
        output = "unilib:glass_glow_rhombus",
        recipe = {
            {"unilib:glass_clean_rhombus"},
            {"unilib:torch_ordinary"},
        },
    })
    unilib.register_craft({
        -- From darkage:glow_glass
        type = "shaped",
        output = "unilib:glass_clean_rhombus",
        recipe = {
            {"unilib:glass_glow_rhombus"},
        },
    })

end
