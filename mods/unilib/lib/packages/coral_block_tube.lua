---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xocean
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.coral_block_tube = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.xocean.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.coral_block_tube.init()

    return {
        description = "Tube coral block",
    }

end

function unilib.pkg.coral_block_tube.exec()

    unilib.register_node("unilib:coral_block_tube", "xocean:tube_block", mode, {
        -- From xocean:tube_block
        description = S("Tube Coral Block"),
        tiles = {"unilib_coral_block_tube.png"},
        groups = {cracky = 3},
        sounds = unilib.sound_table.stone,

        drop = "unilib:coral_block_tube_skeleton",
    })

    unilib.register_node("unilib:coral_block_tube_skeleton", "xocean:tube_skeleton", mode, {
        -- From xocean:tube_skeleton
        description = S("Tube Coral Block Skeleton"),
        tiles = {"unilib_coral_block_tube_skeleton.png"},
        groups = {cracky = 3},
        sounds = unilib.sound_table.stone,
    })

end
