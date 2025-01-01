---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    AATO
-- Code:    GPL 3.0
-- Media:   GPL 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_hubnerite = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.aato.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_hubnerite.init()

    return {
        description = "Hubnerite (as mineral)",
        optional = "metal_tungsten",
    }

end

function unilib.pkg.mineral_hubnerite.exec()

    local c_lump = "unilib:mineral_hubnerite_lump"

    unilib.register_mineral({
        -- Original to unilib
        part_name = "hubnerite",
        description = S("Hubnerite"),

        hardness = 2,
        metal_list = {"tungsten"},
    })

    unilib.register_craftitem(c_lump, nil, mode, {
        -- Original texture (adapted from an AATO texture, hubnerite.png). Original code
        description = S("Hubnerite Lump"),
        inventory_image = "unilib_mineral_hubnerite_lump.png",
    })
    if unilib.global.pkg_executed_table["metal_tungsten"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            type = "cooking",
            output = "unilib:metal_tungsten_ingot",
            recipe = c_lump,
        })

    end

end
