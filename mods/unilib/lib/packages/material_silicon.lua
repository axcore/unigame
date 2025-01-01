---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    basic_materials
-- Code:    LGPL 3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.material_silicon = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.basic_materials.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.material_silicon.init()

    return {
        description = "Silicon",
        depends = {"metal_steel", "sand_ordinary"},
    }

end

function unilib.pkg.material_silicon.exec()

    unilib.register_craftitem(
        -- From basic_materials:silicon
        "unilib:material_silicon_lump",
        {"basic_materials:silicon", "mesecons_materials:silicon"},
        mode,
        {
            description = S("Silicon Lump"),
            inventory_image = "unilib_material_silicon_lump.png",
        }
    )
    unilib.register_craft( {
        -- From basic_materials:silicon
        output = "unilib:material_silicon_lump 4",
        recipe = {
            {"unilib:sand_ordinary", "unilib:sand_ordinary"},
            {"unilib:sand_ordinary", "unilib:metal_steel_ingot"},
        },
    })

end
