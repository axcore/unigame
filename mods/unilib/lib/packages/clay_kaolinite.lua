---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    PFAA
-- Code:    Artistic-2.0
-- Media:   Artistic-2.0
---------------------------------------------------------------------------------------------------

unilib.pkg.clay_kaolinite = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.pfaa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.clay_kaolinite.init()

    return {
        description = "Kaolinite clay",
    }

end

function unilib.pkg.clay_kaolinite.exec()

    unilib.register_node("unilib:clay_kaolinite", nil, mode, {
        -- Texture from PFAA, weakOreClay_kaolinite.png. Original code
        description = S("Kaolinite Clay"),
        tiles = {"unilib_clay_kaolinite.png"},
        groups = {crumbly = 3},
        sounds = unilib.sound_table.dirt,

        drop = "unilib:clay_kaolinite_lump 4",
    })
    unilib.register_craft_2x2({
        -- Texture from PFAA, weakOreClay_kaolinite.png. Original code
        output = "unilib:clay_kaolinite",
        ingredient = "unilib:clay_kaolinite_lump",
    })

    unilib.register_craftitem("unilib:clay_kaolinite_lump", nil, mode, {
        -- Original to unilib
        description = S("Kaolinite Clay Lump"),
        inventory_image = "unilib_clay_kaolinite_lump.png",
    })
    unilib.register_craft({
        -- Original to unilib
        output = "unilib:clay_kaolinite_lump 4",
        recipe = {
            {"unilib:clay_kaolinite"},
        }
    })

end
