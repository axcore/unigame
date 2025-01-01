---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    PFAA
-- Code:    Artistic-2.0
-- Media:   Artistic-2.0
---------------------------------------------------------------------------------------------------

unilib.pkg.clay_vermiculite = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.pfaa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.clay_vermiculite.init()

    return {
        description = "Vermiculite clay",
    }

end

function unilib.pkg.clay_vermiculite.exec()

    unilib.register_node("unilib:clay_vermiculite", nil, mode, {
        -- Texture from PFAA, weakOreClay_vermiculite.png. Original code
        description = S("Vermiculite Clay"),
        tiles = {"unilib_clay_vermiculite.png"},
        groups = {clay = 1, crumbly = 3},
        sounds = unilib.global.sound_table.dirt,

        drop = "unilib:clay_vermiculite_lump 4",
    })
    unilib.register_craft_2x2({
        -- Texture from PFAA, weakOreClay_vermiculite.png. Original code
        output = "unilib:clay_vermiculite",
        ingredient = "unilib:clay_vermiculite_lump",
    })
    unilib.register_carvings("unilib:clay_vermiculite", {
        facade_flag = true,
        millwork_flag = true,
    })

    unilib.register_craftitem("unilib:clay_vermiculite_lump", nil, mode, {
        -- Original to unilib
        description = S("Vermiculite Clay Lump"),
        inventory_image = "unilib_clay_vermiculite_lump.png",
    })
    unilib.register_craft({
        -- Original to unilib
        output = "unilib:clay_vermiculite_lump 4",
        recipe = {
            {"unilib:clay_vermiculite"},
        },
    })

end
