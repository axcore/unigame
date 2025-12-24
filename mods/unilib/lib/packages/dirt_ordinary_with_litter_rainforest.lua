---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
--
-- From:    farming
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.dirt_ordinary_with_litter_rainforest = {}

local S = unilib.intllib
local default_add_mode = unilib.global.imported_mod_table.default.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.dirt_ordinary_with_litter_rainforest.init()

    return {
        description = "Ordinary dirt with rainforest litter",
        optional = {"dirt_ordinary", "grass_jungle", "soil_ordinary"},
    }

end

function unilib.pkg.dirt_ordinary_with_litter_rainforest.exec()

    unilib.register_node(
        -- From default:dirt_with_rainforest_litter
        "unilib:dirt_ordinary_with_litter_rainforest",
        "default:dirt_with_rainforest_litter",
        default_add_mode,
        {
            description = S("Ordinary Dirt with Rainforest Litter"),
            tiles = {
                "unilib_litter_rainforest.png",
                "unilib_dirt_ordinary.png",
                {
                    name = "unilib_dirt_ordinary.png^unilib_litter_rainforest_side_overlay.png",
                    tileable_vertical = false,
                },
            },
            -- N.B. covered_dirt = 1 not in original code
            -- N.B. spreading_dirt_type = 1 omitted from original code
            groups = {
                covered_dirt = 1, crumbly = 3,
                not_in_creative_inventory = unilib.hide_covered_dirt_group, soil = 1,
            },
            sounds = unilib.sound.generate_dirt({
                footstep = {name = "unilib_grass_footstep", gain = 0.4},
            }),

            drop = "unilib:dirt_ordinary",
            is_ground_content = unilib.setting.caves_chop_dirt_flag,
        }
    )
    if unilib.global.pkg_executed_table["soil_ordinary"] ~= nil then

        unilib.override_item("unilib:dirt_ordinary_with_litter_rainforest", {
            soil = {
                base = "unilib:dirt_ordinary_with_litter_rainforest",
                dry = "unilib:soil_ordinary",
                wet = "unilib:soil_ordinary_wet",
            },
        })

    end
    if unilib.global.pkg_executed_table["grass_jungle"] ~= nil then

        unilib.tools.make_cuttable(
            "unilib:dirt_ordinary_with_litter_rainforest",
            "unilib:dirt_ordinary",
            "unilib:grass_jungle"
        )

    end

end
