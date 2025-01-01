---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_cloud_ordinary = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.default.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_cloud_ordinary.init()

    return {
        description = "Ordinary cloud",
    }

end

function unilib.pkg.misc_cloud_ordinary.exec()

    unilib.register_node("unilib:misc_cloud_ordinary", "default:cloud", mode, {
        -- From default:cloud
        description = S("Ordinary Cloud"),
        tiles = {"unilib_misc_cloud_ordinary.png"},
        groups = {not_in_creative_inventory = 1},
        sounds = unilib.global.sound_table.node,

        is_ground_content = false,
    })

end
