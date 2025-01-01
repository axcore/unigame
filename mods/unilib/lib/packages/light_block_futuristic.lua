---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    morelights/morelights_extras
-- Code:    LGPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.light_block_futuristic = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.morelights_extras.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.light_block_futuristic.init()

    return {
        description = "Futuristic lamp",
        depends = {"metal_steel", "mineral_mese", "light_bulb_normal", "pane_glass_ordinary"},
    }

end

function unilib.pkg.light_block_futuristic.exec()

    local c_fragment = "unilib:mineral_mese_crystal_fragment"
    local c_ingot = "unilib:metal_steel_ingot"
    local c_pane = "unilib:pane_glass_ordinary_flat"

    unilib.register_node("unilib:light_block_futuristic", "morelights_extras:f_block", mode, {
        -- From morelights_extras:f_block
        description = S("Futuristic Lamp"),
        tiles = {"unilib_light_block_futuristic.png"},
        groups = {cracky = 2, handy = 1, oddly_breakable_by_hand = 3},
        sounds = unilib.global.sound_table.glass,

        -- N.B. is_ground_content = false not in original code
        is_ground_content = false,
        light_source = unilib.constant.light_max,
        paramtype = "light",
    })
    unilib.register_craft({
        -- From morelights_extras:f_block
        output = "unilib:light_block_futuristic",
        recipe = {
            {c_fragment, c_ingot, c_fragment},
            {c_pane, "unilib:light_bulb_normal", c_pane},
            {c_fragment, c_ingot, c_fragment},
        },
    })

end
