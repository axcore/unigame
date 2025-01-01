---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.metal_iron = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.default.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.metal_iron.init()

    return {
        description = "Iron",
        notes = "Used in the production of steel",
    }

end

function unilib.pkg.metal_iron.exec()

    unilib.register_metal({
        -- Original to unilib
        part_name = "iron",
        description = S("Iron"),

        hardness = 2,
    })

    unilib.register_craftitem("unilib:metal_iron_lump", "default:iron_lump", mode, {
        -- From default:iron_lump
        description = S("Iron Lump"),
        inventory_image = "unilib_metal_iron_lump.png",
    })

end
