---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xocean
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.coral_block_rose = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.xocean.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.coral_block_rose.init()

    return {
        description = "Rose coral block",
    }

end

function unilib.pkg.coral_block_rose.exec()

    unilib.register_node("unilib:coral_block_rose", "xocean:brain_block", mode, {
        -- From xocean:brain_block
        description = S("Rose Coral Block"),
        tiles = {"unilib_coral_block_rose.png"},
        groups = {cracky = 3},
        sounds = unilib.sound_table.stone,

        drop = "unilib:coral_block_rose_skeleton",
    })

    unilib.register_node("unilib:coral_block_rose_skeleton", "xocean:brain_skeleton", mode, {
        -- From xocean:brain_skeleton
        description = S("Rose Coral Block Skeleton"),
        tiles = {"unilib_coral_block_rose_skeleton.png"},
        groups = {cracky = 3},
        sounds = unilib.sound_table.stone,
    })

end
