---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    steel
-- Code:    GPL-2.0
-- Media:   CC-BY-SA-4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.material_scrap_steel = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.steel.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.material_scrap_steel.init()

    return {
        description = "Scrap metal steel",
        notes = "Various steel items can be recycled into scrap steel, which can then be used to" ..
                " craft iron lumps",
        depends = "metal_iron",
    }

end

function unilib.pkg.material_scrap_steel.exec()

    unilib.register_craftitem("unilib:material_scrap_steel", "steel:scrap", mode, {
        -- From steel:scrap
        description = S("Scrap Metal Steel"),
        inventory_image = "unilib_material_scrap_steel.png",
    })
    unilib.register_craft({
        -- From steel:scrap
        output = "unilib:metal_iron_lump",
        recipe = {
            {"unilib:material_scrap_steel", "unilib:material_scrap_steel"},
        },
    })

end
