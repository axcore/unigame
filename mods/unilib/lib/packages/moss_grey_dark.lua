---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.moss_grey_dark = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.moss_grey_dark.init()

    return {
        description = "Dark grey moss",
        notes = "Harvested from certain nodes by using a sickle",
        depends = "shared_sickles",
    }

end

function unilib.pkg.moss_grey_dark.exec()

    unilib.pkg.shared_sickles.register_moss({
        -- Original to unilib. Creates unilib:moss_grey_dark, etc
        part_name = "grey_dark",
        orig_name = nil,
        block_orig_name = nil,
        description = S("Dark Grey Moss"),
        block_description = S("Dark Grey Moss Block"),
        dye = "grey_dark",

        replace_mode = mode,
        tint = "#716f6399",
    })

end
