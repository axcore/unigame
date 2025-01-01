---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.coral_rooted_green = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.default.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.coral_rooted_green.init()

    return {
        description = "Rooted green coral",
        depends = {"coral_block_skeleton", "liquid_water_ordinary"},
    }

end

function unilib.pkg.coral_rooted_green.exec()

    unilib.register_rooted_coral({
        -- From default:coral_green. Creates unilib:coral_rooted_green
        part_name = "green",
        orig_name = "default:coral_green",

        replace_mode = mode,
        description = S("Rooted Green Coral"),
    })

end
