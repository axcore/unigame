---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    PFAA
-- Code:    Artistic-2.0
-- Media:   Artistic-2.0
--
-- From:    real_minerals
-- Code:    GPL 3.0
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_gypsum = {}

local S = unilib.intllib
local pfaa_add_mode = unilib.imported_mod_table.pfaa.add_mode
local real_minerals_add_mode = unilib.imported_mod_table.real_minerals.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_gypsum.init()

    return {
        description = "Gypsum (as a mineral)",
    }

end

function unilib.pkg.mineral_gypsum.exec()

    local c_lump = "unilib:mineral_gypsum_lump"

    unilib.register_mineral({
        -- Original to unilib
        part_name = "gypsum",
        description = S("Gypsum"),

        hardness = 1,
    })

    unilib.register_craftitem(c_lump, "real_minerals:gypsum", real_minerals_add_mode, {
        -- From real_minerals:gypsum
        description = S("Gypsum Lump"),
        inventory_image = "unilib_mineral_gypsum_lump.png",
    })

end
