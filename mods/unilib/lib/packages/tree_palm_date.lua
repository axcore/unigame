---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    moretrees
-- Code:    LGPL 3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_palm_date = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.moretrees.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_palm_date.init()

    return {
        description = "Date palm tree",
        notes = "Whereas palm trees spawn on ordinary sand, date palm trees spawn on desert sand" ..
                " (and both require water nearby). The moretrees code for pollination and " ..
                " regrowing dates was not imported, so dates will not regrow even when the" ..
                " Minetest setting is enabled. Produces dates",
        depends = {"fruit_date", "shared_moretrees"},
        optional = "sand_desert",
    }

end

function unilib.pkg.tree_palm_date.exec()

    -- (no burnlevel)
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
        strip_flag = true,
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
        trunks = {"unilib:tree_palm_date_trunk"},
        leaves = {"unilib:tree_palm_date_leaves", "unilib:fruit_date_hanging"},
        -- N.B. A large radius is required, because the tree's "brances" are made out of leaves
        radius = 14,
    })
    unilib.register_craft({
        -- From moretrees:date_palm_leaves
        type = "fuel",
        recipe = "unilib:tree_palm_date_leaves",
        burntime = 1,
    })

    -- Notes from moretrees:
    -- Dates can't be generated as fruit, because there is no support for the special fruit trunks
    --      that allow dates to regrow at the correct position in the tree
    -- So, a placeholder fruit trunk is spawned. An ABM will convert it to the final fruit trunk,
    --      and generate the actual dates
    local original_table = minetest.registered_nodes["unilib:tree_palm_date_trunk"]
    -- Definition table for the placeholder node created by the l-system model
    local placeholder_table = {}
    -- Definition table for the replacement node, under which coconut is spawned
    local fertile_table = {}

    for k,v in pairs(original_table) do

        placeholder_table[k] = v
        fertile_table[k] = v

    end

    placeholder_table.tiles = {}
    fertile_table.tiles = {}

    for k,v in pairs(original_table.tiles) do

        placeholder_table.tiles[k] = v
        fertile_table.tiles[k] = v

    end

    -- Notes from moretrees:
    -- Make the different trunk types distinguishable (but barely)
    placeholder_table.tiles[1] = "unilib_tree_palm_date_trunk_top.png^[transformR180"
    placeholder_table.groups.not_in_creative_inventory = 1
    placeholder_table.drop = "unilib:tree_palm_date_trunk"
    -- N.B. Function commented out, as nothing seems to call it
    --[[
    placeholder_table.after_destruct = function(pos, oldnode)

        local date_list = minetest.find_nodes_in_area(
            {x = pos.x - 2, y = pos.y, z = pos.z - 2},
            {x = pos.x + 2, y = pos.y, z = pos.z + 2},
            {"unilib:fruit_date_hanging"}
        )

        for _, date_pos in pairs(date_list) do

            local item_str_list = minetest.get_node_drops(minetest.get_node(date_pos).name)
            minetest.swap_node(date_pos, {name = "air"})
            for _, item_str_name in pairs(item_str_list) do
                minetest.add_item(date_pos, item_str_name)
            end

        end

    end
    ]]--

    unilib.register_node(
        -- From moretrees:palm_date_trunk_gen
        "unilib:tree_palm_date_trunk_placeholder",
        "moretrees:palm_date_trunk_gen",
        mode,
        placeholder_table
    )

    fertile_table.tiles[1] = "unilib_tree_palm_trunk_top.png^[transformR90"
    fertile_table.groups.not_in_creative_inventory = 1
    fertile_table.drop = "unilib:tree_palm_trunk"

    unilib.register_node(
        -- From moretrees:date_palm_fruit_trunk, etc
        "unilib:tree_palm_date_trunk_fertile",
        {"moretrees:date_palm_fruit_trunk", "moretrees:date_palm_fruit_trunk"},
        mode,
        fertile_table
    )

    if unilib.super_tree_table["palm_date"] ~= nil then

        unilib.register_tree_trunk_stripped({
            -- From moretrees:date_palm_trunk. Creates unilib:tree_palm_date_trunk_stripped
            part_name = "palm_date",
            orig_name = {"moretrees:date_palm_fruit_trunk", "moretrees:date_palm_fruit_trunk"},

            replace_mode = mode,
            description = S("Date Palm Tree Trunk"),
            group_table = fertile_table.groups,
            variant_name = "fertile",
        })

    end

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
            fruit = "unilib:tree_palm_date_trunk_placeholder",

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

    -- ABM to spawn initial coconuts
    unilib.register_abm({
        label = "Spawn initial coconuts [tree_palm_date]",
        nodenames = {"unilib:tree_palm_date_trunk_placeholder"},

        chance = 1,
        interval = 1,

        action = function(pos, node, active_object_count, active_object_count_wider)

            -- Replace the placeholder
            minetest.swap_node(pos, {name = "unilib:tree_palm_date_trunk_fertile"})

            -- Spawn dates
            local pos_list = minetest.find_nodes_in_area(
                {x = pos.x - 2, y = pos.y, z = pos.z - 2},
                {x = pos.x + 2, y = pos.y, z = pos.z + 2},
                "air"
            )

            local gen_list = {}
            for k,v in pairs(pos_list) do
                gen_list[k] = {x = math.random(100), pos = v}
            end

            table.sort(gen_list, function(a, b) return a.x < b.x; end)

            local count = 0
            for _, gen in pairs(gen_list) do

                minetest.swap_node(gen.pos, {name = "unilib:fruit_date_hanging"})
                count = count + 1
                if count == 4 then
                    break
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
        -- From moretrees:date_palm_gate. Creates unilib:gate_palm_date_closed
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
            humidity_max = unilib.convert_biome_lib_temp(0.20),
            temp_min = unilib.convert_biome_lib_temp(-0.20),
        },
        generic_def_table = {
            fill_ratio = unilib.convert_biome_lib({
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
