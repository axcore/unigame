---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    GLEMr6
-- Code:    LGPL 2.1
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.sand_silica = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.glemr6.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.sand_silica.init()

    return {
        description = "Silica sand",
    }

end

function unilib.pkg.sand_silica.exec()

    unilib.register_node("unilib:sand_silica", "lib_materials:sand_white", mode, {
        -- From GLEMr6, lib_materials:sand_white
        description = S("Silica Sand"),
        tiles = {"unilib_sand_silica.png"},
        groups = {crumbly = 3, falling_node = 1, sand = 1},
        sounds = unilib.sound_table.sand,
    })

end
