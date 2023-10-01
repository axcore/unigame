---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    basic_materials
-- Code:    LGPL 3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.material_concrete_industrial = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.basic_materials.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.material_concrete_industrial.init()

    return {
        description = "Industrial concrete",
        depends = {"gravel_ordinary", "material_cement_industrial", "metal_steel_bar"},
    }

end

function unilib.pkg.material_concrete_industrial.exec()

    unilib.register_node(
        -- From basic_materials:concrete_block
        "unilib:material_concrete_industrial_block",
        {"basic_materials:concrete_block", "technic:concrete"},
        mode,
        {
            description = S("Industrial Concrete Block"),
            tiles = {"unilib_material_concrete_industrial_block.png"},
            groups = {concrete = 1, cracky = 1, level = 2},
            sounds = unilib.sound_table.stone,
        }
    )
    unilib.register_craft({
        -- From basic_materials:concrete_block
        output = "unilib:material_concrete_industrial_block",
        recipe = {
            {
                "group:sand",
                "unilib:material_cement_industrial_wet",
                "unilib:gravel_ordinary",
            },
            {
                "unilib:metal_steel_bar",
                "unilib:material_cement_industrial_wet",
                "unilib:metal_steel_bar",
            },
            {
                "unilib:gravel_ordinary",
                "unilib:material_cement_industrial_wet",
                "group:sand",
            },
        }
    })

end
