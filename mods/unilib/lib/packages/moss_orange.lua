---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.moss_orange = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.moss_orange.init()

    return {
        description = "Orange moss",
        notes = "Harvested from certain nodes by using a sickle",
        depends = "shared_sickles",
    }

end

function unilib.pkg.moss_orange.exec()

    unilib.pkg.shared_sickles.register_moss({
        -- Original to unilib. Creates unilib:moss_orange, etc
        part_name = "orange",
        orig_name = nil,
        block_orig_name = nil,
        description = S("Orange Moss"),
        block_description = S("Orange Moss Block"),
        dye = "orange",

        replace_mode = mode,
        tint = "#b0622e70",
    })

end
