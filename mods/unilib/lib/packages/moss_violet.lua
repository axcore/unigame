---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    sickles
-- Code:    LGPL v3
-- Media:   CC BY-SA 3.0/4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.moss_violet = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.sickles.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.moss_violet.init()

    return {
        description = "Violet moss",
        notes = "Harvested from certain nodes by using a sickle",
        depends = "shared_sickles",
    }

end

function unilib.pkg.moss_violet.exec()

    unilib.pkg.shared_sickles.register_moss({
        -- From sickles:moss_purple, etc. Creates unilib:moss_violet, etc
        part_name = "violet",
        orig_name = "sickles:moss_purple",
        block_orig_name = "sickles:moss_block_purple",
        description = S("Violet Moss"),
        block_description = S("Violet Moss Block"),
        dye = "violet",

        replace_mode = mode,
        tint = "#894adb70",
    })

end
