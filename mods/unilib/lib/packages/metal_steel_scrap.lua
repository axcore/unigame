---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    steel
-- Code:    GPL-2.0
-- Media:   CC-BY-SA-4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.metal_steel_scrap = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.steel.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.metal_steel_scrap.init()

    return {
        description = "Scrap metal steel",
        notes = "Various steel items can be recycled into scrap steel, which can then be used" ..
                " to craft iron lumps",
        depends = "metal_iron",
    }

end

function unilib.pkg.metal_steel_scrap.exec()

    unilib.register_craftitem("unilib:metal_steel_scrap", "steel:scrap", mode, {
        -- From steel:scrap
        description = S("Scrap Metal Steel"),
        inventory_image = "unilib_metal_steel_scrap.png",
    })
    unilib.register_craft({
        -- From steel:scrap
        output = "unilib:metal_iron_lump",
        recipe = {
            {"unilib:metal_steel_scrap", "unilib:metal_steel_scrap"},
        },
    })

end
