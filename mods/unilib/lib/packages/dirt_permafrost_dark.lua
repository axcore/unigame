---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    GLEMr6
-- Code:    LGPL 2.1
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.dirt_permafrost_dark = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.glemr6.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.dirt_permafrost_dark.init()

    return {
        description = "Dark permafrost",
    }

end

function unilib.pkg.dirt_permafrost_dark.exec()

    unilib.register_node("unilib:dirt_permafrost_dark", "lib_materials:dirt_permafrost", mode, {
        -- From GLEMr6, lib_materials:dirt_permafrost
        description = S("Dark Permafrost"),
        tiles = {"unilib_dirt_permafrost_dark.png"},
        -- N.B. In original code, {crumbly = 3, soil = 1}. Changed to match "unilib:dirt_permafrost"
        groups = {cracky = 3},
        sounds = unilib.sound_table.dirt,

        is_ground_content = unilib.caves_chop_dirt_flag,
    })

end
