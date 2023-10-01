---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    PFAA
-- Code:    Artistic-2.0
-- Media:   Artistic-2.0
---------------------------------------------------------------------------------------------------

unilib.pkg.dirt_peat_with_oil_crude = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.pfaa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.dirt_peat_with_oil_crude.init()

    return {
        description = "Peat with crude oil",
        notes = "This dirt can be used as a fuel",
    }

end

function unilib.pkg.dirt_peat_with_oil_crude.exec()

    unilib.register_node("unilib:dirt_peat_with_oil_crude", nil, mode, {
        -- Texture from PFAA, crudeGround_peat.png. Original code
        description = S("Peat with Crude Oil"),
        tiles = {"unilib_dirt_peat_with_oil_crude.png"},
        groups = {crumbly = 3, falling_node = 1},
        sounds = unilib.sound_table.dirt,

        is_ground_content = unilib.caves_chop_dirt_flag,
    })
    minetest.register_craft({
        -- Texture from PFAA, crudeGround_peat.png. Original code
        type = "fuel",
        recipe = "unilib:dirt_peat_with_oil_crude",
        burntime = 20,
    })

end
