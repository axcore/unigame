---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    technic/technic_worldgen
-- Code:    LGPL 2.0
-- Media:   unknown
--
-- From:    technic
-- Code:    LGPL 2.0
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_sulphur = {}

local S = unilib.intllib
local technic_add_mode = unilib.global.imported_mod_table.technic.add_mode
local worldgen_add_mode = unilib.global.imported_mod_table.technic_worldgen.add_moe

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_sulphur.init()

    return {
        description = "Sulphur (as a mineral)",
    }

end

function unilib.pkg.mineral_sulphur.exec()

    unilib.register_mineral({
        -- Original to unilib
        part_name = "sulphur",
        description = S("Sulphur"),

        hardness = 1,
        powder_flag = true,
    })

    unilib.register_craftitem(
        -- From technic:sulfur_lump
        "unilib:mineral_sulphur_lump",
        "technic:sulfur_lump",
        worldgen_add_mode,
        {
            description = S("Sulphur Lump"),
            inventory_image = "unilib_mineral_sulphur_lump.png",
        }
    )

    unilib.register_mineral_powder({
        -- From technic:sulfur_dust. Creates unilib:mineral_sulphur_powder
        part_name = "sulphur",
        orig_name = "technic:sulfur_dust",

        replace_mode = technic_add_mode,
        description = S("Sulphur Powder"),
    })

end
