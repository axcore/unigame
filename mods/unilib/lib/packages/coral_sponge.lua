---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    GLEMr11
-- Code:    LGPL 2.1
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.coral_sponge = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.glemr11.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.coral_sponge.init()

    return {
        description = "Sponge coral",
        depends = "coral_block_skeleton",
    }

end

function unilib.pkg.coral_sponge.exec()

    unilib.register_node("unilib:coral_sponge", "lib_ecology:coral_sponge", mode, {
        -- GLEMr11, From lib_ecology:coral_sponge
        description = S("Sponge Coral"),
        tiles = {"unilib_coral_sponge.png"},
        groups = {cracky = 3, sea = 1, stone = 1},
        sounds = unilib.sound_table.stone,

        drop = "unilib:coral_block_skeleton",
        light_source = 4,
    })

end
