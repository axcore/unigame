---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    PFAA
-- Code:    Artistic-2.0
-- Media:   Artistic-2.0
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_guano = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.pfaa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_guano.init()

    return {
        description = "Guano",
    }

end

function unilib.pkg.misc_guano.exec()

    unilib.register_node("unilib:misc_guano", nil, mode, {
        -- Texture from AATO, guano.png. Original code
        description = S("Guano"),
        tiles = {"unilib_misc_guano.png"},
        groups = {crumbly = 3},
        sounds = unilib.global.sound_table.dirt,

        is_ground_content = false,
    })

end
