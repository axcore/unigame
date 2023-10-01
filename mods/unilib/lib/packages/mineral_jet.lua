---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    real_minerals
-- Code:    GPL 3.0
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_jet = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.real_minerals.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_jet.init()

    return {
        description = "Jet (as a mineral)",
    }

end

function unilib.pkg.mineral_jet.exec()

    unilib.register_mineral({
        -- Original to unilib
        part_name = "jet",
        description = S("Jet"),

        hardness = 1,
    })

    unilib.register_craftitem("unilib:mineral_jet_lump", "real_minerals:jet", mode, {
        -- From real_minerals:jet
        description = S("Jet Lump"),
        inventory_image = "unilib_mineral_jet_lump.png",
    })

end
