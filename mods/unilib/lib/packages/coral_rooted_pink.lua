---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.coral_rooted_pink = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.default.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.coral_rooted_pink.init()

    return {
        description = "Rooted pink coral",
        depends = {"coral_block_skeleton", "liquid_water_ordinary"},
    }

end

function unilib.pkg.coral_rooted_pink.exec()

    unilib.register_rooted_coral({
        -- From default:coral_pink. Creates unilib:coral_rooted_pink
        part_name = "pink",
        orig_name = "default:coral_pink",

        replace_mode = mode,
        description = S("Rooted Pink Coral"),
    })

end
