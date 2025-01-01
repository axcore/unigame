---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_spodumene = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_spodumene.init()

    return {
        description = "Spodumene (as mineral)",
        optional = "metal_lithium",
    }

end

function unilib.pkg.mineral_spodumene.exec()

    unilib.register_mineral({
        -- Original to unilib
        part_name = "spodumene",
        description = S("Spodumene"),

        hardness = 3,
        metal_list = {"lithium"},
    })

    unilib.register_craftitem("unilib:mineral_spodumene_lump", nil, mode, {
        -- Original to unilib
        description = S("Spodumene Lump"),
        inventory_image = "unilib_mineral_spodumene_lump.png",
    })
    if unilib.global.pkg_executed_table["metal_lithium"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            type = "cooking",
            output = "unilib:metal_lithium_chunk",
            recipe = "unilib:mineral_spodumene_lump",
        })

    end

end
