---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.dirt_permafrost_red = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.dirt_permafrost_red.init()

    return {
        description = "Red permafrost dirt",
        optional = "moss_yellow",
    }

end

function unilib.pkg.dirt_permafrost_red.exec()

    local full_name = "unilib:dirt_permafrost_red"
    local compressed_name = full_name .. "_compressed"

    unilib.register_node(full_name, nil, mode, {
        -- Original to unilib
        description = S("Red Permafrost Dirt"),
        tiles = {"unilib_dirt_permafrost_red.png"},
        groups = {cracky = 3, permafrost = 1},
        sounds = unilib.global.sound_table.dirt,

        is_ground_content = unilib.setting.caves_chop_dirt_flag,
    })
    unilib.register_other_dirt(full_name)

    if unilib.setting.squeezed_dirt_flag then

        unilib.register_node(compressed_name, nil, mode, {
            -- Original to unilib
            description = S("Compressed Red Permafrost"),
            tiles = {"unilib_dirt_permafrost_red_compressed.png"},
            groups = {compresseddirt = 1, cracky = 2},
            sounds = unilib.global.sound_table.dirt,

            is_ground_content = false,
            stack_max = unilib.global.squeezed_stack_max,
        })
        -- Original to unilib
        unilib.misc.set_squeezed_recipes(full_name, compressed_name)
        unilib.register_stairs(compressed_name)

    end

    unilib.register_node("unilib:dirt_permafrost_red_with_moss", nil, mode, {
        -- Original to unilib
        description = S("Red Permafrost Dirt with Moss"),
        tiles = {
            "unilib_moss_yellow_top.png",
            "unilib_dirt_permafrost_red.png",
            {
                name = "unilib_dirt_permafrost_red.png^unilib_moss_yellow_side.png",
                tileable_vertical = false,
            },
        },
        groups = {
            cracky = 3, not_in_creative_inventory = unilib.hide_covered_dirt_group, permafrost = 1,
        },
        sounds = unilib.sound.generate_dirt({
            footstep = {name = "unilib_grass_footstep", gain = 0.25},
        }),

        is_ground_content = unilib.setting.caves_chop_dirt_flag,
    })
    if unilib.global.pkg_executed_table["moss_yellow"] ~= nil then

        unilib.tools.make_cuttable(
            "unilib:dirt_permafrost_red_with_moss",
            full_name,
            "unilib:moss_yellow"
        )

    end

    unilib.register_node("unilib:dirt_permafrost_red_with_litter_stone", nil, mode, {
        -- Original to unilib
        description = S("Red Permafrost Dirt with Stone Litter"),
        tiles = {
            "unilib_dirt_permafrost_red.png^unilib_litter_stone_overlay.png",
            "unilib_dirt_permafrost_red.png",
            "unilib_dirt_permafrost_red.png^unilib_litter_stone_side_overlay.png",
        },
        groups = {
            cracky = 3, not_in_creative_inventory = unilib.hide_covered_dirt_group, permafrost = 1,
        },
        sounds = unilib.global.sound_table.gravel,

        is_ground_content = unilib.setting.caves_chop_dirt_flag,
    })

end
