---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.gravel_sandstone_ordinary = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.gravel_sandstone_ordinary.init()

    return {
        description = "Ordinary sandstone gravel",
    }

end

function unilib.pkg.gravel_sandstone_ordinary.exec()

    unilib.register_node("unilib:gravel_sandstone_ordinary", nil, mode, {
        -- Original to unilib
        description = S("Ordinary Sandstone Gravel"),
        tiles = {"unilib_gravel_sandstone_ordinary.png"},
        groups = {crumbly = 2, falling_node = 1},
        sounds = unilib.sound_table.gravel,
    })

end
