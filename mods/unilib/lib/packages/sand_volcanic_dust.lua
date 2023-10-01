---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    GLEMr4
-- Code:    LGPL 2.1
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.sand_volcanic_dust = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.glemr4.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.sand_volcanic_dust.init()

    return {
        description = "Volcanic dust sand",
    }

end

function unilib.pkg.sand_volcanic_dust.exec()

    unilib.register_node("unilib:sand_volcanic_dust", "lib_materials:sand_volcanic", mode, {
        -- From GLEMr4, lib_materials:sand_volcanic; originally from "prehistoric life" mod
        description = S("Volcanic Dust Sand"),
        tiles = {"unilib_sand_volcanic_dust.png"},
        groups = {crumbly = 3, falling_node = 1, sand = 1},
        sounds = unilib.sound_table.sand,
    })

end
