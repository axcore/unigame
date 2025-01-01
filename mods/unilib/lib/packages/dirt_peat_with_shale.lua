---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    PFAA
-- Code:    Artistic-2.0
-- Media:   Artistic-2.0
---------------------------------------------------------------------------------------------------

unilib.pkg.dirt_peat_with_shale = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.pfaa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.dirt_peat_with_shale.init()

    return {
        description = "Peat with shale",
        notes = "This dirt can be used as a fuel",
    }

end

function unilib.pkg.dirt_peat_with_shale.exec()

    unilib.register_node("unilib:dirt_peat_with_shale", nil, mode, {
        -- Texture from PFAA, crudeRock_oilShale.png. Original code
        description = S("Peat with Shale"),
        tiles = {"unilib_dirt_peat_with_shale.png"},
        groups = {crumbly = 3, falling_node = 1},
        sounds = unilib.global.sound_table.dirt,

        is_ground_content = unilib.setting.caves_chop_dirt_flag,
    })
    unilib.register_craft({
        -- Texture from PFAA, crudeRock_oilShale.png. Original code
        type = "fuel",
        recipe = "unilib:dirt_peat_with_shale",
        burntime = 20,
    })

end
