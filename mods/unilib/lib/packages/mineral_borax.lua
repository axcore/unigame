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

unilib.pkg.mineral_borax = {}

local S = unilib.intllib
local pfaa_add_mode = unilib.imported_mod_table.pfaa.add_mode
local real_minerals_add_mode = unilib.imported_mod_table.real_minerals.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_borax.init()

    return {
        description = "Borax (as a mineral)",
        depends = "metal_boron",
    }

end

function unilib.pkg.mineral_borax.exec()

    local c_lump = "unilib:mineral_borax_lump"

    unilib.register_mineral({
        -- Original to unilib
        part_name = "borax",
        description = S("Borax"),

        hardness = 1,
        metal_list = {"boron"},
    })

    unilib.register_craftitem(c_lump, "real_minerals:borax", real_minerals_add_mode, {
        -- From real_minerals:borax
        description = S("Borax Lump"),
        inventory_image = "unilib_mineral_borax_lump.png",
    })
    if unilib.pkg_executed_table["metal_boron"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            type = "cooking",
            output = "unilib:metal_boron_chunk",
            recipe = c_lump,
        })

    end

end
