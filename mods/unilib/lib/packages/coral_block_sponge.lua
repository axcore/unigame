---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    GLEMr11
-- Code:    LGPL 2.1
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.coral_block_sponge = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.glemr11.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.coral_block_sponge.init()

    return {
        description = "Sponge coral block",
        depends = "coral_block_skeleton",
    }

end

function unilib.pkg.coral_block_sponge.exec()

    unilib.register_node("unilib:coral_block_sponge", "lib_ecology:coral_sponge", mode, {
        -- GLEMr11, From lib_ecology:coral_sponge
        description = S("Sponge Coral Block"),
        tiles = {"unilib_coral_block_sponge.png"},
        -- N.B. No coral = 1 in original code
        groups = {coral = 1, cracky = 3, sea = 1, stone = 1},
        sounds = unilib.global.sound_table.stone,

        drop = "unilib:coral_block_skeleton",
        light_source = 4,
    })

end
