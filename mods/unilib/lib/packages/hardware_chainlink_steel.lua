---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    basic_materials
-- Code:    LGPL 3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.hardware_chainlink_steel = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.basic_materials.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.hardware_chainlink_steel.init()

    return {
        description = "Steel chainlinks",
        depends = "metal_steel",
        optional = "material_scrap_steel",
    }

end

function unilib.pkg.hardware_chainlink_steel.exec()

    unilib.register_craftitem(
        -- From basic_materials:chainlink_steel
        "unilib:hardware_chainlink_steel",
        {"basic_materials:chainlink_steel", "glooptest:chainlink", "homedecor:chainlink_steel"},
        mode,
        {
            description = S("Steel Chainlinks"),
            inventory_image = "unilib_hardware_chainlink_steel.png",
            groups = {chainlinks = 1},
        }
    )
    unilib.register_craft({
        -- From basic_materials:chainlink_steel
        output = "unilib:hardware_chainlink_steel 12",
        recipe = {
            {"", "unilib:metal_steel_ingot", "unilib:metal_steel_ingot"},
            {"unilib:metal_steel_ingot", "", "unilib:metal_steel_ingot"},
            {"unilib:metal_steel_ingot", "unilib:metal_steel_ingot", ""},
        },
    })
    if unilib.global.pkg_executed_table["material_scrap_steel"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            output = "unilib:material_scrap_steel",
            recipe = {
                {"unilib:hardware_chainlink_steel"},
            },
        })

    end

end
