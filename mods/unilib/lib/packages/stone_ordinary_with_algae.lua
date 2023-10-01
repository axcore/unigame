---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    caverealms
-- Code:    WTFPL
-- Media:   WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_ordinary_with_algae = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.caverealms.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_ordinary_with_algae.init()

    return {
        description = "Ordinary cobblestone with algae",
        depends = "stone_ordinary",
        optional = "moss_yellow",
    }

end

function unilib.pkg.stone_ordinary_with_algae.exec()

    unilib.register_node(
        -- From caverealms:stone_with_algae
        "unilib:stone_ordinary_cobble_with_algae",
        "caverealms:stone_with_algae",
        mode,
        {
            description = S("Ordinary Cobblestone with Algae"),
            tiles = {
                "unilib_stone_ordinary_cobble.png^unilib_algae_overlay.png",
                "unilib_stone_ordinary_cobble.png",
                "unilib_stone_ordinary_cobble.png^unilib_algae_overlay_side.png",
            },
            groups = {crumbly = 3},
            sounds = unilib.node_sound_dirt_defaults({
                footstep = {name = "unilib_grass_footstep", gain = 0.25},
            }),

            drop = "unilib:stone_ordinary_cobble",
        }
    )
    if unilib.pkg_executed_table["moss_yellow"] ~= nil then

        unilib.register_cuttable(
            "unilib:stone_ordinary_cobble_with_algae",
            "unilib:stone_ordinary_cobble",
            "unilib:moss_yellow"
        )

    end

end
