---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ldm32
-- Code:    LGPL 2.1+
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.machine_meter_distance_medium = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ldm32.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.machine_meter_distance_medium.init()

    return {
        description = "Medium-range distance meter",
        depends = {"mineral_mese", "shared_ldm32"},
    }

end

function unilib.pkg.machine_meter_distance_medium.exec()

    unilib.pkg.shared_ldm32.register_meter_distance({
        -- Original to unilib. Creates unilib:machine_meter_distance_medium
        part_name = "medium",
        orig_name = nil,

        replace_mode = mode,
        beam_colour = "green",
        description = S("Medium-Range Distance Meter"),
        ingredient = "unilib:mineral_mese_crystal",
        max_range = 64,
    })

end
