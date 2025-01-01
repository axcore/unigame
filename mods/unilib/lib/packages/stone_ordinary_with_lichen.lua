---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    caverealms
-- Code:    WTFPL
-- Media:   WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_ordinary_with_lichen = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.caverealms.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_ordinary_with_lichen.init()

    return {
        description = "Ordinary cobblestone with lichen",
        depends = "stone_ordinary",
        optional = "moss_violet",
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
            sounds = unilib.sound.generate_dirt({
                footstep = {name = "unilib_grass_footstep", gain = 0.25},
            }),

            drop = "unilib:stone_ordinary_cobble",
        }
    )
    if unilib.global.pkg_executed_table["moss_violet"] ~= nil then

        unilib.tools.make_cuttable(
            "unilib:stone_ordinary_cobble_with_lichen",
            "unilib:stone_ordinary_cobble",
            "unilib:moss_violet"
        )

    end

end
