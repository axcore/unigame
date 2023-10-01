---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    towercrane
-- Code:    LGPL 2.1
-- Media:   CC0/CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.crane_diamond = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.towercrane.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.crane_diamond.init()

    return {
        description = "Diamond crane",
        depends = {"metal_steel", "mineral_diamond"},
    }

end

function unilib.pkg.crane_diamond.exec()

    unilib.pkg.shared_towercrane.register_crane({
        -- Original to unilib. Creates unilib:crane_diamond_base, etc
        part_name = "diamond",
        orig_name = nil,
        ingredient = "unilib:metal_steel_ingot",

        replace_mode = mode,
        description = S("Diamond Crane"),
        max_height = 32,
        max_width = 32,
        minor_ingredient = "unilib:mineral_diamond_block",
    })

end
