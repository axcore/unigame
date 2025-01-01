---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.moss_white = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.moss_white.init()

    return {
        description = "White moss",
        notes = "Harvested from certain nodes by using a sickle",
        depends = "shared_sickles",
    }

end

function unilib.pkg.moss_white.exec()

    unilib.pkg.shared_sickles.register_moss({
        -- Original to unilib. Creates unilib:moss_white, etc
        part_name = "white",
        orig_name = nil,
        block_orig_name = nil,
        description = S("White Moss"),
        block_description = S("White Moss Block"),
        dye = "white",

        replace_mode = mode,
        tint = "#FFFFFF70",
    })

end
