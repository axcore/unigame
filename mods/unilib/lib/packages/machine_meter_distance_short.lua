---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ldm32
-- Code:    LGPL 2.1+
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.machine_meter_distance_short = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ldm32.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.machine_meter_distance_short.init()

    return {
        description = "Short-range distance meter",
        depends = {"mineral_mese", "shared_ldm32"},
    }

end

function unilib.pkg.machine_meter_distance_short.exec()

    unilib.pkg.shared_ldm32.register_meter_distance({
        -- From ldm32:casing. Creates unilib:machine_meter_distance_short
        part_name = "short",
        orig_name = "ldm32:casing",

        replace_mode = mode,
        beam_colour = "blue",
        description = S("Short-Range Distance Meter"),
        ingredient = "unilib:mineral_mese_crystal",
        max_range = 32,
    })

end
