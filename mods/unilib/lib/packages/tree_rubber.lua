---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    moretrees
-- Code:    LGPL 3.0
-- Media:   CC-by-SA 4.0
--
-- From:    technic/technic_worldgen
-- Code:    LGPL 2.0
-- Media:   unknown
--
-- From:    technic
-- Code:    LGPL 2.0
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_rubber = {}

local S = unilib.intllib
local moretrees_mode = unilib.global.imported_mod_table.moretrees.add_mode
local technic_mode = unilib.global.imported_mod_table.technic_worldgen.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_rubber.init()

    return {
        description = "Rubber tree",
        notes = "If technic is available, its tree tap is modified so it can extract latex from" ..
                " the unilib rubber tree",
        depends = "shared_moretrees",
    }

end

function unilib.pkg.tree_rubber.exec()

    local burnlevel = 3
    local sci_name = "Hevea brasiliensis"

    unilib.register_tree({
        -- Original to unilib
        part_name = "rubber",
        description = S("Rubber Tree Wood"),
    })

    unilib.register_tree_trunk({
        -- From moretrees:rubber_tree_trunk. Creates unilib:tree_rubber_trunk
        part_name = "rubber",
        orig_name = "moretrees:rubber_tree_trunk",

        replace_mode = moretrees_mode,
        description = S("Rubber Tree Trunk"),
        group_table = {
            choppy = 2, flammable = 2, oddly_breakable_by_hand = 1, snappy = 1, tree = 1,
        },
        sci_name = sci_name,
    })

    unilib.register_tree_wood({
        -- From moretrees:rubber_tree_plank. Creates unilib:tree_rubber_wood
        part_name = "rubber",
        orig_name = "moretrees:rubber_tree_plank",

        replace_mode = moretrees_mode,
        description = S("Rubber Tree Wood Planks"),
        group_table = {
            choppy = 2, flammable = 3, oddly_breakable_by_hand = 2, snappy = 1, wood = 1,
        },
    })

    unilib.register_tree_leaves({
        -- From moretrees:rubber_tree_leaves. Creates unilib:tree_rubber_leaves
        part_name = "rubber",
        orig_name = "moretrees:rubber_tree_leaves",

        replace_mode = moretrees_mode,
        description = S("Rubber Tree Leaves"),
        group_table = {flammable = 2, leafdecay = 1, leaves = 1, snappy = 3},
        sapling_rarity = 100,
        sci_name = sci_name,
    })
    unilib.register_quick_tree_leafdecay("rubber", 5)
    unilib.register_craft({
        -- From moretrees:rubber_tree_leaves
        type = "fuel",
        recipe = "unilib:tree_rubber_leaves",
        burntime = 1,
    })

    unilib.register_tree_sapling({
        -- From moretrees:rubber_tree_sapling. Creates unilib:tree_rubber_sapling
        part_name = "rubber",
        orig_name = "moretrees:rubber_tree_sapling",

        replace_mode = moretrees_mode,
        burntime = 10,
        description = S("Rubber Tree Sapling"),
        group_table = {
            attached_node = 1, dig_immediate = 3, flammable = 2, sapling = 1, snappy = 2,
        },
        ltree_model = {
            trunk = "unilib:tree_rubber_trunk",
            leaves = "unilib:tree_rubber_leaves",

            angle = 35,
            axiom = "FFFFA",
            iterations = 3,
            random_level = 1,
            rules_a = "[&FFBFA]////[&BFFFA]////[&FBFFA]",
            rules_b = "[&FFA]////[&FFA]////[&FFA]",
            thin_branches = true,
            trunk_type = "double",
        },
        max_volume = 4,
        maxp_table = {x = 3, y = 6, z = 3},
        minp_table = {x = -3, y = 1, z = -3},
        sci_name = sci_name,
        select_table = {-0.3, -0.5, -0.3, 0.3, 0.35, 0.3},
    })

    unilib.register_fence_quick({
        -- From moretrees:rubber_tree_fence. Creates unilib:tree_rubber_wood_fence
        part_name = "rubber",
        orig_name = "moretrees:rubber_treefence",

        replace_mode = moretrees_mode,
        base_img = "unilib_tree_rubber_wood.png",
        description = S("Rubber Tree Wood Fence"),
    })

    unilib.register_fence_rail_quick({
        -- From moretrees:rubber_tree_fence_rail. Creates unilib:tree_rubber_wood_fence_rail
        part_name = "rubber",
        orig_name = "moretrees:rubber_tree_fence_rail",

        replace_mode = moretrees_mode,
        base_img = "unilib_tree_rubber_wood.png",
        description = S("Rubber Tree Wood Fence Rail"),
    })

    unilib.register_fence_gate_quick({
        -- From moretrees:rubber_tree_gate_closed, etc. Creates unilib:gate_rubber_closed, etc
        part_name = "rubber",
        orig_name = {"moretrees:rubber_tree_gate_closed", "moretrees:rubber_tree_gate_open"},

        replace_mode = moretrees_mode,
        description = S("Rubber Tree Wood Fence Gate"),
    })

    unilib.register_decoration_convertable({
        -- Creates generic definition "convert_tree_rubber"
        part_name = "tree_rubber",
        convert_func = unilib.pkg.shared_moretrees.grow_ltree,
        replace_mode = moretrees_mode,

        climate_table = {
            temp_min = unilib.utils.convert_biome_lib_temp(-0.15),
        },
        generic_def_table = {
            fill_ratio = unilib.utils.convert_biome_lib({
                rarity = 75,
            }),
        },
        space_table = {
            height = 13,
            width = 15,
            sub_name = "unilib:tree_rubber_sapling",
        },
    })

    -- Override the tree tap from technic/technic, so that it can tap latex from both the original
    --      and unilib versions of the rubber tree
    if unilib.setting.technic_update_flag then

        unilib.register_node(
            -- From moretrees:rubber_tree_trunk_empty
            "unilib:tree_rubber_trunk_tapped",
            "moretrees:rubber_tree_trunk_empty",
            technic_mode,
            {
                description = S("Tapped Rubber Tree Trunk"),
                tiles = {
                    "unilib_tree_rubber_trunk_top.png",
                    "unilib_tree_rubber_trunk_top.png",
                    "unilib_tree_rubber_trunk_tapped.png",
                },
                groups = {
                    choppy = 2, flammable = 2, not_in_creative_inventory = 1,
                    oddly_breakable_by_hand = 1, snappy = 1, tree = 1,
                },
                sounds = unilib.global.sound_table.wood,
            }
        )

        unilib.register_tree_trunk_stripped({
            -- From moretrees:rubber_tree_trunk. Creates unilib:tree_rubber_trunk_stripped
            part_name = "rubber",
            orig_name = "moretrees:rubber_tree_trunk_empty",

            replace_mode = technic_mode,
            description = S("Tapped Rubber Tree Trunk"),
            group_table = {
                choppy = 2, flammable = 2, not_in_creative_inventory = 1,
                oddly_breakable_by_hand = 1, snappy = 1, tree = 1,
            },
            variant_name = "tapped",
        })

        unilib.register_craft({
            -- From moretrees:rubber_tree_trunk_empty
            type = "shapeless",
            output = "unilib:tree_rubber_wood 4",
            recipe = {
                "unilib:tree_rubber_trunk_tapped",
            },
        })

        unilib.override_item("technic:treetap", {
            on_use = function(itemstack, user, pointed_thing)

                if pointed_thing.type ~= "node" then
                    return
                end

                local pos = pointed_thing.under
                if core.is_protected(pos, user:get_player_name()) then

                    core.record_protection_violation(pos, user:get_player_name())
                    return

                end

                local node = core.get_node(pos)
                local node_name = node.name
                if node_name == "moretrees:rubber_tree_trunk" then
                    node.name = "moretrees:rubber_tree_trunk_empty"
                elseif node_name == "unilib:tree_rubber_trunk" then
                    node.name = "unilib:tree_rubber_trunk_tapped"
                else
                    return
                end

                core.swap_node(pos, node)
                core.handle_node_drops(pointed_thing.above, {"technic:raw_latex"}, user)

--              if not technic.creative_mode then
                if not unilib.utils.is_creative(user:get_player_name()) then

                    local item_wear = tonumber(itemstack:get_wear())
--                  item_wear = item_wear + 819
                    item_wear = item_wear + math.floor(unilib.constant.max_tool_wear / 80)
                    if item_wear > unilib.constant.max_tool_wear then

                        itemstack:clear()
                        return itemstack

                    end

                    itemstack:set_wear(item_wear)

                end

                return itemstack

            end,
        })

        unilib.register_abm({
            label = "Rubber tree tap [tree_rubber]",
            nodenames = {
                "unilib:tree_rubber_trunk_tapped",
                "moretrees:rubber_tree_trunk_empty",
            },

            chance = 15,
            interval = 60,

            action = function(pos, node)

                if core.find_node_near(pos, 5, {"unilib:tree_rubber_leaves"}) then

                    node.name = "unilib:tree_rubber_trunk"
                    core.swap_node(pos, node)

                end

            end
        })

    end

end
