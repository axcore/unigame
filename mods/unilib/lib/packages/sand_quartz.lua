---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    PFAA
-- Code:    Artistic-2.0
-- Media:   Artistic-2.0
---------------------------------------------------------------------------------------------------

unilib.pkg.sand_quartz = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.pfaa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.sand_quartz.init()

    return {
        description = "High-purity quartz sand",
    }

end

function unilib.pkg.sand_quartz.exec()

    unilib.register_node("unilib:sand_quartz", nil, mode, {
        -- Texture from PFAA, crudeSand_oilSand.png. Original code
        description = S("High-Purity Quartz Sand"),
        tiles = {"unilib_sand_quartz.png"},
        groups = {crumbly = 3, falling_node = 1, sand = 1},
        sounds = unilib.sound_table.sand,
    })

end
