---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_stibnite = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_stibnite.init()

    return {
        description = "Stibnite (as mineral)",
        optional = "metal_antimony",
    }

end

function unilib.pkg.mineral_stibnite.exec()

    unilib.register_mineral({
        -- Original to unilib
        part_name = "stibnite",
        description = S("Stibnite"),

        hardness = 1,
        metal_list = {"antimony"},
    })

    unilib.register_craftitem("unilib:mineral_stibnite_lump", nil, mode, {
        -- Original to unilib
        description = S("Stibnite Lump"),
        inventory_image = "unilib_mineral_stibnite_lump.png",
    })
    if unilib.global.pkg_executed_table["metal_antimony"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            type = "cooking",
            output = "unilib:metal_antimony_chunk",
            recipe = "unilib:mineral_stibnite_lump",
        })

    end

end
