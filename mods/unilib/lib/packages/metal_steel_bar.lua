---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    basic_materials
-- Code:    LGPL 3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.metal_steel_bar = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.basic_materials.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.metal_steel_bar.init()

    return {
        description = "Steel bar",
        depends = "metal_steel",
    }

end

function unilib.pkg.metal_steel_bar.exec()

    unilib.register_craftitem("unilib:metal_steel_bar", "basic_materials:steel_bar", mode, {
        -- From basic_materials:steel_bar
        description = S("Steel Bar"),
        inventory_image = "unilib_metal_steel_bar.png",
    })
    unilib.register_craft( {
        -- From basic_materials:steel_bar
        output = "unilib:metal_steel_bar 6",
        recipe = {
            {"", "", "unilib:metal_steel_ingot"},
            {"", "unilib:metal_steel_ingot", ""},
            {"unilib:metal_steel_ingot", "", ""},
        },
    })

end
