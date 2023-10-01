---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    sickles
-- Code:    LGPL v3
-- Media:   CC BY-SA 3.0/4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.moss_green = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.sickles.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.moss_green.init()

    return {
        description = "Green moss",
        notes = "Harvested from certain nodes by using a sickle",
        depends = "shared_sickles",
    }

end

function unilib.pkg.moss_green.exec()

    unilib.pkg.shared_sickles.register_moss({
        -- From sickles:moss, etc. Creates unilib:moss_green, etc
        part_name = "green",
        orig_name = "sickles:moss",
        block_orig_name = "sickles:moss_block",
        description = S("Green Moss"),
        block_description = S("Green Moss Block"),
        dye = "green_dark",

        replace_mode = mode,
    })

end
