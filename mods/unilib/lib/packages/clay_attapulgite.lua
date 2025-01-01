---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    PFAA
-- Code:    Artistic-2.0
-- Media:   Artistic-2.0
---------------------------------------------------------------------------------------------------

unilib.pkg.clay_attapulgite = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.pfaa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.clay_attapulgite.init()

    return {
        description = "Attapulgite clay",
    }

end

function unilib.pkg.clay_attapulgite.exec()

    unilib.register_node("unilib:clay_attapulgite", nil, mode, {
        -- Texture from PFAA, weakOreClay_attapulgite.png. Original code
        description = unilib.utils.brackets(S("Attapulgite Clay"), S("Fuller's earth")),
        tiles = {"unilib_clay_attapulgite.png"},
        groups = {clay = 1, crumbly = 3},
        sounds = unilib.global.sound_table.dirt,

        drop = "unilib:clay_attapulgite_lump 4",
    })
    unilib.register_craft_2x2({
        -- Texture from PFAA, weakOreClay_attapulgite.png. Original code
        output = "unilib:clay_attapulgite",
        ingredient = "unilib:clay_attapulgite_lump",
    })
    unilib.register_carvings("unilib:clay_attapulgite", {
        facade_flag = true,
        millwork_flag = true,
    })

    unilib.register_craftitem("unilib:clay_attapulgite_lump", nil, mode, {
        -- Original to unilib
        description = S("Attapulgite Clay Lump"),
        inventory_image = "unilib_clay_attapulgite_lump.png",
    })
    unilib.register_craft({
        -- Original to unilib
        output = "unilib:clay_attapulgite_lump 4",
        recipe = {
            {"unilib:clay_attapulgite"},
        },
    })

end
