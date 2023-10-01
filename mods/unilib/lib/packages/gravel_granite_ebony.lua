---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    UGBC
-- Code:    GPLv2
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.gravel_granite_ebony = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ugbc.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.gravel_granite_ebony.init()

    return {
        description = "Ebony granite gravel",
    }

end

function unilib.pkg.gravel_granite_ebony.exec()

    unilib.register_node("unilib:gravel_granite_ebony", nil, mode, {
        -- Texture from UGBC, black_granite_gravel.png. Original code
        description = S("Ebony Granite Gravel"),
        tiles = {"unilib_gravel_granite_ebony.png"},
        groups = {crumbly = 3, falling_node = 1},
        sounds = unilib.sound_table.gravel,
    })

end
