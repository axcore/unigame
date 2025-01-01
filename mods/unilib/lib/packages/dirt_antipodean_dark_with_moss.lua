---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.dirt_antipodean_dark_with_moss = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.dirt_antipodean_dark_with_moss.init()

    return {
        description = "Dark Antipodean dirt with moss",
        depends = "dirt_antipodean_dark",
    }

end

function unilib.pkg.dirt_antipodean_dark_with_moss.exec()

    unilib.register_node("unilib:dirt_antipodean_dark_with_moss", nil, mode, {
        -- Original to unilib, adapted from aotearoa:dirt_with_moss
        description = S("Dark Antipodean Dirt with Moss"),
        tiles = {
            "unilib_dirt_antipodean_dark_with_moss_top.png",
            "unilib_dirt_antipodean_dark.png",
            {
                name = "unilib_dirt_antipodean_dark.png" ..
                        "^unilib_dirt_antipodean_dark_with_moss_side_overlay.png",
                tileable_vertical = false,
            },
        },
        groups = {crumbly = 3, soil = 1, spreading_dirt_type = 1},
        sounds = unilib.sound.generate_dirt({
            footstep = {name = "unilib_grass_footstep", gain = 0.4},
        }),

        drop = "unilib:dirt_antipodean_dark",
        is_ground_content = unilib.setting.caves_chop_dirt_flag,
    })

end
