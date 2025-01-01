---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.moss_green_dark = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.moss_green_dark.init()

    return {
        description = "Dark green moss",
        notes = "Harvested from certain nodes by using a sickle",
        depends = "shared_sickles",
    }

end

function unilib.pkg.moss_green_dark.exec()

    unilib.pkg.shared_sickles.register_moss({
        -- Original to unilib. Creates unilib:moss_green_dark, etc
        part_name = "green_dark",
        orig_name = nil,
        block_orig_name = nil,
        description = S("Dark Green Moss"),
        block_description = S("Dark Green Moss Block"),
        dye = "green_dark",

        replace_mode = mode,
        tint = "#296a4670",
    })

end
