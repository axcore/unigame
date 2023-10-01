---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    basic_materials
-- Code:    LGPL 3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.metal_steel_strip = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.basic_materials.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.metal_steel_strip.init()

    return {
        description = "Steel strip",
        depends = "metal_steel",
    }

end

function unilib.pkg.metal_steel_strip.exec()

    unilib.register_craftitem("unilib:metal_steel_strip", "basic_materials:steel_strip", mode, {
        -- From basic_materials:steel_strip
        description = S("Steel Strip"),
        inventory_image = "unilib_metal_steel_strip.png",
        groups = {strip = 1},
    })
    unilib.register_craft( {
        -- From basic_materials:steel_strip
        output = "unilib:metal_steel_strip 12",
        recipe = {
            {"", "unilib:metal_steel_ingot", ""},
            {"unilib:metal_steel_ingot", "", ""},
        },
    })

end
