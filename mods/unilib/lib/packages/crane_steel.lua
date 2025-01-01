---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    towercrane
-- Code:    LGPL 2.1
-- Media:   CC0/CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.crane_steel = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.towercrane.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.crane_steel.init()

    return {
        description = "Steel crane",
        depends = "metal_steel",
    }

end

function unilib.pkg.crane_steel.exec()

    unilib.pkg.shared_towercrane.register_crane({
        -- Original to unilib. Creates unilib:crane_steel_base, etc
        part_name = "steel",
        orig_name = nil,
        ingredient = "unilib:metal_steel_ingot",

        replace_mode = mode,
        description = S("Steel Crane"),
        max_height = 16,
        max_width = 16,
    })

end
