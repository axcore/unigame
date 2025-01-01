---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    mtg_plus
-- Code:    MIT
-- Media:   CC-BY-SA 3.0/CC-BY 3.0/MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.glass_gold = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.mtg_plus.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.glass_gold.init()

    return {
        description = "Gold glass",
        depends = {"glass_ordinary", "metal_gold"},
    }

end

function unilib.pkg.glass_gold.exec()

    unilib.register_node("unilib:glass_gold", "mtg_plus:goldglass", mode, {
        -- From mtg_plus:goldglass
        description = S("Gold Glass"),
        tiles = {"unilib_glass_gold.png", "unilib_glass_gold_detail.png"},
        groups = {cracky = 3, oddly_breakable_by_hand = 2},
        sounds = unilib.global.sound_table.glass,

        drawtype = "glasslike_framed_optional",
        is_ground_content = false,
        paramtype = "light",
        sunlight_propagates = true,
    })
    unilib.register_craft({
        -- From mtg_plus:goldglass
        output = "unilib:glass_gold",
        recipe = {
            {"unilib:metal_gold_ingot"},
            {"unilib:glass_ordinary"},
            {"unilib:metal_gold_ingot"},
        },
    })
    unilib.register_stairs("unilib:glass_gold", {
        glass_flag = true,
    })
    unilib.register_carvings("unilib:glass_gold", {
        millwork_flag = true,
    })

end
