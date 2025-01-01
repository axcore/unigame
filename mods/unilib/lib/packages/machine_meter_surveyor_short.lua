---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ldm32
-- Code:    LGPL 2.1+
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.machine_meter_surveyor_short = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ldm32.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.machine_meter_surveyor_short.init()

    return {
        description = "Short-range surveyor's meter",
        depends = {"mineral_diamond", "shared_ldm32"},
    }

end

function unilib.pkg.machine_meter_surveyor_short.exec()

    unilib.pkg.shared_ldm32.register_meter_surveyor({
        -- Original to unilib. Creates unilib:machine_meter_surveyor_short
        part_name = "short",
        orig_name = nil,

        replace_mode = mode,
        beam_colour = "red",
        description = S("Short-Range Surveyor's Meter"),
        ingredient = "unilib:mineral_diamond_gem",
        max_range = 32,
    })

end
