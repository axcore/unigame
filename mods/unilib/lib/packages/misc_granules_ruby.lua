---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    underch
-- Code:    CC0
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_granules_ruby = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.underch.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_granules_ruby.init()

    return {
        description = "Block of ruby granules",
        notes = "Cannot be used to craft rubies",
    }

end

function unilib.pkg.misc_granules_ruby.exec()

    unilib.register_node("unilib:misc_granules_ruby_block", "underch:ruby_dust", mode, {
        -- From underch:ruby_dust
        description = S("Block of Ruby Granules"),
        tiles = {"unilib_misc_granules_ruby_block.png"},
        groups = {crumbly = 2, falling_node = 1},
        sounds = unilib.sound_table.sand,

        is_ground_content = false,
    })

end
