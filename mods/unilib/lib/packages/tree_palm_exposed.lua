---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    moretrees
-- Code:    LGPL 3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_palm_exposed = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.moretrees.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_palm_exposed.init()

    return {
        description = "Exposed palm tree",
        notes = "Re-uses nodes from ethereal-ng's palm tree, but uses a different model, making" ..
                " it look bent-over as if it grew up in strong winds. The moretrees code for" ..
                " regrowing coconuts was not imported, but the unilib re-growing mechanism" ..
                " will still work (when enabled). Produces coconuts",
        depends = {"fruit_coconut", "shared_moretrees", "tree_palm"},
        optional = "sand_ordinary",
    }

end

function unilib.pkg.tree_palm_exposed.exec()

    -- (no burnlevel)
    -- (no sci_name)

    unilib.register_tree({
        -- Original to unilib
        part_name = "palm_exposed",
        -- N.B. Not "Exposed Palm Tree Wood", obviously
        description = S("Palm Tree Wood"),

        not_super_flag = true,
    })

    -- (trunk, wood and leaves from the "tree_palm" package)

    unilib.override_item("unilib:tree_palm_leaves", {
        drop = {
            max_items = 1,
            items = {
                {items = {"unilib:tree_palm_sapling"}, rarity = 10},
                {items = {"unilib:tree_palm_exposed_sapling"}, rarity = 20},
                {items = {"unilib:tree_palm_leaves"}},
            },
        },
    })

    -- Notes from moretrees:
    -- Coconuts can't be generated as fruit, because there is no support for the special fruit
    --      trunks that allow coconuts to regrow at the correct position in the tree
    -- So, a placeholder fruit trunk is spawned. An ABM will convert it to the final fruit trunk,
    --      and generate the actual coconuts
    local original_table = core.registered_nodes["unilib:tree_palm_trunk"]
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
    placeholder_table.tiles[1] = "unilib_tree_palm_trunk_top.png^[transformR180"
    placeholder_table.groups.not_in_creative_inventory = 1
    placeholder_table.drop = "unilib:tree_palm_trunk"
    -- (Function commented out, as nothing seems to call it)
    --[[
    placeholder_table.after_destruct = function(pos, oldnode)

        local coconut_list = core.find_nodes_in_area(
            {x = pos.x - 1, y = pos.y, z = pos.z - 1},
            {x = pos.x + 1, y = pos.y, z = pos.z + 1},
            {"unilib:fruit_coconut"}
        )

        for _, coconut_pos in pairs(coconut_list) do

            local item_str_list = core.get_node_drops(core.get_node(coconut_pos).name)
            core.swap_node(coconut_pos, {name = "air"})
            for _, item_str_name in pairs(item_str_list) do
                core.add_item(coconut_pos, item_str_name)
            end

        end

    end
    ]]--

    unilib.register_node(
        -- From moretrees:palm_fruit_trunk_gen
        "unilib:tree_palm_exposed_trunk_placeholder",
        "moretrees:palm_fruit_trunk_gen",
        mode,
        placeholder_table
    )

    fertile_table.tiles[1] = "unilib_tree_palm_trunk_top.png^[transformR90"
    fertile_table.groups.not_in_creative_inventory = 1
    fertile_table.drop = "unilib:tree_palm_trunk"

    unilib.register_node(
        -- From moretrees:palm_fruit_trunk
        "unilib:tree_palm_exposed_trunk_fertile",
        "moretrees:palm_fruit_trunk",
        mode,
        fertile_table
    )

    unilib.register_tree_sapling({
        -- From moretrees:palm_sapling. Creates unilib:tree_palm_exposed_sapling
        part_name = "palm_exposed",
        orig_name = "moretrees:palm_sapling",

        replace_mode = mode,
        burntime = 10,
        description = S("Exposed Palm Tree Sapling"),
        group_table = {
            attached_node = 1, dig_immediate = 3, flammable = 2, sapling = 1, snappy = 2,
        },
        ltree_model = {
            trunk = "unilib:tree_palm_trunk",
            leaves = "unilib:tree_palm_leaves",
            fruit = "unilib:tree_palm_exposed_trunk_placeholder",

            angle = 30,
            axiom = "FFcccccc&FFFFFdddRA//A//A//A//A//A",
            fruit_chance = 0,
            iterations = 2,
            random_level = 0,
            rules_a = "[&fb&bbb[++f--&ffff&ff][--f++&ffff&ff]&ffff&bbbb&b]",
            rules_b = "f",
            rules_c = "/",
            rules_d = "F",
            thin_branches = true,
            trunk_type = "single",
        },
        max_volume = 4,
        maxp_table = {x = 3, y = 6, z = 3},
        minp_table = {x = -3, y = 1, z = -3},
        select_table = {-0.3, -0.5, -0.3, 0.3, 0.35, 0.3},
        under_list = {"unilib:sand_ordinary", "default:sand"},
    })

    -- ABM to spawn initial coconuts
    unilib.register_abm({
        label = "Spawn initial coconuts [tree_palm_exposed]",
        nodenames = {"unilib:tree_palm_exposed_trunk_placeholder"},

        chance = 1,
        interval = 1,

        action = function(pos, node, active_object_count, active_object_count_wider)

            -- Replace the placeholder
            core.swap_node(pos, {name = "unilib:tree_palm_exposed_trunk_fertile"})

            -- Spawn coconuts
            local pos_list = core.find_nodes_in_area(
                {x = pos.x - 1, y = pos.y, z = pos.z - 1},
                {x = pos.x + 1, y = pos.y, z = pos.z + 1},
                "air"
            )

            local gen_list = {}
            for k,v in pairs(pos_list) do
                gen_list[k] = {x = math.random(100), pos = v}
            end

            table.sort(gen_list, function(a, b) return a.x < b.x; end)

            local count = 0
            for _, gen in pairs(gen_list) do

                core.swap_node(gen.pos, {name = "unilib:fruit_coconut"})
                count = count + 1
                if count == 4 then
                    break
                end

            end
        end,
    })

    -- (fences and gates from the "tree_palm" package)

    unilib.register_decoration_convertable({
        -- Creates generic definition "convert_tree_palm_exposed"
        part_name = "tree_palm_exposed",
        convert_func = unilib.pkg.shared_moretrees.grow_ltree,
        replace_mode = mode,

        climate_table = {
            temp_max = unilib.utils.convert_biome_lib_temp(0.25),
            temp_min = unilib.utils.convert_biome_lib_temp(-0.15),
        },
        generic_def_table = {
            fill_ratio = unilib.utils.convert_biome_lib({
                rarity = 50,
            }),
        },
        space_table = {
            height = 14,
            width = 17,
            sub_name = "unilib:tree_palm_exposed_sapling",
        },
    })

end
