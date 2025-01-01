---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    basic_materials
-- Code:    LGPL 3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.hardware_strip_steel = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.basic_materials.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.hardware_strip_steel.init()

    return {
        description = "Steel strip",
        depends = "metal_steel",
        optional = "material_scrap_steel",
    }

end

function unilib.pkg.hardware_strip_steel.exec()

    unilib.register_craftitem(
        -- From basic_materials:steel_strip
        "unilib:hardware_strip_steel",
        {"basic_materials:steel_strip", "homedecor:steel_strip"},
        mode,
        {
            description = S("Steel Strip"),
            inventory_image = "unilib_hardware_strip_steel.png",
            groups = {strip = 1},
        }
    )
    unilib.register_craft( {
        -- From basic_materials:steel_strip
        output = "unilib:hardware_strip_steel 12",
        recipe = {
            {"", "unilib:metal_steel_ingot", ""},
            {"unilib:metal_steel_ingot", "", ""},
        },
    })
    if unilib.global.pkg_executed_table["material_scrap_steel"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            output = "unilib:material_scrap_steel",
            recipe = {
                {"unilib:hardware_strip_steel"},
            },
        })

    end

end
