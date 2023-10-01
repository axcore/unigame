---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
--
-- From:    plaster
-- Code:    CC BY-SA 3.0
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.coral_block_skeleton = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.default.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.coral_block_skeleton.init()

    return {
        description = "Coral skeleton",
        notes = "Produced when mining block corals. Required when planting root corals",
    }

end

function unilib.pkg.coral_block_skeleton.exec()

    local img = "unilib_coral_block_skeleton.png"
    if unilib.mtgame_tweak_flag then
        img = "unilib_coral_block_skeleton_farlands.png"
    end

    unilib.register_node("unilib:coral_block_skeleton", "default:coral_skeleton", mode, {
        -- From default:coral_skeleton
        description = S("Coral Skeleton"),
        tiles = {img},
        groups = {cracky = 3},
        sounds = unilib.sound_table.stone,
    })

end
