---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.coral_block_brown = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.default.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.coral_block_brown.init()

    return {
        description = "Brown coral block",
        depends = "coral_block_skeleton",
    }

end

function unilib.pkg.coral_block_brown.exec()

    unilib.register_block_coral({
        -- From default:coral_brown. Creates unilib:coral_block_brown
        part_name = "brown",
        orig_name = "default:coral_brown",

        replace_mode = mode,
        description = S("Brown Coral Block"),
    })

end
