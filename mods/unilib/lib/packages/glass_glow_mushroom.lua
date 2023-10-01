---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cucina_vegana
-- Code:    LGPL3.0
-- Media:   LGPL3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.glass_glow_mushroom = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.cucina_vegana.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.glass_glow_mushroom.init()

    return {
        description = "Mushroom glow glass",
        depends = {"glass_ordinary", "torch_ordinary"},
    }

end

function unilib.pkg.glass_glow_mushroom.exec()

    unilib.register_node("unilib:glass_glow_mushroom", "cucina_vegana:mushroomlight_glass", mode, {
        -- From cucina_vegana:mushroomlight_glass
        description = S("Mushroom Glow Glass"),
        tiles = {"unilib_glass_glow_mushroom.png", "unilib_glass_glow_mushroom_detail.png"},
        groups = {cracky = 3, oddly_breakable_by_hand = 3},
        sounds = unilib.sound_table.glass,

        drawtype = "glasslike_framed_optional",
        is_ground_content = false,
        light_source = 3,
        paramtype = "light",
        paramtype2 = "glasslikeliquidlevel",
        sunlight_propagates = true,
    })
    unilib.register_craft({
        -- From cucina_vegana:mushroomlight_glass
        output = "unilib:glass_glow_mushroom 4",
        recipe = {
            {"", "unilib:glass_ordinary", ""},
            {"unilib:glass_ordinary", "unilib:torch_ordinary", "unilib:glass_ordinary"},
            {"", "unilib:glass_ordinary", ""},
        },
    })

end
