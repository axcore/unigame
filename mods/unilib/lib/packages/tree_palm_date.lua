---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    moretrees
-- Code:    LGPL 3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_palm_date = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.moretrees.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_palm_date.init()

    return {
        description = "Date palm tree",
        notes = "Whereas palm trees spawn on ordinary sand, date palm trees spawn on desert sand" ..
                " (and both require water nearby). Produces dates",
        depends = {"fruit_date", "shared_moretrees"},
        optional = "sand_desert",
    }

end

function unilib.pkg.tree_palm_date.exec()

    local burnlevel = 2
    local sci_name = "Phoenix dactylifera"

    unilib.register_tree({
        -- Original to unilib
        part_name = "palm_date",
        description = S("Date Palm Tree Wood"),
    })

    unilib.register_tree_trunk({
        -- From moretrees:date_palm_trunk. Creates unilib:tree_palm_date_trunk
        part_name = "palm_date",
        orig_name = "moretrees:date_palm_trunk",

        replace_mode = mode,
        description = S("Date Palm Tree Trunk"),
        group_table = {
            choppy = 2, flammable = 2, oddly_breakable_by_hand = 1, snappy = 1, tree = 1,
        },
        sci_name = sci_name,
    })

    unilib.register_tree_wood({
        -- From moretrees:date_palm_plank. Creates unilib:tree_palm_date_wood
        part_name = "palm_date",
        orig_name = "moretrees:date_palm_plank",

        replace_mode = mode,
        description = S("Date Palm Tree Wood Planks"),
        group_table = {
            choppy = 2, flammable = 3, oddly_breakable_by_hand = 2, snappy = 1, wood = 1,
        },
    })

    unilib.register_tree_leaves({
        -- From moretrees:date_palm_leaves. Creates unilib:tree_palm_date_leaves
        part_name = "palm_date",
        orig_name = "moretrees:date_palm_leaves",

        replace_mode = mode,
        description = S("Date Palm Tree Leaves"),
        group_table = {flammable = 2, leafdecay = 1, leaves = 1, snappy = 3},
        sapling_rarity = 100,
        sci_name = sci_name,
    })
    unilib.register_leafdecay({
        -- From moretrees:date_palm_leaves
        trunk_type = "palm_date",
        trunks = {"unilib:tree_palm_date_trunk"},
        leaves = {"unilib:tree_palm_date_leaves"},
        others = {"unilib:fruit_date_hanging"},
        -- N.B. A large radius is required, because the tree's "brances" are made out of leaves
        radius = 14,
    })
    unilib.register_craft({
        -- From moretrees:date_palm_leaves
        type = "fuel",
        recipe = "unilib:tree_palm_date_leaves",
        burntime = 1,
    })

    -- The original moretrees mod had some special code that allowed fruit to re-grow under certain
    --      conditions (including the requirement for a male tree to be nearby)
    -- Much of that special code has not been imported. Instead, the imported ABM has been
    --      re-designed to occasionally regrow the fruit, if unilib.setting.regrow_fruit_flag
    --      permits it. Otherwise, the fruit are "grown" just once, almost immediately after the
    --      tree spawns
    -- Comments in the original moretrees code describe why an ABM is necessary: "Dates can't be
    --      generated as fruit, because there is no support for the special fruit trunks that allow
    --      dates to regrow at the correct position in the tree"
    local original_table = core.registered_nodes["unilib:tree_palm_date_trunk"]
    -- N.B. Our "fertile" trunk looks the same as the normal trunk; we don't flip the textures as
    --      the original code did
    local fertile_table = unilib.utils.clone_simple_table(original_table)
    fertile_table.groups.not_in_creative_inventory = 1
    fertile_table.drop = "unilib:tree_palm_date_trunk"

    unilib.register_node(
        -- From moretrees:palm_date_trunk_gen, moretrees:date_palm_fruit_trunk, etc
        "unilib:tree_palm_date_trunk_fertile",
        {"moretrees:palm_date_trunk_gen", "moretrees:date_palm_fruit_trunk"},
        mode,
        fertile_table
    )

    unilib.register_tree_trunk_stripped({
        -- From moretrees:date_palm_trunk. Creates unilib:tree_palm_date_trunk_stripped
        part_name = "palm_date",
        orig_name = {"moretrees:date_palm_fruit_trunk", "moretrees:date_palm_fruit_trunk"},

        replace_mode = mode,
        description = S("Date Palm Tree Trunk"),
        group_table = fertile_table.groups,
        variant_name = "fertile",
    })

    unilib.register_tree_sapling({
        -- From moretrees:palm_date_sapling. Creates unilib:tree_palm_date_sapling
        part_name = "palm_date",
        orig_name = "moretrees:date_palm_sapling",

        replace_mode = mode,
        burntime = 10,
        description = S("Date Palm Tree Sapling"),
        group_table = {
            attached_node = 1, dig_immediate = 3, flammable = 2, sapling = 1, snappy = 2,
        },
        ltree_model = {
            trunk = "unilib:tree_palm_date_trunk",
            leaves = "unilib:tree_palm_date_leaves",
            fruit = "unilib:tree_palm_date_trunk_fertile",

            angle = 18,
            axiom = "TTTTddddddddddccccccccccRT[TTT]" ..
                    "ccccc[&&a]ccccc[&&a]ccccc[&&a]ccccc[&&a]ccccc[&&a]ccccc[&&a]" ..
                    "GGccccc[&a]ccccc[&a]ccccc[&a]ccccc[&a]ccccc[&a]ccccc[&a]" ..
                    "GGccccc[a]ccccc[a]ccccc[a]ccccc[a]ccccc[a]ccccc[a]",
            fruit_chance = 0,
            iterations = 1,
            random_level = 0,
            rules_a = "Gffb&bbb[++f--&ffff&ff][--f++&ffff&ff]&ff&ff&bb&bb&bb",
            rules_b = "f",
            rules_c = "/",
            rules_d = "F",
            thin_branches = false,
            trunk_type = "single",
        },
        max_volume = 4,
        maxp_table = {x = 3, y = 6, z = 3},
        minp_table = {x = -3, y = 1, z = -3},
        sci_name = sci_name,
        select_table = {-0.3, -0.5, -0.3, 0.3, 0.35, 0.3},
        under_list = {"unilib:sand_desert", "default:desert_sand"},
    })

    -- ABM to spawn initial fruits
    local interval = 1
    if unilib.setting.regrow_fruit_flag then
        interval = math.random(unilib.setting.sapling_grow_min, unilib.setting.sapling_grow_max)
    end

    unilib.register_abm({
        label = "Spawn initial dates, and later regrow them [tree_palm_date]",
        nodenames = {"unilib:tree_palm_date_trunk_fertile"},

        chance = 1,
        interval = interval,

        action = function(pos, node, active_object_count, active_object_count_wider)

            -- If regrowing fruit is disabled, replace the "fertile" trunk with a normal one
            if not unilib.setting.regrow_fruit_flag then
                core.swap_node(pos, {name = "unilib:tree_palm_date_trunk"})
            end

            -- Count dates in the immediate vicinity; a maximum of four are allowed
            local fruit_list = core.find_nodes_in_area(
                {x = pos.x - 2, y = pos.y, z = pos.z - 2},
                {x = pos.x + 2, y = pos.y, z = pos.z + 2},
                "unilib:fruit_date_hanging"
            )

            local count = #fruit_list
            if count < 4 then

                -- Spawn (or regrow) dates
                local pos_list = core.find_nodes_in_area(
                    {x = pos.x - 2, y = pos.y, z = pos.z - 2},
                    {x = pos.x + 2, y = pos.y, z = pos.z + 2},
                    "air"
                )

                local gen_list = {}
                for k, v in pairs(pos_list) do
                    gen_list[k] = {x = math.random(100), pos = v}
                end

                table.sort(gen_list, function(a, b) return a.x < b.x; end)

                local count = 0
                for _, gen in pairs(gen_list) do

                    core.swap_node(gen.pos, {name = "unilib:fruit_date_hanging"})
                    count = count + 1
                    if count == 4 then
                        break
                    end

                end

            end

        end,
    })

    unilib.register_fence_quick({
        -- From moretrees:date_palm_fence. Creates unilib:tree_palm_date_wood_fence
        part_name = "palm_date",
        orig_name = "moretrees:date_palm_fence",

        replace_mode = mode,
        base_img = "unilib_tree_palm_date_wood.png",
        description = S("Date Palm Tree Wood Fence"),
    })

    unilib.register_fence_rail_quick({
        -- From moretrees:date_palm_fence_rail. Creates unilib:tree_palm_date_wood_fence_rail
        part_name = "palm_date",
        orig_name = "moretrees:date_palm_fence_rail",

        replace_mode = mode,
        base_img = "unilib_tree_palm_date_wood.png",
        description = S("Date Palm Tree Wood Fence Rail"),
    })

    unilib.register_fence_gate_quick({
        -- From moretrees:date_palm_gate_closed, etc. Creates unilib:gate_palm_date_closed, etc
        part_name = "palm_date",
        orig_name = {"moretrees:date_palm_gate_closed", "moretrees:date_palm_gate_open"},

        replace_mode = mode,
        description = S("Date Palm Tree Wood Fence Gate"),
    })

    -- N.B. This decoration combines the two decorations in original moretrees code
    unilib.register_decoration_convertable({
        -- Creates generic definition "convert_tree_palm_date"
        part_name = "tree_palm_date",
        convert_func = unilib.pkg.shared_moretrees.grow_ltree,
        replace_mode = mode,

        climate_table = {
            humidity_max = unilib.utils.convert_biome_lib_temp(0.20),
            temp_min = unilib.utils.convert_biome_lib_temp(-0.20),
        },
        generic_def_table = {
            fill_ratio = unilib.utils.convert_biome_lib({
                rarity = 10,
            }),
        },
        space_table = {
            height = 26,
            width = 17,
            sub_name = "unilib:tree_palm_date_sapling",
        },
    })

end
