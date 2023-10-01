---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    basic_materials
-- Code:    LGPL 3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.metal_copper_strip = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.basic_materials.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.metal_copper_strip.init()

    return {
        description = "Copper strip",
        depends = "metal_copper",
    }

end

function unilib.pkg.metal_copper_strip.exec()

    unilib.register_craftitem("unilib:metal_copper_strip", "basic_materials:copper_strip", mode, {
        -- From basic_materials:copper_strip
        description = S("Copper Strip"),
        inventory_image = "unilib_metal_copper_strip.png",
        groups = {strip = 1},
    })
    unilib.register_craft( {
        -- From basic_materials:copper_strip
        output = "unilib:metal_copper_strip 12",
        recipe = {
            {"", "unilib:metal_copper_ingot", ""},
            {"unilib:metal_copper_ingot", "", ""},
        },
    })

end
