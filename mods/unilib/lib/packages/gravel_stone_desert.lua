---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    GLEMr11
-- Code:    LGPL 2.1
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.gravel_stone_desert = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.glemr11.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.gravel_stone_desert.init()

    return {
        description = "Desert stone gravel",
    }

end

function unilib.pkg.gravel_stone_desert.exec()

    unilib.register_node("unilib:gravel_stone_desert", "lib_materials:stone_desert_gravel", mode, {
        -- Texture from GLEMr11, lib_materials_stone_desert_gravel.png. Original code
        description = S("Desert Stone Gravel"),
        tiles = {"unilib_gravel_stone_desert.png"},
        groups = {crumbly = 2, falling_node = 1},
        sounds = unilib.sound_table.gravel,
    })

end
