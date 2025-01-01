---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.light_block_mese = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.default.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.light_block_mese.init()

    return {
        description = "Mese lamp",
        depends = {"glass_ordinary", "mineral_mese"},
    }

end

function unilib.pkg.light_block_mese.exec()

    unilib.register_node("unilib:light_block_mese", "default:meselamp", mode, {
        -- From default:meselamp
        description = S("Mese Lamp"),
        tiles = {"unilib_light_block_mese.png"},
        groups = {cracky = 3, oddly_breakable_by_hand = 3},
        sounds = unilib.global.sound_table.glass,

        drawtype = "glasslike",
        is_ground_content = false,
        light_source = unilib.constant.light_max,
        paramtype = "light",
        sunlight_propagates = true,
    })
    unilib.register_craft({
        -- From default:meselamp
        output = "unilib:light_block_mese",
        recipe = {
            {"unilib:glass_ordinary"},
            {"unilib:mineral_mese_crystal"},
        },
    })

end
