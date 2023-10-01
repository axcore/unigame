---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.gravel_sandstone_silver = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.gravel_sandstone_silver.init()

    return {
        description = "Silver sandstone gravel",
    }

end

function unilib.pkg.gravel_sandstone_silver.exec()

    unilib.register_node("unilib:gravel_sandstone_silver", nil, mode, {
        -- Original to unilib
        description = S("Silver Sandstone Gravel"),
        tiles = {"unilib_gravel_sandstone_silver.png"},
        groups = {crumbly = 2, falling_node = 1},
        sounds = unilib.sound_table.gravel,
    })

end
