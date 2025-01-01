---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    underch
-- Code:    CC0
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.light_block_sichamine = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.underch.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.light_block_sichamine.init()

    return {
        description = "Sichamine lamp",
        depends = {"mineral_mese", "stone_sichamine"},
    }

end

function unilib.pkg.light_block_sichamine.exec()

    local c_mese_crystal = "unilib:mineral_mese_crystal"

    unilib.register_node("unilib:light_block_sichamine", "underch:sichamine_lamp", mode, {
        -- From underch:sichamine_lamp
        description = S("Sichamine Lamp"),
        tiles = {"unilib_light_block_sichamine.png"},
        groups = {cracky = 3, oddly_breakable_by_hand = 3},
        sounds = unilib.global.sound_table.glass,

        light_source = unilib.constant.light_max,
        paramtype = "light",
        sunlight_propagates = true,
    })
    unilib.register_craft({
        -- From underch:sichamine_lamp
        output = "unilib:light_block_sichamine",
        recipe = {
            {"", c_mese_crystal, ""},
            {c_mese_crystal, "unilib:stone_sichamine", c_mese_crystal},
        },
    })

end
