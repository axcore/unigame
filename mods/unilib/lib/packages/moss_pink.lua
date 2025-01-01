---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.moss_pink = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.moss_pink.init()

    return {
        description = "Pink moss",
        notes = "Harvested from certain nodes by using a sickle",
        depends = "shared_sickles",
    }

end

function unilib.pkg.moss_pink.exec()

    unilib.pkg.shared_sickles.register_moss({
        -- Original to unilib. Creates unilib:moss_pink, etc
        part_name = "pink",
        orig_name = nil,
        block_orig_name = nil,
        description = S("Pink Moss"),
        block_description = S("Pink Moss Block"),
        dye = "pink",

        replace_mode = mode,
        tint = "#df6d9b70",
    })

end
