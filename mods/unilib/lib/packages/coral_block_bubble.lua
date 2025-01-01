---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xocean
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.coral_block_bubble = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.xocean.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.coral_block_bubble.init()

    return {
        description = "Bubble coral block",
    }

end

function unilib.pkg.coral_block_bubble.exec()

    unilib.register_node("unilib:coral_block_bubble", "xocean:bubble_block", mode, {
        -- From xocean:bubble_block
        description = S("Bubble Coral Block"),
        tiles = {"unilib_coral_block_bubble.png"},
        -- N.B. No coral = 1 in original code
        groups = {coral = 1, cracky = 3},
        sounds = unilib.global.sound_table.stone,

        drop = "unilib:coral_block_bubble_skeleton",
    })

    unilib.register_node("unilib:coral_block_bubble_skeleton", "xocean:bubble_skeleton", mode, {
        -- From xocean:bubble_skeleton
        description = S("Bubble Coral Block Skeleton"),
        tiles = {"unilib_coral_block_bubble_skeleton.png"},
        -- N.B. No coral = 1 in original code
        groups = {coral = 1, cracky = 3},
        sounds = unilib.global.sound_table.stone,
    })

end
