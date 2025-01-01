---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.coral_block_orange = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.default.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.coral_block_orange.init()

    return {
        description = "Orange coral block",
        depends = "coral_block_skeleton",
    }

end

function unilib.pkg.coral_block_orange.exec()

    unilib.register_block_coral({
        -- From default:coral_orange. Creates unilib:coral_block_orange
        part_name = "orange",
        orig_name = "default:coral_orange",

        replace_mode = mode,
        description = S("Orange Coral Block"),
    })

end
