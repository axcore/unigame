---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    snow
-- Code:    GPL 3.0
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_pine_christmas = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.snow.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_pine_christmas.init()

    return {
        description = "Christmas Pine Tree",
        notes = "Saplings are produced (rarely) by frozen pine tree leaves. Punch the star to" ..
                " turn it on or off",
        depends = {"snow_ordinary", "tree_pine_frozen"},
    }

end

function unilib.pkg.tree_pine_christmas.exec()

    -- (no burnlevel)
    local sci_name = "Pinus"

    unilib.register_tree({
        -- Original to unilib
        part_name = "pine_christmas",
        -- N.B. Not "Christmas Pine Wood", obviously
        description = S("Pine Wood"),

        not_super_flag = true,
    })

    -- (Schematic uses trunk and wood nodes from the default pine tree)

    unilib.register_node("unilib:tree_pine_christmas_leaves", "snow:needles_decorated", mode, {
        -- From snow:needles
        description = unilib.utils.annotate(S("Christmas Pine Tree Needles"), sci_name),
        tiles = {
            {
                name = "unilib_tree_pine_christmas_leaves_animated.png",
                animation = {
                    type = "vertical_frames",
                    aspect_w = 16,
                    aspect_h = 16,
                    length = 20.0,
                },
            },
        },
        groups = {snappy = 3},
        sounds = unilib.global.sound_table.leaves,

        drawtype = "allfaces_optional",
        drop = {
            max_items = 1,
            items = {
                {items = {"unilib:tree_pine_christmas_sapling"}, rarity = 120},
                {items = {"unilib:tree_pine_frozen_sapling"}, rarity = 20},
                {items = {"unilib:tree_pine_christmas_leaves"}},
            },
        },
        furnace_burntime = 1,
        inventory_image = core.inventorycube("unilib_tree_pine_christmas_leaves.png"),
        -- N.B. is_ground_content = false not in original code; added to match other leaves
        is_ground_content = false,
        light_source = 5,
        paramtype = "light",
        visual_scale = unilib.global.leaves_visual_scale,
        -- N.B. walkable not in original code
        walkable = unilib.setting.walkable_leaves_flag,
    })

    unilib.register_tree_sapling({
        -- Code original to unilib, texture from snow mod
        part_name = "pine_christmas",
        orig_name = "snow:xmas_tree",

        replace_mode = mode,
        common_group = 3,
        description = S("Christmas Pine Tree Sapling"),
        max_volume = 4,
        maxp_table = {x = 1, y = 9, z = 1},
        minp_table = {x = -1, y = 1, z = -1},
        offset_list = {1, 1, 1},
        sci_name = sci_name,
        select_table = {-4 / 16, -0.5, -4 / 16, 4 / 16, 7 / 16, 4 / 16},
    })

    unilib.register_node("unilib:tree_pine_christmas_star", "snow:star", mode, {
        -- From snow:star
        description = S("Christmas Pine Tree Star"),
        tiles = {"unilib_tree_pine_christmas_star.png"},
        groups = {choppy = 1, cracky = 1, crumbly = 1, oddly_breakable_by_hand = 1},
        sounds = unilib.sound.generate_glass({
            dig = {name = "unilib_glass_footstep", gain = 0.2},
        }),

        drawtype = "plantlike",
        inventory_image = "unilib_tree_pine_christmas_star.png",
        -- N.B. is_ground_content = false not in original code
        is_ground_content = false,
        paramtype = "light",
        walkable = false,
        wield_image = "unilib_tree_pine_christmas_star.png",

        on_punch = function(pos, node)

            node.name = "unilib:tree_pine_christmas_star_lit"
            core.set_node(pos, node)

        end,
    })

    unilib.register_node("unilib:tree_pine_christmas_star_lit", "snow:star_lit", mode, {
        -- From snow:star_lit
        description = S("Illuminated Christmas Pine Tree Star"),
        tiles = {"unilib_tree_pine_christmas_star_lit.png"},
        groups = {
            choppy = 1, cracky = 1, crumbly = 1, not_in_creative_inventory = 1,
            oddly_breakable_by_hand = 1,
        },
        sounds = unilib.sound.generate_glass({
            dig = {name = "unilib_glass_footstep", gain = 0.2},
        }),

        drawtype = "plantlike",
        drop = "unilib:tree_pine_christmas_star",
        -- N.B. is_ground_content = false not in original code
        is_ground_content = false,
        light_source = unilib.constant.light_max,
        paramtype = "light",
        walkable = false,

        on_punch = function(pos, node)

            node.name = "unilib:tree_pine_christmas_star"
            core.set_node(pos, node)

        end,
    })

end
