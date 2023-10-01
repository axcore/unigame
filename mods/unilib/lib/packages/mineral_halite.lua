---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    PFAA
-- Code:    Artistic-2.0
-- Media:   Artistic-2.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_halite = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.pfaa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_halite.init()

    return {
        description = "Halite (as mineral)",
        optional = "metal_sodium",
    }

end

function unilib.pkg.mineral_halite.exec()

    local c_lump = "unilib:mineral_halite_lump"

    unilib.register_mineral({
        -- Original to unilib
        part_name = "halite",
        description = S("Halite"),

        hardness = 1,
        metal_list = {"sodium"},
    })

    unilib.register_craftitem(c_lump, nil, mode, {
        -- Original to unilib
        description = unilib.brackets(S("Halite Lump"), S("Rock Salt")),
        inventory_image = "unilib_mineral_halite_lump.png",
    })
    if unilib.pkg_executed_table["metal_sodium"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            type = "cooking",
            output = "unilib:metal_sodium_chunk",
            recipe = c_lump,
        })

    end

end
