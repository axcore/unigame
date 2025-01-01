---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    GLEMr6
-- Code:    LGPL 2.1
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.dirt_permafrost_dark = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.glemr6.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.dirt_permafrost_dark.init()

    return {
        description = "Dark permafrost dirt",
        optional = "moss_pink",
    }

end

function unilib.pkg.dirt_permafrost_dark.exec()

    local full_name = "unilib:dirt_permafrost_dark"
    local compressed_name = full_name .. "_compressed"

    unilib.register_node(full_name, "lib_materials:dirt_permafrost", mode, {
        -- From GLEMr6, lib_materials:dirt_permafrost
        description = S("Dark Permafrost Dirt"),
        tiles = {"unilib_dirt_permafrost_dark.png"},
        -- N.B. In original code, {crumbly = 3, soil = 1}. Changed to match
        --      "unilib:dirt_permafrost_ordinary"
        groups = {cracky = 3, permafrost = 1},
        sounds = unilib.global.sound_table.dirt,

        is_ground_content = unilib.setting.caves_chop_dirt_flag,
    })
    unilib.register_other_dirt(full_name)

    if unilib.setting.squeezed_dirt_flag then

        unilib.register_node(compressed_name, nil, mode, {
            -- Original to unilib
            description = S("Compressed Dark Permafrost Dirt"),
            tiles = {"unilib_dirt_permafrost_dark_compressed.png"},
            groups = {compresseddirt = 1, cracky = 2},
            sounds = unilib.global.sound_table.dirt,

            is_ground_content = false,
            stack_max = unilib.global.squeezed_stack_max,
        })
        -- Original to unilib
        unilib.misc.set_squeezed_recipes(full_name, compressed_name)
        unilib.register_stairs(compressed_name)

    end

    unilib.register_node("unilib:dirt_permafrost_dark_with_moss", nil, mode, {
        -- Original to unilib
        description = S("Dark Permafrost Dirt with Moss"),
        tiles = {
            "unilib_moss_pink_top.png",
            "unilib_dirt_permafrost_dark.png",
            {
                name = "unilib_dirt_permafrost_dark.png^unilib_moss_pink_side.png",
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
    if unilib.global.pkg_executed_table["moss_pink"] ~= nil then

        unilib.tools.make_cuttable(
            "unilib:dirt_permafrost_dark_with_moss",
            full_name,
            "unilib:moss_pink"
        )

    end

    unilib.register_node("unilib:dirt_permafrost_dark_with_litter_stone", nil, mode, {
        -- Original to unilib
        description = S("Dark Permafrost Dirt with Stone Litter"),
        tiles = {
            "unilib_dirt_permafrost_dark.png^unilib_litter_stone_overlay.png",
            "unilib_dirt_permafrost_dark.png",
            "unilib_dirt_permafrost_dark.png^unilib_litter_stone_side_overlay.png",
        },
        groups = {
            cracky = 3, not_in_creative_inventory = unilib.hide_covered_dirt_group, permafrost = 1,
        },
        sounds = unilib.global.sound_table.gravel,

        is_ground_content = unilib.setting.caves_chop_dirt_flag,
    })

end
