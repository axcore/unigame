---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    basic_materials
-- Code:    LGPL 3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.component_gear_steel = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.basic_materials.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.component_gear_steel.init()

    return {
        description = "Steel gear",
        depends = {"metal_steel", "chain_steel"},
    }

end

function unilib.pkg.component_gear_steel.exec()

    local c_ingot = "unilib:metal_steel_ingot"

    unilib.register_craftitem("unilib:component_gear_steel", "basic_materials:gear_steel", mode, {
        -- From basic_materials:gear_steel
        description = S("Steel gear"),
        inventory_image = "unilib_component_gear_steel.png"
    })
    unilib.register_craft( {
        -- From basic_materials:gear_steel
        output = "unilib:component_gear_steel 6",
        recipe = {
            {"", c_ingot, ""},
            {c_ingot, "unilib:chain_steel_link", c_ingot},
            {"", c_ingot, ""}
        },
    })

end
