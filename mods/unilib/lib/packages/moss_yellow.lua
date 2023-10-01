---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    sickles
-- Code:    LGPL v3
-- Media:   CC BY-SA 3.0/4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.moss_yellow = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.sickles.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.moss_yellow.init()

    return {
        description = "Yellow moss",
        notes = "Harvested from certain nodes by using a sickle",
        depends = "shared_sickles",
    }

end

function unilib.pkg.moss_yellow.exec()

    unilib.pkg.shared_sickles.register_moss({
        -- From sickles:moss_yellow, etc. Creates unilib:moss_yellow, etc
        part_name = "yellow",
        orig_name = "sickles:moss_yellow",
        block_orig_name = "sickles:moss_block_yellow",
        description = S("Yellow Moss"),
        block_description = S("Yellow Moss Block"),
        dye = "yellow",

        replace_mode = mode,
        tint = "#bcc56770",
    })

end
