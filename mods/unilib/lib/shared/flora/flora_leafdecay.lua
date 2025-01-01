---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- flora_leafdecay.lua
--      Handle leaf decay
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

-- (From default/functions.lua)
local movement_gravity = tonumber(core.settings:get("movement_gravity")) or unilib.constant.gravity

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function do_collapse(pos, collapse_list)

    -- Original to unilib
    -- After removing a trunk node, remove the trunk node immediately above, so that tree trunks
    --      collapse in columns

    local above_node = core.get_node({x = pos.x, y = pos.y + 1, z = pos.z})
    for _, trunk_name in pairs(collapse_list) do

        if above_node.name == trunk_name then

            core.dig_node({x = pos.x, y = pos.y + 1, z = pos.z})
            return

        end

    end

end

local function leafdecay_after_destruct(pos, oldnode, def_table)

    -- Adapted from default/functions.lua

    -- Start a timer to remove .leaves nodes, if no more nearby trunk nodes exist
    for _, this_pos in pairs(
        core.find_nodes_in_area(
            vector.subtract(pos, def_table.radius),
            vector.add(pos, def_table.radius),
            def_table.leaves
        )
    ) do
        local node = core.get_node(this_pos)
        local timer = core.get_node_timer(this_pos)
        if node.param2 ~= 1 and not timer:is_started() then
            timer:start(math.random(20, 120) / 10)
        end

    end

    -- Start a timer to remove .others nodes, if no more nearby trunk nodes exist
    for _, this_pos in pairs(
        core.find_nodes_in_area(
            vector.subtract(pos, def_table.radius),
            vector.add(pos, def_table.radius),
            def_table.others
        )
    ) do
        local node = core.get_node(this_pos)
        local timer = core.get_node_timer(this_pos)
        if not timer:is_started() then
            timer:start(math.random(20, 120) / 10)
        end

    end

    -- If Minetest settings permit, remove trunk node immediately above, so that the tree trunks
    --      collapse in a column
    if unilib.setting.weak_tree_flag or (
        unilib.setting.weak_slim_tree_flag and
        def_table.trunk_type ~= nil and
        unilib.global.tree_table[def_table.trunk_type]["slim_flag"] == true
    ) then
        do_collapse(pos, def_table.trunks)
    end

end

local function leafdecay_on_timer(pos, def_table)

    -- Adapted from default/functions.lua

    if core.find_node_near(pos, def_table.radius, def_table.trunks) then
        return false
    end

    local node = core.get_node(pos)
    local drops = core.get_node_drops(node.name)
    for _, item in ipairs(drops) do

        local will_drop_flag = false
        for _, leaves_name in pairs(def_table.leaves) do
            if leaves_name == item then
                will_drop_flag = true
            end
        end

        if not will_drop_flag then

            for _, others_name in pairs(def_table.others) do
                if others_name == item then
                    will_drop_flag = true
                end
            end

        end

        if core.get_item_group(item, "leafdecay_drop") ~= 0 or not will_drop_flag then

            core.add_item({
                x = pos.x - 0.5 + math.random(),
                y = pos.y - 0.5 + math.random(),
                z = pos.z - 0.5 + math.random(),
            }, item)

        end

    end

    core.remove_node(pos)
    core.check_for_falling(pos)

    -- Spawn a few particles for the removed node
    core.add_particlespawner({
        amount = 8,
        time = 0.001,

        maxpos = vector.add(pos, {x = 0.5, y = 0.5, z = 0.5}),
        minpos = vector.subtract(pos, {x = 0.5, y = 0.5, z = 0.5}),
        maxvel = vector.new(0.5, 0, 0.5),
        minvel = vector.new(-0.5, -1, -0.5),
        maxacc = vector.new(0, -movement_gravity, 0),
        minacc = vector.new(0, -movement_gravity, 0),
        maxsize = 0,
        minsize = 0,

        node = node,
    })

end

---------------------------------------------------------------------------------------------------
-- Handle leaf decay
---------------------------------------------------------------------------------------------------

function unilib.flora._register_leafdecay(def_table)

    -- Adapted from default/functions.lua
    -- Enables leaf decay for leaves nodes
    --
    -- Args:
    --      def_table (table): Table with the following fields
    --          trunk_type (str or nil): e.g. "aspen" for the tree provided by the "tree_aspen"
    --              package; nil for any non-tree packages (e.g. bushes). Note that some trees
    --              re-use trunks from other trees; the "tree_type" matches the trunk node, not the
    --              calling tree package
    --          trunks (list): List of nodes whose absence causes leafdecay; usuall only tree trunk
    --              nodes are in this list
    --          leaves (list or nil): List of nodes which must be destroyed in the absence of nearby
    --              tree trunks (etc), unless .param2 == 1. Usually only leaves nodes are in this
    --              list, because when they are placed manually, they are given .param2 == 1 in a
    --              call to unilib.flora.after_place_leaves()
    --          others (list or nil): List of nodes which must be destroyed in the absence of nearby
    --              tree trunks (etc), regardless of the value of .param2. For example, can be use
    --              for vines which use .param2 for their orientation; unilib typically adds fruits,
    --              nuts and so on to this list
    --          radius (int): The radius of the area around the leaves node checked for trunk nodes
    --              (minimum value 1)
    --      N.B. .trunk_type and .others are not used in the equivalent minetest_game code

    if def_table.leaves == nil then
        def_table.leaves = {}
    end

    if def_table.others == nil then
        def_table.others = {}
    end

    for _, full_name in pairs(def_table.trunks) do

        -- N.B. Unlike the original code, we check that the node actually exists; this allows the
        --      calling package to specify nodes that might not have been created
        if core.registered_nodes[full_name] ~= nil then

            unilib.override_item(full_name, {
                after_destruct = function(pos, oldnode)
                    leafdecay_after_destruct(pos, oldnode, def_table)
                end,
            })

        end

    end

    for _, full_name in pairs(def_table.leaves) do

        if core.registered_nodes[full_name] ~= nil then

            unilib.override_item(full_name, {
                on_timer = function(pos)
                    leafdecay_on_timer(pos, def_table)
                end,
            })

        end

    end

    for _, full_name in pairs(def_table.others) do

        if core.registered_nodes[full_name] ~= nil then

            unilib.override_item(full_name, {
                on_timer = function(pos)
                    leafdecay_on_timer(pos, def_table)
                end,
            })

        end

    end

end

function unilib.flora._register_quick_bush_leafdecay(part_name, radius)

    -- Wrapper function. By searching for unilib.register_leafdecay() itself, we can quickly find
    --      any bushes producing (for example) fruit
    --
    -- Args:
    --      part_name (str): e.g. "acacia"
    --      radius (int): e.g. 1. If nil, then the default radius of 1 is applied

    unilib.register_leafdecay({
        trunks = {"unilib:bush_" .. part_name .. "_stem"},
        leaves = {"unilib:bush_" .. part_name .. "_leaves"},
        radius = radius or 1,
    })

end

function unilib.flora._register_quick_tree_leafdecay(part_name, radius)

    -- Wrapper function. By searching for unilib.register_leafdecay() itself, we can quickly find
    --      any trees producing (for example) fruit
    --
    -- Args:
    --      part_name (str): e.g. "aspen"
    --      radius (int): e.g. 3. If nil, then the default radius of 3 is applied

    unilib.register_leafdecay({
        trunk_type = part_name,
        trunks = {"unilib:tree_" .. part_name .. "_trunk"},
        leaves = {"unilib:tree_" .. part_name .. "_leaves"},
        radius = radius or 3,
    })

end

---------------------------------------------------------------------------------------------------
-- Handle tree collapses (an after effect of leaf decay)
---------------------------------------------------------------------------------------------------

function unilib.flora._collapse_tree(pos, oldnode, collapse_list)

    -- Original to unilib
    -- Called from the .after_destruct() callback by (non-slim) trees, by any tree package that
    --      doesn't use the normal leafdecay code
    -- When the player digs a tree trunk (and the Minetest setting is enabled), all trunks above
    --      fall to the ground

    if unilib.setting.weak_tree_flag then
        do_collapse(pos, collapse_list)
    end

end

function unilib.flora._collapse_slim_tree(pos, oldnode, collapse_list)

    -- Original to unilib
    -- Called from the .after_destruct() callback by slim trees, by any tree package that doesn't
    --      use the normal leafdecay code
    -- When the player digs a tree trunk (and the Minetest setting is enabled), all trunks above
    --      fall to the ground

    if unilib.setting.weak_slim_tree_flag then
        do_collapse(pos, collapse_list)
    end

end

---------------------------------------------------------------------------------------------------
-- Prevent leaf decay for placed leaves
---------------------------------------------------------------------------------------------------

function unilib.flora._after_place_leaves(pos, placer, itemstack, pointed_thing)

    -- Adapted from default/functions.lua
    -- Prevents decay of placed leaves
    --
    -- Args:
    --      pos (table): Position of the placed node, e.g. {x = 1, y = 1, z = 1}
    --      placer (obj): Minetest userdata, e.g. "userdata: 0x40e309d8"
    --      itemstack (obj): Minetest itemstack, e.g. ItemStack("unilib:tree_aspen_leaves")
    --      pointed_thing (table): Minetest pointed_thing table

    if placer and placer:is_player() then

        local node = core.get_node(pos)
        node.param2 = 1
        core.set_node(pos, node)

    end

end
