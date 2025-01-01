---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    basic_materials
-- Code:    LGPL 3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.hardware_chainlink_brass = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.basic_materials.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.hardware_chainlink_brass.init()

    return {
        description = "Brass chainlinks",
        depends = "metal_brass",
    }

end

function unilib.pkg.hardware_chainlink_brass.exec()

    unilib.register_craftitem(
        -- From basic_materials:chainlink_brass
        "unilib:hardware_chainlink_brass",
        {"basic_materials:chainlink_brass", "homedecor:chainlink_brass"},
        mode,
        {
            description = S("Brass Chainlinks"),
            inventory_image = "unilib_hardware_chainlink_brass.png",
            groups = {chainlinks = 1},
        }
    )
    unilib.register_craft({
        -- From basic_materials:chainlink_brass
        output = "unilib:hardware_chainlink_brass 12",
        recipe = {
            {"", "unilib:metal_brass_ingot", "unilib:metal_brass_ingot"},
            {"unilib:metal_brass_ingot", "", "unilib:metal_brass_ingot"},
            {"unilib:metal_brass_ingot", "unilib:metal_brass_ingot", ""},
        },
    })

end
