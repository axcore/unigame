---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.clay_gumland = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.clay_gumland.init()

    return {
        description = "Gumland clays",
        depends = {"clay_ordinary", "material_gum_kauri"},
    }

end

function unilib.pkg.clay_gumland.exec()

    unilib.register_node("unilib:clay_gumland_hardpan", "aotearoa:gumland_hardpan", mode, {
        -- From aotearoa:gumland_hardpan
        description = S("Gumland Hardpan"),
        tiles = {"unilib_clay_gumland_hardpan.png"},
        groups = {crumbly = 2},
        sounds = unilib.node_sound_dirt_defaults({
            footstep = {name = "unilib_dirt_mud_antipodean", gain = 0.4},
            dug = {name = "unilib_dirt_mud_antipodean", gain = 0.4},
        }),

        drop = {
            max_items = 2,
            items = {
                {items = {"unilib:material_gum_kauri"}, rarity = 15},
                {items = {"unilib:clay_ordinary"}},
            },
        },
    })

    unilib.register_node("unilib:clay_gumland_topsoil", "aotearoa:gumland_soil", mode, {
        -- From aotearoa:gumland_soil
        description = S("Gumland Topsoil"),
        tiles = {
            "unilib_clay_gumland_topsoil.png",
            "unilib_clay_gumland_hardpan.png",
            {
                name = "unilib_clay_gumland_hardpan.png" .. "^unilib_clay_gumland_topsoil_side.png",
                tileable_vertical = false,
            },
        },
        groups = {crumbly = 3},
        sounds = unilib.node_sound_dirt_defaults({
            footstep = {name = "unilib_dirt_mud_antipodean", gain = 0.4},
            dug = {name = "unilib_dirt_mud_antipodean", gain = 0.4},
        }),

        drop = {
            max_items = 2,
            items = {
                {items = {"unilib:material_gum_kauri"}, rarity = 20},
                {items = {"unilib:clay_ordinary"}},
            },
        },
    })

end
