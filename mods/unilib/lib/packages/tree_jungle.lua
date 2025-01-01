---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
--
-- From:    doors
-- Code:    MIT
-- Media:   CC BY-SA 3.0
--
-- From:    moreblocks
-- Code:    zlib
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_jungle = {}

local S = unilib.intllib
local default_add_mode = unilib.global.imported_mod_table.default.add_mode
local doors_add_mode = unilib.global.imported_mod_table.doors.add_mode
local moreblocks_add_mode = unilib.global.imported_mod_table.moreblocks.add_mode

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_jungle.grow_func(pos)

    -- Adapted from default/trees.lua
    -- Special handling for the emergent sapling (only), called by unilib.trees.grow_sapling()
    --      (instead of executing that function's own code)

    unilib.utils.log(
        "action",
        "The emergent jungle tree sapling grows into a tree at " .. core.pos_to_string(pos)
    )

    core.place_schematic(
        {x = pos.x - 3, y = pos.y - 5, z = pos.z - 3},
        unilib.core.path_mod .. "/mts/unilib_tree_jungle_emergent_from_sapling.mts",
        "random",
        nil,
        false
    )

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_jungle.init()

    return {
        description = "Jungle tree",
        notes = "Two saplings producing the same trunk/leaves nodes. The emergent sapling" ..
                " a tree twice as tall, twice as wide, but is five times as rare as a normal" ..
                " sapling. Due to its 32 node height, its altitude is limited and its presence" ..
                " depends on chunksize. Normal saplings can be used to craft emergent saplings",
        optional = "mushroom_brown",
    }

end

function unilib.pkg.tree_jungle.exec()

    local burnlevel = 5
    -- (no sci_name)

    unilib.register_tree({
        -- Original to unilib
        part_name = "jungle",
        description = S("Jungle Tree Wood"),

        burnlevel = burnlevel,
    })

    -- The emergent jungle tree sapling produces a tree twice as tall and twice as wide
    unilib.register_node(
        -- From default:emergent_jungle_sapling
        "unilib:tree_jungle_sapling_emergent",
        "default:emergent_jungle_sapling",
        default_add_mode,
        {
            description = S("Emergent Jungle Tree Sapling"),
            tiles = {"unilib_tree_jungle_sapling_emergent.png"},
            groups = {attached_node = 1, dig_immediate = 3, flammable = 2, sapling = 1, snappy = 2},
            sounds = unilib.global.sound_table.leaves,

            drawtype = "plantlike",
            inventory_image = "unilib_tree_jungle_sapling_emergent.png",
            paramtype = "light",
            selection_box = {
                type = "fixed",
                fixed = {-4 / 16, -0.5, -4 / 16, 4 / 16, 7 / 16, 4 / 16}
            },
            sunlight_propagates = true,
            walkable = false,
            wield_image = "unilib_tree_jungle_sapling_emergent.png",

            on_construct = function(pos)

                core.get_node_timer(pos):start(
                    math.random(unilib.setting.sapling_grow_min, unilib.setting.sapling_grow_max)
                )

            end,

            on_place = function(itemstack, placer, pointed_thing)

                itemstack = unilib.flora.sapling_on_place(
                    itemstack,
                    placer,
                    pointed_thing,
                    "unilib:tree_jungle_sapling_emergent",
                    -- minp, maxp to be checked, relative to sapling pos
                    {x = -3, y = -5, z = -3},
                    {x = 3, y = 31, z = 3},
                    -- maximum interval of interior volume check
                    4
                )

                return itemstack

            end,

            on_timer = function(pos)

                if not unilib.flora.can_grow_sapling(
                    pos, "unilib:tree_jungle_sapling_emergent"
                ) then

                    -- Try again 5 minutes later
                    core.get_node_timer(pos):start(unilib.setting.sapling_grow_min)
                    return

                else

                    unilib.trees.grow_sapling(pos, "unilib:tree_jungle_sapling_emergent")

                end

            end,
        }
    )
    unilib.register_craft_3x3({
        -- From default:emergent_jungle_sapling
        output = "unilib:tree_jungle_sapling_emergent",
        ingredient = "unilib:tree_jungle_sapling",
    })
    unilib.register_craft({
        -- From default:emergent_jungle_sapling
        type = "fuel",
        recipe = "unilib:tree_jungle_sapling_emergent",
        burntime = 7,
    })
    -- Set up growth for this sapling (e.g. from fertilisers)
    unilib.global.sapling_table["unilib:tree_jungle_sapling_emergent"] = {
        part_name = "jungle",
        sapling_type = "tree",
        min_height = 31,
        grow_func = unilib.pkg.tree_jungle.grow_func,
    }

    unilib.register_lbm({
        -- From default:emergent_jungle_sapling
        label = "Convert emergent jungle tree sapling to node [tree_jungle]",
        name = "unilib:lbm_tree_jungle",
        nodenames = {"unilib:tree_jungle_sapling_emergent"},

        action = function(pos)

            core.get_node_timer(pos):start(
                math.random(unilib.setting.sapling_grow_min, unilib.setting.sapling_grow_max)
            )

        end
    })

    unilib.register_tree_trunk({
        -- From default:jungletree. Creates unilib:tree_jungle_trunk
        part_name = "jungle",
        orig_name = "default:jungletree",

        replace_mode = default_add_mode,
        burnlevel = burnlevel,
        common_group = 2,
        description = S("Jungle Tree Trunk"),
    })

    unilib.register_tree_wood({
        -- From default:junglewood. Creates unilib:tree_jungle_wood
        part_name = "jungle",
        orig_name = "default:junglewood",

        replace_mode = default_add_mode,
        burnlevel = burnlevel,
        common_group = 2,
        description = S("Jungle Tree Wood Planks"),
    })

    unilib.register_tree_leaves({
        -- From default:jungleleaves. Creates unilib:tree_jungle_leaves
        part_name = "jungle",
        orig_name = "default:jungleleaves",

        replace_mode = default_add_mode,
        description = S("Jungle Tree Leaves"),
        special_list = "unilib_tree_jungle_leaves_simple.png",
    })
    unilib.register_quick_tree_leafdecay("jungle", 2)

    unilib.register_tree_sapling({
        -- From default:junglesapling. Creates unilib:tree_jungle_sapling
        part_name = "jungle",
        orig_name = "default:junglesapling",

        replace_mode = default_add_mode,
        burnlevel = burnlevel,
        common_group = 2,
        description = S("Jungle Tree Sapling"),
        max_volume = 4,
        maxp_table = {x = 2, y = 15, z = 2},
        minp_table = {x = -2, y = 1, z = -2},
        offset_list = {2, 1, 2},
        select_table = {-4 / 16, -0.5, -4 / 16, 4 / 16, 7 / 16, 4 / 16},
    })

    if unilib.setting.mtgame_tweak_flag and (
        moreblocks_add_mode ~= "defer" or not core.get_modpath("moreblocks")
    ) then

        unilib.register_tree_panel({
            -- From moreblocks:all_faces_jungle_tree. Creates unilib:tree_jungle_panel
            part_name = "jungle",
            orig_name = "moreblocks:all_faces_jungle_tree",

            replace_mode = moreblocks_add_mode,
            burnlevel = burnlevel,
            common_group = 2,
            description = S("Jungle Tree Wood Panel"),
        })

    end

    unilib.register_fence_quick({
        -- From default:fence_junglewood. Creates unilib:tree_jungle_wood_fence
        part_name = "jungle",
        orig_name = "default:fence_junglewood",

        replace_mode = default_add_mode,
        burnlevel = burnlevel,
        description = S("Jungle Tree Wood Fence"),
    })

    unilib.register_fence_rail_quick({
        -- From default:fence_rail_junglewood. Creates unilib:tree_jungle_wood_fence_rail
        part_name = "jungle",
        orig_name = "default:fence_rail_junglewood",

        replace_mode = default_add_mode,
        burnlevel = burnlevel,
        description = S("Jungle Tree Wood Fence Rail"),
    })

    if doors_add_mode ~= "defer" or not core.get_modpath("doors") then

        unilib.register_fence_gate_quick({
            -- From doors:gate_junglewood_closed, etc. Creates unilib:gate_jungle_closed, etc
            part_name = "jungle",
            orig_name = {"doors:gate_junglewood_closed", "doors:gate_junglewood_open"},

            replace_mode = doors_add_mode,
            burnlevel = burnlevel,
            description = S("Jungle Tree Wood Fence Gate"),
        })

    end

    unilib.register_decoration_generic("default_tree_jungle", {
        -- From default/mapgen.lua
        deco_type = "schematic",
        schematic = unilib.core.path_mod .. "/mts/unilib_tree_jungle.mts",

        fill_ratio = 0.1,
        flags = "place_center_x, place_center_z",
        rotation = "random",
        sidelen = 80,
    })

    -- Due to 32 node height, altitude is limited and presence depends on chunksize
    local chunksize = tonumber(core.get_mapgen_setting("chunksize"))
    if chunksize >= 5 then

        unilib.register_decoration_generic("default_tree_jungle_emergent", {
            -- From default/mapgen.lua
            deco_type = "schematic",
            schematic = unilib.core.path_mod .. "/mts/unilib_tree_jungle_emergent.mts",

            flags = "place_center_x, place_center_z",
            noise_params = {
                octaves = 3,
                offset = 0.0,
                persist = 0.7,
                scale = 0.0025,
                seed = 2685,
                spread = {x = 250, y = 250, z = 250},
            },
            place_offset_y = -4,
            rotation = "random",
            sidelen = 80,
        })

    end

    unilib.register_decoration_generic("default_tree_jungle_swamp", {
        -- From default/mapgen.lua
        deco_type = "schematic",
        schematic = unilib.core.path_mod .. "/mts/unilib_tree_jungle.mts",

        flags = "place_center_x, place_center_z",
        noise_params = {
            -- Noise tuned to place swamp trees where papyrus is absent
            octaves = 1,
            offset = 0.0,
            persist = 0.5,
            scale = -0.1,
            seed = 354,
            spread = {x = 200, y = 200, z = 200},
        },
        rotation = "random",
        sidelen = 16,
    })

    if unilib.global.pkg_executed_table["mushroom_brown"] ~= nil then

        unilib.register_decoration_generic("default_tree_jungle_log", {
            -- From default/mapgen.lua
            deco_type = "schematic",
            schematic = unilib.core.path_mod .. "/mts/unilib_tree_jungle_log.mts",

            fill_ratio = 0.005,
            flags = "place_center_x",
            place_offset_y = 1,
            rotation = "random",
            sidelen = 80,
        })

    end

end
