---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.dirt_permafrost = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.default.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.dirt_permafrost.init()

    return {
        description = "Permafrost dirt",
        optional = "moss_green",
    }

end

function unilib.pkg.dirt_permafrost.exec()

    unilib.register_node("unilib:dirt_permafrost", "default:permafrost", mode, {
        -- From default:permafrost
        description = S("Permafrost Dirt"),
        tiles = {"unilib_dirt_permafrost.png"},
        groups = {cracky = 3},
        sounds = unilib.sound_table.dirt,

        is_ground_content = unilib.caves_chop_dirt_flag,
    })

    unilib.register_node(
        -- From default:permafrost_with_moss
        "unilib:dirt_permafrost_with_moss",
        "default:permafrost_with_moss",
        mode,
        {
            description = S("Permafrost Dirt with Moss"),
            tiles = {
                "unilib_moss_ordinary.png",
                "unilib_dirt_permafrost.png",
                {
                    name = "unilib_dirt_permafrost.png^unilib_moss_ordinary_side.png",
                    tileable_vertical = false,
                },
            },
            groups = {cracky = 3},
            sounds = unilib.node_sound_dirt_defaults({
                footstep = {name = "unilib_grass_footstep", gain = 0.25},
            }),

            is_ground_content = unilib.caves_chop_dirt_flag,
        }
    )
    if unilib.pkg_executed_table["moss_green"] ~= nil then

        unilib.register_cuttable(
            "unilib:dirt_permafrost_with_moss",
            "unilib:dirt_permafrost",
            "unilib:moss_green"
        )

    end

    unilib.register_decoration("default_dirt_permafrost_with_moss", {
        -- From default/mapgen.lua
        deco_type = "simple",
        decoration = "unilib:dirt_permafrost_with_moss",

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
        "unilib:dirt_permafrost_with_stonelet",
        "default:permafrost_with_stones",
        mode,
        {
            description = S("Permafrost Dirt with Stones"),
            tiles = {
                "unilib_dirt_permafrost.png^unilib_stonelet_ordinary_overlay.png",
                "unilib_dirt_permafrost.png",
                "unilib_dirt_permafrost.png^unilib_stonelet_ordinary_side_overlay.png",
            },
            groups = {cracky = 3},
            sounds = unilib.sound_table.gravel,

            is_ground_content = unilib.caves_chop_dirt_flag,
        }
    )

end
