---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    underch
-- Code:    CC0
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_granules_normal = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.underch.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_granules_normal.init()

    return {
        description = "Block of normal granules",
    }

end

function unilib.pkg.misc_granules_normal.exec()

    unilib.register_node("unilib:misc_granules_normal_block", "underch:dust", mode, {
        -- From underch:dust
        description = S("Block of Normal Granules"),
        tiles = {"unilib_misc_granules_normal_block.png"},
        groups = {crumbly = 2, falling_node = 1},
        sounds = unilib.global.sound_table.sand,
    })

end
