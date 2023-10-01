---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    GLEMr4
-- Code:    LGPL 2.1
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.gravel_sandstone_desert = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.glemr4.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.gravel_sandstone_desert.init()

    return {
        description = "Desert sandstone gravel",
    }

end

function unilib.pkg.gravel_sandstone_desert.exec()

    unilib.register_node(
        -- Texture from darkage, darkage_cob.png. Original code, replacing the original stone-like
        --      code
        "unilib:gravel_sandstone_desert",
        "lib_materials:stone_sandstone_desert_gravel",
        mode,
        {
            description = S("Desert Sandstone Gravel"),
            tiles = {"unilib_gravel_sandstone_desert.png"},
            groups = {crumbly = 2, falling_node = 1},
            sounds = unilib.sound_table.gravel,
        }
    )

end
