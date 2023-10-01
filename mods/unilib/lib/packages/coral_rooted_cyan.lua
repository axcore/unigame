---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.coral_rooted_cyan = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.default.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.coral_rooted_cyan.init()

    return {
        description = "Rooted cyan coral",
        depends = {"coral_block_skeleton", "liquid_water_ordinary"},
    }

end

function unilib.pkg.coral_rooted_cyan.exec()

    unilib.register_rooted_coral({
        -- From default:coral_cyan. Creates unilib:coral_rooted_cyan
        part_name = "cyan",
        orig_name = "default:coral_cyan",

        replace_mode = mode,
        description = S("Rooted Cyan Coral"),
    })

end
