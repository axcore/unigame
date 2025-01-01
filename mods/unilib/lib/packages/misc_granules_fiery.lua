---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    underch
-- Code:    CC0
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_granules_fiery = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.underch.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_granules_fiery.init()

    return {
        description = "Block of fiery granules",
        notes = "Can be ignited (to create a permanent flame)",
        depends = "fire_permanent",
    }

end

function unilib.pkg.misc_granules_fiery.exec()

    unilib.register_node("unilib:misc_granules_fiery_block", "underch:fiery_dust", mode, {
        -- From underch:fiery_dust
        description = S("Block of Fiery Granules"),
        tiles = {"unilib_misc_granules_fiery_block.png"},
        groups = {crumbly = 2, falling_node = 1, hot = 1},
        sounds = unilib.global.sound_table.sand,

        light_source = 10,

        after_destruct = unilib.pkg.fire_permanent.remove,
        on_ignite = unilib.pkg.fire_permanent.add,
    })

end
