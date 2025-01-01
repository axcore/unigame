---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_wolframite = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_wolframite.init()

    return {
        description = "Wolframite (as mineral)",
        optional = "metal_tungsten",
    }

end

function unilib.pkg.mineral_wolframite.exec()

    unilib.register_mineral({
        -- Original to unilib
        part_name = "wolframite",
        description = S("Wolframite"),

        hardness = 2,
        metal_list = {"tungsten"},
    })

    unilib.register_craftitem("unilib:mineral_wolframite_lump", nil, mode, {
        -- Original to unilib, but the mineral overlay that drops this lump comes from PFAA
        description = S("Wolframite Lump"),
        inventory_image = "unilib_mineral_wolframite_lump.png",
    })
    if unilib.global.pkg_executed_table["metal_tungsten"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            type = "cooking",
            output = "unilib:metal_tungsten_ingot",
            recipe = "unilib:mineral_wolframite_lump",
        })

    end

end
