---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    PFAA
-- Code:    Artistic-2.0
-- Media:   Artistic-2.0
---------------------------------------------------------------------------------------------------

unilib.pkg.clay_bentonite_sodium = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.pfaa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.clay_bentonite_sodium.init()

    return {
        description = "Sodium bentonite clay",
    }

end

function unilib.pkg.clay_bentonite_sodium.exec()

    unilib.register_node("unilib:clay_bentonite_sodium", nil, mode, {
        -- Texture from PFAA, weakOreClay_sodiumBentonite.png. Original code
        description = S("Sodium Bentonite Clay"),
        tiles = {"unilib_clay_bentonite_sodium.png"},
        groups = {crumbly = 3},
        sounds = unilib.sound_table.dirt,

        drop = "unilib:clay_bentonite_sodium_lump 4",
    })
    unilib.register_craft_2x2({
        -- Texture from PFAA, weakOreClay_sodiumBentonite.png. Original code
        output = "unilib:clay_bentonite_sodium",
        ingredient = "unilib:clay_bentonite_sodium_lump",
    })

    unilib.register_craftitem("unilib:clay_bentonite_sodium_lump", nil, mode, {
        -- Original to unilib
        description = S("Sodium Bentonite Clay Lump"),
        inventory_image = "unilib_clay_bentonite_sodium_lump.png",
    })
    unilib.register_craft({
        -- Original to unilib
        output = "unilib:clay_bentonite_sodium_lump 4",
        recipe = {
            {"unilib:clay_bentonite_sodium"},
        },
    })

end
