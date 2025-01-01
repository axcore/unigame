---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.moss_magenta = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.moss_magenta.init()

    return {
        description = "Magenta moss",
        notes = "Harvested from certain nodes by using a sickle",
        depends = "shared_sickles",
    }

end

function unilib.pkg.moss_magenta.exec()

    unilib.pkg.shared_sickles.register_moss({
        -- Original to unilib. Creates unilib:moss_magenta, etc
        part_name = "magenta",
        orig_name = nil,
        block_orig_name = nil,
        description = S("Magenta Moss"),
        block_description = S("Magenta Moss Block"),
        dye = "magenta",

        replace_mode = mode,
        tint = "#d64cdb70",
    })

end
