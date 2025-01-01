---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    caverealms
-- Code:    WTFPL
-- Media:   WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_ordinary_with_moss_cavern = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.caverealms.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_ordinary_with_moss_cavern.init()

    return {
        description = "Ordinary cobblestone with cavern moss",
        depends = "stone_ordinary",
        optional = "moss_green",
    }

end

function unilib.pkg.stone_ordinary_with_moss_cavern.exec()

    unilib.register_node(
        -- From caverealms:stone_with_moss
        "unilib:stone_ordinary_cobble_with_moss_cavern",
        "caverealms:stone_with_moss",
        mode,
        {
            description = S("Ordinary Cobblestone with Cavern Moss"),
            tiles = {
                "unilib_stone_ordinary_cobble.png^unilib_moss_cavern_overlay.png",
                "unilib_stone_ordinary_cobble.png",
                "unilib_stone_ordinary_cobble.png^unilib_moss_cavern_overlay_side.png",
            },
            groups = {crumbly = 3},
            sounds = unilib.sound.generate_dirt({
                footstep = {name = "unilib_grass_footstep", gain = 0.25},
            }),

            drop = "unilib:stone_ordinary_cobble",
        }
    )
    if unilib.global.pkg_executed_table["moss_green"] ~= nil then

        unilib.tools.make_cuttable(
            "unilib:stone_ordinary_cobble_with_moss_cavern",
            "unilib:stone_ordinary_cobble",
            "unilib:moss_green"
        )

    end

end
