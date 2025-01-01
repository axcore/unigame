---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    basic_materials
-- Code:    LGPL 3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.component_gear_steel = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.basic_materials.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.component_gear_steel.init()

    return {
        description = "Steel gear",
        depends = {"metal_steel", "hardware_chainlink_steel"},
        optional = "material_scrap_steel",
    }

end

function unilib.pkg.component_gear_steel.exec()

    local c_ingot = "unilib:metal_steel_ingot"

    unilib.register_craftitem(
        -- From basic_materials:gear_steel
        "unilib:component_gear_steel",
        {"basic_materials:gear_steel", "pipeworks:gear"},
        mode,
        {
            description = S("Steel Gear"),
            inventory_image = "unilib_component_gear_steel.png"
        }
    )
    unilib.register_craft( {
        -- From basic_materials:gear_steel
        output = "unilib:component_gear_steel 6",
        recipe = {
            {"", c_ingot, ""},
            {c_ingot, "unilib:hardware_chainlink_steel", c_ingot},
            {"", c_ingot, ""},
        },
    })
    if unilib.global.pkg_executed_table["material_scrap_steel"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            output = "unilib:material_scrap_steel",
            recipe = {
                {"unilib:component_gear_steel"},
            },
        })

    end

end
