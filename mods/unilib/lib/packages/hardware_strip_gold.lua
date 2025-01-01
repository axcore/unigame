---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    basic_materials
-- Code:    LGPL 3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.hardware_strip_gold = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.basic_materials.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.hardware_strip_gold.init()

    return {
        description = "Gold strip",
        depends = "metal_gold",
    }

end

function unilib.pkg.hardware_strip_gold.exec()

    unilib.register_craftitem("unilib:hardware_strip_gold", "basic_materials:gold_strip", mode, {
        -- From basic_materials:gold_strip
        description = S("Gold Strip"),
        inventory_image = "unilib_hardware_strip_gold.png",
        groups = {strip = 1},
    })
    unilib.register_craft({
        -- From basic_materials:gold_strip
        output = "unilib:hardware_strip_gold 12",
        recipe = {
            {"", "unilib:metal_gold_ingot", ""},
            {"unilib:metal_gold_ingot", "", ""},
        },
    })

end
