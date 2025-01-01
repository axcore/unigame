---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_scheelite = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_scheelite.init()

    return {
        description = "Scheelite (as mineral)",
        optional = "metal_tungsten",
    }

end

function unilib.pkg.mineral_scheelite.exec()

    unilib.register_mineral({
        -- Original to unilib
        part_name = "scheelite",
        description = S("Scheelite"),

        hardness = 2,
        metal_list = {"tungsten"},
    })

    unilib.register_craftitem("unilib:mineral_scheelite_lump", nil, mode, {
        -- Original to unilib
        description = S("Scheelite Lump"),
        inventory_image = "unilib_mineral_scheelite_lump.png",
    })
    if unilib.global.pkg_executed_table["metal_tungsten"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            type = "cooking",
            output = "unilib:metal_tungsten_ingot",
            recipe = "unilib:mineral_scheelite_lump",
        })

    end

end
