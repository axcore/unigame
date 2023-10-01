---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    sickles
-- Code:    LGPL v3
-- Media:   CC BY-SA 3.0/4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.moss_purple = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.sickles.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.moss_purple.init()

    return {
        description = "Purple moss",
        notes = "Harvested from certain nodes by using a sickle",
        depends = "shared_sickles",
    }

end

function unilib.pkg.moss_purple.exec()

    unilib.pkg.shared_sickles.register_moss({
        -- From sickles:moss_purple, etc. Creates unilib:moss_purple, etc
        part_name = "purple",
        orig_name = "sickles:moss_purple",
        block_orig_name = "sickles:moss_block_purple",
        description = S("Purple Moss"),
        block_description = S("Purple Moss Block"),
        dye = "violet",

        replace_mode = mode,
        tint = "#894adb70",
    })

end
