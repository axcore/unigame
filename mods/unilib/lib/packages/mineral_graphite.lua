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

unilib.pkg.mineral_graphite = {}

local S = unilib.intllib
local pfaa_add_mode = unilib.global.imported_mod_table.pfaa.add_mode
local real_minerals_add_mode = unilib.global.imported_mod_table.real_minerals.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_graphite.init()

    return {
        description = "Graphite (as a mineral)",
    }

end

function unilib.pkg.mineral_graphite.exec()

    local c_lump = "unilib:mineral_graphite_lump"

    unilib.register_mineral({
        -- Original to unilib
        part_name = "graphite",
        description = S("Graphite"),

        combustible_flag = true,
        hardness = 1,
    })

    unilib.register_craftitem(c_lump, "real_minerals:graphite", real_minerals_add_mode, {
        -- From real_minerals:graphite
        description = S("Graphite Lump"),
        inventory_image = "unilib_mineral_graphite_lump.png",
    })
    unilib.register_craft({
        -- From real_minerals:graphite
        type = "fuel",
        recipe = "unilib:mineral_graphite_lump",
        burntime = 20,
    })

end
