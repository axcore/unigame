---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    basic_materials
-- Code:    LGPL 3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.hardware_bar_steel = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.basic_materials.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.hardware_bar_steel.init()

    return {
        description = "Steel bar",
        depends = "metal_steel",
        optional = "material_scrap_steel",
    }

end

function unilib.pkg.hardware_bar_steel.exec()

    unilib.register_craftitem(
        -- From basic_materials:steel_bar
        "unilib:hardware_bar_steel",
        {"basic_materials:steel_bar", "technic:rebar"},
        mode,
        {
            description = S("Steel Bar"),
            inventory_image = "unilib_hardware_bar_steel.png",
        }
    )
    unilib.register_craft( {
        -- From basic_materials:steel_bar
        output = "unilib:hardware_bar_steel 6",
        recipe = {
            {"", "", "unilib:metal_steel_ingot"},
            {"", "unilib:metal_steel_ingot", ""},
            {"unilib:metal_steel_ingot", "", ""},
        },
    })
    if unilib.global.pkg_executed_table["material_scrap_steel"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            output = "unilib:material_scrap_steel",
            recipe = {
                {"unilib:hardware_bar_steel"},
            },
        })

    end

end
