---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    towercrane
-- Code:    LGPL 2.1
-- Media:   CC0/CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.crane_mese = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.towercrane.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.crane_mese.init()

    return {
        description = "Mese crane",
        depends = {"metal_steel", "mineral_mese"},
    }

end

function unilib.pkg.crane_mese.exec()

    -- (This crane uses the original textures, but a different craft recipe)
    unilib.pkg.shared_towercrane.register_crane({
        -- From towercrane:base, etc. Creates unilib:crane_mese_base, etc
        part_name = "mese",
        orig_name = "towercrane:base",
        ingredient = "unilib:metal_steel_ingot",

        replace_mode = mode,
        description = S("Mese Crane"),
        max_height = 24,
        max_width = 24,
        minor_ingredient = "unilib:mineral_mese_block",
    })

end
