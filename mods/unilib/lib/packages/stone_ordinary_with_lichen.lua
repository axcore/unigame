---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    caverealms
-- Code:    WTFPL
-- Media:   WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_ordinary_with_lichen = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.caverealms.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_ordinary_with_lichen.init()

    return {
        description = "Ordinary cobblestone with lichen",
        depends = "stone_ordinary",
        optional = "moss_purple",
    }

end

function unilib.pkg.stone_ordinary_with_lichen.exec()

    unilib.register_node(
        -- From caverealms:stone_with_lichen
        "unilib:stone_ordinary_cobble_with_lichen",
        "caverealms:stone_with_lichen",
        mode,
        {
            description = S("Ordinary Cobblestone with Lichen"),
            tiles = {
                "unilib_stone_ordinary_cobble.png^unilib_lichen_overlay.png",
                "unilib_stone_ordinary_cobble.png",
                "unilib_stone_ordinary_cobble.png^unilib_lichen_overlay_side.png",
            },
            groups = {crumbly = 3},
            sounds = unilib.node_sound_dirt_defaults({
                footstep = {name = "unilib_grass_footstep", gain = 0.25},
            }),

            drop = "unilib:stone_ordinary_cobble",
        }
    )
    if unilib.pkg_executed_table["moss_purple"] ~= nil then

        unilib.register_cuttable(
            "unilib:stone_ordinary_cobble_with_lichen",
            "unilib:stone_ordinary_cobble",
            "unilib:moss_purple"
        )

    end

end
