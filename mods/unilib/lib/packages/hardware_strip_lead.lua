---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    basic_materials
-- Code:    LGPL 3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.hardware_strip_lead = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.basic_materials.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.hardware_strip_lead.init()

    return {
        description = "Lead strip",
        depends = "metal_lead",
    }

end

function unilib.pkg.hardware_strip_lead.exec()

    unilib.register_craftitem("unilib:hardware_strip_lead", "basic_materials:lead_strip", mode, {
        -- From basic_materials:lead_strip
        description = S("Lead Strip"),
        inventory_image = "unilib_hardware_strip_lead.png",
        groups = {strip = 1},
    })
    unilib.register_craft({
        -- From basic_materials:lead_strip
        output = "unilib:hardware_strip_lead 12",
        recipe = {
            {"", "unilib:metal_lead_ingot", ""},
            {"unilib:metal_lead_ingot", "", ""},
        },
    })

end
