---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    UGBC
-- Code:    GPLv2
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.sand_siltstone_pale = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ugbc.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.sand_siltstone_pale.init()

    return {
        description = "Pale siltstone sand",
    }

end

function unilib.pkg.sand_siltstone_pale.exec()

    unilib.register_node("unilib:sand_siltstone_pale", nil, mode, {
        -- Texture from UGBC, siltstone_sand.png. Original code
        description = S("Pale Siltstone Sand"),
        tiles = {"unilib_sand_siltstone_pale.png"},
        groups = {crumbly = 3, falling_node = 1, sand = 1},
        sounds = unilib.sound_table.sand,
    })

end
