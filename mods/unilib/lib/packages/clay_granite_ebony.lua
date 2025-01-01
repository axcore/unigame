---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    UGBC
-- Code:    GPLv2
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.clay_granite_ebony = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ugbc.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.clay_granite_ebony.init()

    return {
        description = "Ebony granite clay",
    }

end

function unilib.pkg.clay_granite_ebony.exec()

    unilib.register_node("unilib:clay_granite_ebony", nil, mode, {
        -- Texture from UGBC, black_granite_clay.png. Original code
        description = S("Granite Ebony Clay"),
        tiles = {"unilib_clay_granite_ebony.png"},
        groups = {clay = 1, crumbly = 3},
        sounds = unilib.global.sound_table.dirt,
    })

end
