---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.dirt_antipodean_dark_with_litter_beech = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.dirt_antipodean_dark_with_litter_beech.init()

    return {
        description = "Dark Antipodean dirt with beech litter",
        depends = "dirt_antipodean_dark",
    }

end

function unilib.pkg.dirt_antipodean_dark_with_litter_beech.exec()

    unilib.register_node(
        -- From aotearoa:dirt_with_beech_litter
        "unilib:dirt_antipodean_dark_with_litter_beech",
        "aotearoa:dirt_with_beech_litter",
        mode,
        {
            description = S("Dark Antipodean Dirt with Beech Litter"),
            tiles = {
                "unilib_dirt_antipodean_dark_with_litter_beech_top.png",
                "unilib_dirt_antipodean_dark.png",
                {
                    name = "unilib_dirt_antipodean_dark.png" ..
                            "^unilib_dirt_antipodean_dark_with_litter_beech_side_overlay.png",
                    tileable_vertical = false,
                },
            },
            groups = {
                crumbly = 3, not_in_creative_inventory = unilib.hide_covered_dirt_group, soil = 1,
                spreading_dirt_type = 1,
            },
            sounds = unilib.sound.generate_dirt({
                footstep = {name = "unilib_grass_footstep", gain = 0.4},
            }),

            -- N.B. default:dirt in original code
            drop = "unilib:dirt_antipodean_dark",
            is_ground_content = unilib.setting.caves_chop_dirt_flag,
        }
    )

end
