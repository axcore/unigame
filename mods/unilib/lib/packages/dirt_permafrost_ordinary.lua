---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.dirt_permafrost_ordinary = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.default.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.dirt_permafrost_ordinary.init()

    return {
        description = "Ordinary permafrost dirt",
        optional = "moss_green",
    }

end

function unilib.pkg.dirt_permafrost_ordinary.exec()

    local full_name = "unilib:dirt_permafrost_ordinary"
    local compressed_name = full_name .. "_compressed"

    unilib.register_node(full_name, "default:permafrost", mode, {
        -- From default:permafrost
        description = S("Ordinary Permafrost Dirt"),
        tiles = {"unilib_dirt_permafrost_ordinary.png"},
        -- N.B. permafrost = 1 not in original code
        groups = {cracky = 3, permafrost = 1},
        sounds = unilib.global.sound_table.dirt,

        is_ground_content = unilib.setting.caves_chop_dirt_flag,
    })
    unilib.register_other_dirt(full_name)

    if unilib.setting.squeezed_dirt_flag then

        unilib.register_node(compressed_name, nil, mode, {
            -- Original to unilib
            description = S("Compressed Ordinary Permafrost Dirt"),
            tiles = {"unilib_dirt_permafrost_ordinary_compressed.png"},
            groups = {compresseddirt = 1, cracky = 2},
            sounds = unilib.global.sound_table.dirt,

            is_ground_content = false,
            stack_max = unilib.global.squeezed_stack_max,
        })
        -- Original to unilib
        unilib.misc.set_squeezed_recipes(full_name, compressed_name)
        unilib.register_stairs(compressed_name)

    end

    unilib.register_node(
        -- From default:permafrost_with_moss
        "unilib:dirt_permafrost_ordinary_with_moss",
        "default:permafrost_with_moss",
        mode,
        {
            description = S("Ordinary Permafrost Dirt with Moss"),
            tiles = {
                "unilib_moss_green_top.png",
                "unilib_dirt_permafrost_ordinary.png",
                {
                    name = "unilib_dirt_permafrost_ordinary.png^unilib_moss_green_side.png",
                    tileable_vertical = false,
                },
            },
            -- N.B. permafrost = 1 not in original code
            groups = {
                cracky = 3,
                not_in_creative_inventory = unilib.hide_covered_dirt_group,
                permafrost = 1,
            },
            sounds = unilib.sound.generate_dirt({
                footstep = {name = "unilib_grass_footstep", gain = 0.25},
            }),

            is_ground_content = unilib.setting.caves_chop_dirt_flag,
        }
    )
    if unilib.global.pkg_executed_table["moss_green"] ~= nil then

        unilib.tools.make_cuttable(
            "unilib:dirt_permafrost_ordinary_with_moss",
            full_name,
            "unilib:moss_green"
        )

    end

    unilib.register_decoration_generic("default_dirt_permafrost_ordinary_with_moss", {
        -- From default/mapgen.lua
        deco_type = "simple",
        decoration = "unilib:dirt_permafrost_ordinary_with_moss",

        flags = "force_placement",
        noise_params = {
            octaves = 3,
            offset = -0.8,
            persist = 1.0,
            scale = 2.0,
            seed = 53995,
            spread = {x = 100, y = 100, z = 100},
        },
        place_offset_y = -1,
        sidelen = 4,
    })

    unilib.register_node(
        -- From default:permafrost_with_stones
        "unilib:dirt_permafrost_ordinary_with_litter_stone",
        "default:permafrost_with_stones",
        mode,
        {
            description = S("Ordinary Permafrost Dirt with Stone Litter"),
            tiles = {
                "unilib_dirt_permafrost_ordinary.png^unilib_litter_stone_overlay.png",
                "unilib_dirt_permafrost_ordinary.png",
                "unilib_dirt_permafrost_ordinary.png^unilib_litter_stone_side_overlay.png",
            },
            -- N.B. permafrost = 1 not in original code
            groups = {
                cracky = 3,
                not_in_creative_inventory = unilib.hide_covered_dirt_group,
                permafrost = 1,
            },
            sounds = unilib.global.sound_table.gravel,

            is_ground_content = unilib.setting.caves_chop_dirt_flag,
        }
    )

end
