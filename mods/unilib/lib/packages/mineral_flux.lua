---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    real_minerals
-- Code:    GPL 3.0
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_flux = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.real_minerals.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_flux.init()

    return {
        description = "Flux (as a mineral)",
    }

end

function unilib.pkg.mineral_flux.exec()

    unilib.register_mineral({
        -- Original to unilib
        part_name = "flux",
        description = S("Flux"),

        hardness = 1,
    })

    unilib.register_craftitem("unilib:mineral_flux_lump", "real_minerals:flux", mode, {
        -- From real_minerals:flux
        description = S("Flux Lump"),
        inventory_image = "unilib_mineral_flux_lump.png",
    })

end
