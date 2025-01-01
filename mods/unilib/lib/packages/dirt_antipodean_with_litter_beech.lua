---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.dirt_antipodean_with_litter_beech = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.dirt_antipodean_with_litter_beech.init()

    return {
        description = "Antipodean dirt with beech litter",
        depends = "dirt_antipodean",
    }

end

function unilib.pkg.dirt_antipodean_with_litter_beech.exec()

    unilib.register_node("unilib:dirt_antipodean_with_litter_beech", nil, mode, {
        -- Original to unilib, adapted from aotearoa:dirt_with_beech_litter
        description = S("Antipodean Dirt with Beech Litter"),
        tiles = {
            "unilib_dirt_antipodean_with_litter_beech_top.png",
            "unilib_dirt_antipodean.png",
            {
                name = "unilib_dirt_antipodean.png" ..
                        "^unilib_dirt_antipodean_with_litter_beech_side_overlay.png",
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

        drop = "unilib:dirt_antipodean",
        is_ground_content = unilib.setting.caves_chop_dirt_flag,
    })

end
