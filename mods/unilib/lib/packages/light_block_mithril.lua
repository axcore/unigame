---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    morelamps
-- Code:    WTFPL
-- Media:   WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.light_block_mithril = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.morelamps.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.light_block_mithril.init()

    return {
        description = "Mithril lamp",
        depends = {"glass_ordinary", "mineral_mese"},
    }

end

function unilib.pkg.light_block_mithril.exec()

    unilib.register_node("unilib:light_block_mithril", "morelamps:mithril_lamp", mode, {
        -- From morelamps:mithril_lamp
        description = S("Mithril Lamp"),
        tiles = {"unilib_light_block_mithril.png"},
        groups = {cracky = 3, oddly_breakable_by_hand = 3},
        sounds = unilib.global.sound_table.glass,

        drawtype = "glasslike",
        is_ground_content = false,
        light_source = unilib.constant.light_max,
        paramtype = "light",
        sunlight_propagates = true,
    })
    unilib.register_craft({
        -- From morelamps:mithril_lamp
        output = "unilib:light_block_mithril",
        recipe = {
            {"unilib:glass_ordinary"},
            {"unilib:metal_mithril_ingot"},
        },
    })

end
