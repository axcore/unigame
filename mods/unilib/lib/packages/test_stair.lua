---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.test_stair = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.test_stair.init()

    return {
        description = "Test node",
        notes = "This package provides a test node with stairs",
    }

end

function unilib.pkg.test_stair.exec()

    unilib.register_node("unilib:test_node2", nil, mode, {
        -- Original to unilib
        description = S("Test Node 2"),
        tiles = {"unilib_unknown_2.png"},
        groups = {cracky = 3},
        sounds = unilib.global.sound_table.node,
    })
    unilib.register_stairs("unilib:test_node2")

end
