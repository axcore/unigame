---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xocean
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.coral_block_fire = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.xocean.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.coral_block_fire.init()

    return {
        description = "Fire coral block",
    }

end

function unilib.pkg.coral_block_fire.exec()

    unilib.register_node("unilib:coral_block_fire", nil, mode, {
        -- From xocean, default:coral_orange
        description = S("Fire Coral Block"),
        tiles = {"unilib_coral_block_fire.png"},
        groups = {cracky = 3},
        sounds = unilib.sound_table.stone,

        drop = "unilib:coral_block_fire_skeleton",
    })

    unilib.register_node("unilib:coral_block_fire_skeleton", "xocean:fire_skeleton", mode, {
        -- From xocean:fire_skeleton
        description = S("Fire Coral Block Skeleton"),
        tiles = {"unilib_coral_block_fire_skeleton.png"},
        groups = {cracky = 3},
        sounds = unilib.sound_table.stone,
    })

end
