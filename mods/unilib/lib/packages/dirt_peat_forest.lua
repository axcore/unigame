---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.dirt_peat_forest = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.dirt_peat_forest.init()

    return {
        description = "Forest peat",
        notes = "Very rarely drops iron, otherwise drops antipodean peat",
        depends = {"dirt_peat_antipodean", "metal_iron"},
    }

end

function unilib.pkg.dirt_peat_forest.exec()

    unilib.register_node("unilib:dirt_peat_forest", "aotearoa:forest_peat", mode, {
        -- From aotearoa:forest_peat
        description = S("Forest Peat"),
        tiles = {
            "unilib_dirt_peat_forest_top.png",
            "unilib_dirt_peat_antipodean.png",
            {
                name ="unilib_dirt_peat_antipodean.png^unilib_dirt_peat_forest_side_overlay.png",
                tileable_vertical = false,
            },
        },
        groups = {crumbly = 3},
        sounds = unilib.sound.generate_dirt({
            footstep = {name = "unilib_dirt_mud_antipodean", gain = 0.4},
            dug = {name = "unilib_dirt_mud_antipodean", gain = 0.4},
        }),

        drop = {
            max_items = 1,
            items = {
                {items = {"unilib:metal_iron_lump"}, rarity = 1000},
                {items = {"unilib:dirt_peat_antipodean"}},
            },
        },
        is_ground_content = unilib.setting.caves_chop_dirt_flag,
    })

end
