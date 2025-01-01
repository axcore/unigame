---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    darkage
-- Code:    WTFPL
-- Media:   WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.glass_glow_round = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.darkage.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.glass_glow_round.init()

    return {
        description = "Round glow glass",
        depends = {"glass_clean_round", "torch_ordinary"},
    }

end

function unilib.pkg.glass_glow_round.exec()

    unilib.register_node("unilib:glass_glow_round", "darkage:glow_glass_round", mode, {
        -- From darkage:glow_glass_round
        description = S("Round Glow Glass"),
        tiles = {"unilib_glass_glow_round.png"},
        groups = {cracky = 3, oddly_breakable_by_hand = 3},
        sounds = unilib.global.sound_table.glass,

        drawtype = "glasslike",
        inventory_image = core.inventorycube("unilib_glass_glow_round.png"),
        -- N.B. is_ground_content = false not in original code; added to match other glass items
        is_ground_content = false,
        light_source = unilib.constant.light_max - 3,
        paramtype = "light",
        sunlight_propagates = true,
        use_texture_alpha = "clip",
    })
    unilib.register_craft({
        -- From darkage:glow_glass_round
        type = "shaped",
        output = "unilib:glass_glow_round",
        recipe = {
            {"unilib:glass_clean_round"},
            {"unilib:torch_ordinary"},
        },
    })
    unilib.register_craft({
        -- From darkage:glow_glass_round
        output = "unilib:glass_clean_round",
        recipe = {
            {"unilib:glass_glow_round"},
        },
    })

end
