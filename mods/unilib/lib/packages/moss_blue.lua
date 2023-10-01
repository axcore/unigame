---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    sickles
-- Code:    LGPL v3
-- Media:   CC BY-SA 3.0/4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.moss_blue = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.sickles.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.moss_blue.init()

    return {
        description = "Blue moss",
        notes = "Harvested from certain nodes by using a sickle",
        depends = "shared_sickles",
    }

end

function unilib.pkg.moss_blue.exec()

    unilib.pkg.shared_sickles.register_moss({
        -- From sickles:moss_blue, etc. Creates unilib:moss_blue, etc
        part_name = "blue",
        orig_name = "sickles:moss_blue",
        block_orig_name = "sickles:moss_block_blue",
        description = S("Blue Moss"),
        block_description = S("Blue Moss Block"),
        dye = "cyan",

        replace_mode = mode,
        tint = "#6c7eb070",
    })

end
