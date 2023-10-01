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
--
-- From:    moreblocks
-- Code:    zlib
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.dirt_ordinary = {}

local S = unilib.intllib
local default_add_mode = unilib.imported_mod_table.default.add_mode
local moreblocks_add_mode = unilib.imported_mod_table.moreblocks.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.dirt_ordinary.init()

    return {
        description = "Ordinary dirt",
        optional = {"grass_dry", "grass_jungle", "grass_ordinary", "soil_ordinary"},
    }

end

function unilib.pkg.dirt_ordinary.exec()

    --[[
    unilib.register_node("unilib:dirt_ordinary", "default:dirt", default_add_mode, {
        -- From default:dirt
        description = S("Ordinary Dirt"),
        tiles = {"unilib_dirt_ordinary.png"},
        groups = {crumbly = 3, soil = 1},
        sounds = unilib.sound_table.dirt,
    })
    if unilib.pkg_executed_table["soil_ordinary"] ~= nil then

        unilib.override_item("unilib:dirt_ordinary", {
            soil = {
                base = "unilib:dirt_ordinary",
                dry = "unilib:soil_ordinary",
                wet = "unilib:soil_ordinary_wet",
            },
        })

    end
    ]]--
    unilib.register_fertile_dirt({
        -- From default:dirt. Creates unilib:dirt_ordinary
        part_name = "dirt_ordinary",
        orig_name = "default:dirt",
        def_table = {
            description = S("Ordinary Dirt"),
            tiles = {"unilib_dirt_ordinary.png"},
            groups = {crumbly = 3, soil = 1},
            sounds = unilib.sound_table.dirt,

            is_ground_content = unilib.caves_chop_dirt_flag,
        },

        replace_mode = default_add_mode,
        dry_soil = "unilib:soil_ordinary",
        wet_soil = "unilib:soil_ordinary_wet",
    })
    if unilib.mtgame_tweak_flag and moreblocks_add_mode ~= "defer" then

        unilib.register_node(
            -- From moreblocks:dirt_compressed
            "unilib:dirt_ordinary_compressed",
            "moreblocks:dirt_compressed",
            moreblocks_add_mode,
            {
                description = S("Compressed Ordinary Dirt"),
                tiles = {"unilib_dirt_ordinary_compressed.png"},
                -- N.B. compresseddirt = 1 not in original code; it matches the compressedstone
                --      group in some stone packages
                groups = {compresseddirt = 1, crumbly = 2},
                sounds = unilib.sound_table.dirt,

                is_ground_content = false,
            }
        )
        unilib.register_craft_3x3({
            output = "unilib:dirt_ordinary_compressed",
            ingredient = "unilib:dirt_ordinary",
        })
        unilib.register_craft({
            output = "unilib:dirt_ordinary 9",
            recipe = {
                {"unilib:dirt_ordinary_compressed"},
            },
        })
        unilib.register_stairs("unilib:dirt_ordinary_compressed")

    end

    --[[
    unilib.register_node(
        -- From default:dirt_with_grass
        "unilib:dirt_ordinary_with_turf",
        "default:dirt_with_grass",
        default_add_mode,
        {
            description = S("Ordinary Dirt with Turf"),
            tiles = {
                "unilib_turf_ordinary_top.png",
                "unilib_dirt_ordinary.png",
                {
                    name = "unilib_dirt_ordinary.png^unilib_turf_ordinary_side_overlay.png",
                    tileable_vertical = false,
                },
            },
            groups = {crumbly = 3, soil = 1, spreading_dirt_type = 1},
            sounds = unilib.node_sound_dirt_defaults({
                footstep = {name = "unilib_grass_footstep", gain = 0.25},
            }),

            drop = "unilib:dirt_ordinary",
        }
    )
    if unilib.pkg_executed_table["soil_ordinary"] ~= nil then

        unilib.override_item("unilib:dirt_ordinary_with_turf", {
            soil = {
                base = "unilib:dirt_ordinary_with_turf",
                dry = "unilib:soil_ordinary",
                wet = "unilib:soil_ordinary_wet",
            },
        })

    end
    ]]--
    unilib.register_dirt_with_turf({
        -- From default:dirt_with_grass. Creates unilib:dirt_ordinary_with_turf
        dirt_part_name = "dirt_ordinary",
        turf_part_name = "turf",
        orig_name = "default:dirt_with_grass",
        def_table = {
            description = S("Ordinary Dirt with Turf"),
            tiles = {
                "unilib_turf_ordinary_top.png",
                "unilib_dirt_ordinary.png",
                {
                    name = "unilib_dirt_ordinary.png^unilib_turf_ordinary_side_overlay.png",
                    tileable_vertical = false,
                },
            },
            groups = {crumbly = 3, soil = 1, spreading_dirt_type = 1},
            sounds = unilib.node_sound_dirt_defaults({
                footstep = {name = "unilib_grass_footstep", gain = 0.25},
            }),

            drop = "unilib:dirt_ordinary",
            is_ground_content = unilib.caves_chop_dirt_flag,
        },

        replace_mode = default_add_mode,
        dry_soil = "unilib:soil_ordinary",
        wet_soil = "unilib:soil_ordinary_wet",
        turf_description = S("Turf"),
        -- N.B. Not using group:ordinary_grass here, hoping to prevent compatibility issues
        turf_seeder = "group:normal_grass",
    })
    if unilib.mtgame_tweak_flag and unilib.pkg_executed_table["grass_jungle"] ~= nil then

        minetest.register_craft({
            -- From moreblocks
            type = "shapeless",
            output = "unilib:dirt_ordinary_with_turf",
            recipe = {"unilib:grass_jungle", "unilib:dirt_ordinary"},
        })

    end
    if unilib.pkg_executed_table["grass_ordinary"] ~= nil then

        unilib.register_cuttable(
            "unilib:dirt_ordinary_with_turf",
            "unilib:dirt_ordinary",
            "unilib:grass_ordinary_1"
        )

    end

    unilib.register_node(
        -- From default:dirt_with_grass_footsteps
        "unilib:dirt_ordinary_with_turf_and_footsteps",
        "default:dirt_with_grass_footsteps",
        default_add_mode,
        {
            description = S("Footsteps in Ordinary Dirt with Turf"),
            tiles = {
                "unilib_turf_ordinary_top.png^unilib_footprint_ordinary_overlay.png",
                "unilib_dirt_ordinary.png",
                {
                    name = "unilib_dirt_ordinary.png^unilib_turf_ordinary_side_overlay.png",
                    tileable_vertical = false,
                },
            },
            groups = {crumbly = 3, not_in_creative_inventory = 1, soil = 1},
            sounds = unilib.node_sound_dirt_defaults({
                footstep = {name = "unilib_grass_footstep", gain = 0.25},
            }),

            drop = "unilib:dirt_ordinary",
            is_ground_content = unilib.caves_chop_dirt_flag,
        }
    )

    --[[
    unilib.register_node(
        -- From default:dirt_with_dry_grass
        "unilib:dirt_ordinary_with_turf_dry",
        "default:dirt_with_dry_grass",
        default_add_mode,
        {
            description = S("Ordinary Dirt with Savanna Turf"),
            tiles = {
                "unilib_turf_dry_top.png",
                "unilib_dirt_ordinary.png",
                {
                    name = "unilib_dirt_ordinary.png^unilib_turf_dry_side_overlay.png",
                    tileable_vertical = false,
                },
            },
            groups = {crumbly = 3, soil = 1, spreading_dirt_type = 1},
            sounds = unilib.node_sound_dirt_defaults({
                footstep = {name = "unilib_grass_footstep", gain = 0.4},
            }),

            drop = "unilib:dirt_ordinary",
        }
    )
    if unilib.pkg_executed_table["soil_ordinary"] ~= nil then

        unilib.override_item("unilib:dirt_ordinary_with_turf_dry", {
            soil = {
                base = "unilib:dirt_ordinary_with_turf_dry",
                dry = "unilib:soil_ordinary",
                wet = "unilib:soil_ordinary_wet",
            },
        })

    end
    ]]--
    unilib.register_dirt_with_turf({
        -- From default:dirt_with_dry_grass. Creates unilib:dirt_ordinary_with_turf_dry
        dirt_part_name = "dirt_ordinary",
        turf_part_name = "turf_dry",
        orig_name = "default:dirt_with_dry_grass",
        def_table = {
            description = S("Ordinary Dirt with Savanna Turf"),
            tiles = {
                "unilib_turf_dry_top.png",
                "unilib_dirt_ordinary.png",
                {
                    name = "unilib_dirt_ordinary.png^unilib_turf_dry_side_overlay.png",
                    tileable_vertical = false,
                },
            },
            groups = {crumbly = 3, soil = 1, spreading_dirt_type = 1},
            sounds = unilib.node_sound_dirt_defaults({
                footstep = {name = "unilib_grass_footstep", gain = 0.25},
            }),

            drop = "unilib:dirt_ordinary",
            is_ground_content = unilib.caves_chop_dirt_flag,
        },

        replace_mode = default_add_mode,
        dry_soil = "unilib:soil_ordinary",
        wet_soil = "unilib:soil_ordinary_wet",
        turf_description = S("Savanna Turf"),
        turf_seeder = "group:dry_grass",
    })
    if unilib.pkg_executed_table["grass_dry"] ~= nil then

        unilib.register_cuttable(
            "unilib:dirt_ordinary_with_turf_dry",
            "unilib:dirt_ordinary",
            "unilib:grass_dry_1"
        )

    end

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
                }
            },
            groups = {crumbly = 3, soil = 1, spreading_dirt_type = 1},
            sounds = unilib.node_sound_dirt_defaults({
                footstep = {name = "unilib_grass_footstep", gain = 0.4},
            }),

            drop = "unilib:dirt_ordinary",
            is_ground_content = unilib.caves_chop_dirt_flag,
        }
    )
    if unilib.pkg_executed_table["soil_ordinary"] ~= nil then

        unilib.override_item("unilib:dirt_ordinary_with_litter_coniferous", {
            soil = {
                base = "unilib:dirt_ordinary_with_litter_coniferous",
                dry = "unilib:soil_ordinary",
                wet = "unilib:soil_ordinary_wet",
            },
        })

    end
    if unilib.pkg_executed_table["grass_dry"] ~= nil then

        unilib.register_cuttable(
            "unilib:dirt_ordinary_with_litter_coniferous",
            "unilib:dirt_ordinary",
            "unilib:grass_dry_1"
        )

    end

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
            groups = {crumbly = 3, soil = 1, spreading_dirt_type = 1},
            sounds = unilib.node_sound_dirt_defaults({
                footstep = {name = "unilib_grass_footstep", gain = 0.4},
            }),

            drop = "unilib:dirt_ordinary",
            is_ground_content = unilib.caves_chop_dirt_flag,
        }
    )
    if unilib.pkg_executed_table["soil_ordinary"] ~= nil then

        unilib.override_item("unilib:dirt_ordinary_with_litter_rainforest", {
            soil = {
                base = "unilib:dirt_ordinary_with_litter_rainforest",
                dry = "unilib:soil_ordinary",
                wet = "unilib:soil_ordinary_wet",
            },
        })

    end
    if unilib.pkg_executed_table["grass_jungle"] ~= nil then

        unilib.register_cuttable(
            "unilib:dirt_ordinary_with_litter_rainforest",
            "unilib:dirt_ordinary",
            "unilib:grass_jungle"
        )

    end

    --[[
    unilib.register_node(
        -- From default:dirt_with_snow
        "unilib:dirt_ordinary_with_cover_snow",
        "default:dirt_with_snow",
        default_add_mode,
        {
            description = S("Ordinary Dirt with Snow Cover"),
            tiles = {
                "unilib_snow_ordinary.png",
                "unilib_dirt_ordinary.png",
                {
                    name = "unilib_dirt_ordinary.png^unilib_snow_ordinary_side_overlay.png",
                    tileable_vertical = false,
                },
            },
            groups = {crumbly = 3, snowy = 1, soil = 1, spreading_dirt_type = 1},
            sounds = unilib.node_sound_dirt_defaults({
                footstep = {name = "unilib_snow_footstep", gain = 0.2},
            }),

            drop = "unilib:dirt_ordinary",
        }
    )
    ]]--
    unilib.register_dirt_with_turf({
        -- From default:dirt_with_snow. Creates unilib:dirt_ordinary_with_cover_snow
        dirt_part_name = "dirt_ordinary",
        turf_part_name = "cover_snow",
        orig_name = "default:dirt_with_snow",
        def_table = {
            description = S("Ordinary Dirt with Snow Cover"),
            tiles = {
                "unilib_snow_ordinary.png",
                "unilib_dirt_ordinary.png",
                {
                    name = "unilib_dirt_ordinary.png^unilib_snow_ordinary_side_overlay.png",
                    tileable_vertical = false,
                },
            },
            groups = {crumbly = 3, snowy = 1, soil = 1, spreading_dirt_type = 1},
            sounds = unilib.node_sound_dirt_defaults({
                footstep = {name = "unilib_snow_footstep", gain = 0.2},
            }),

            drop = "unilib:dirt_ordinary",
            is_ground_content = unilib.caves_chop_dirt_flag,
        },

        replace_mode = default_add_mode,
        -- N.B. The turf cutter (etc) must create (ordinary) turf, not snow. See the notes in
        --      ../shared/dirts.lua
        alt_turf_part_name = "turf",
        turf_description = S("Turf"),
        turf_seeder = "unilib:snow_ordinary",
    })

end
