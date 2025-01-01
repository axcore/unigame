---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.dirt_ordinary_with_litter_dry = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.dirt_ordinary_with_litter_dry.init()

    return {
        description = "Ordinary dirt with dry litter",
        depends = "dirt_ordinary",
    }

end

function unilib.pkg.dirt_ordinary_with_litter_dry.exec()

    unilib.register_node(
        -- From aotearoa:dirt_with_dry_litter
        "unilib:dirt_ordinary_with_litter_dry",
        "aotearoa:dirt_with_dry_litter",
        mode,
        {
            description = S("Ordinary Dirt with Dry Litter"),
            tiles = {
                "unilib_dirt_ordinary_with_litter_dry_top.png",
                "unilib_dirt_ordinary.png",
                {
                    name = "unilib_dirt_ordinary.png" ..
                            "^unilib_dirt_ordinary_with_litter_dry_side_overlay.png",
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

            drop = "unilib:dirt_ordinary",
            is_ground_content = unilib.setting.caves_chop_dirt_flag,
        }
    )

end
