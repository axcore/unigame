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

unilib.pkg.dirt_ordinary_with_litter_coniferous = {}

local S = unilib.intllib
local default_add_mode = unilib.global.imported_mod_table.default.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.dirt_ordinary_with_litter_coniferous.init()

    return {
        description = "Ordinary dirt with coniferous litter",
        optional = {"dirt_ordinary", "grass_dry", "soil_ordinary"},
    }

end

function unilib.pkg.dirt_ordinary_with_litter_coniferous.exec()

    unilib.register_node(
        -- From default:dirt_with_coniferous_litter
        "unilib:dirt_ordinary_with_litter_coniferous",
        "default:dirt_with_coniferous_litter",
        default_add_mode,
        {
            description = S("Ordinary Dirt with Coniferous Litter"),
            tiles = {
                "unilib_litter_coniferous.png",
                "unilib_dirt_ordinary.png",
                {
                    name = "unilib_dirt_ordinary.png^unilib_litter_coniferous_side_overlay.png",
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

        unilib.override_item("unilib:dirt_ordinary_with_litter_coniferous", {
            soil = {
                base = "unilib:dirt_ordinary_with_litter_coniferous",
                dry = "unilib:soil_ordinary",
                wet = "unilib:soil_ordinary_wet",
            },
        })

    end
    if unilib.global.pkg_executed_table["grass_dry"] ~= nil then

        unilib.tools.make_cuttable(
            "unilib:dirt_ordinary_with_litter_coniferous",
            "unilib:dirt_ordinary",
            "unilib:grass_dry_1"
        )

    end

end
