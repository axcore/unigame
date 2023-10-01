---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- flora.lua
--      Set up shared functions for flora (mainly trees and bushes)
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

-- (From default/functions.lua)
local movement_gravity = tonumber(minetest.settings:get("movement_gravity")) or 9.81

---------------------------------------------------------------------------------------------------
-- Standard flora spreading (for flowers and some grasses)
---------------------------------------------------------------------------------------------------

function unilib.flora_spread(pos, node)

    -- Adapted from flowers/init.lua
    -- Called by the ABM code in ../lib/system/abms.lua
    -- The original code was a public function to enable overeride by mods
    --
    -- N.B. Because the original function is nullified by code in ../lib/system/abms.lua, this
    --      function handles both unilib sands and their minetest_game equivalents
    --
    -- Args:
    --      pos (table): e.g. {x = 1, y = 1, z = 1}
    --      node (table): e.g. {name = "foobar", param1 = 15, param2 = 0}

    pos.y = pos.y - 1
    local under = minetest.get_node(pos)
    pos.y = pos.y + 1

    -- Notes from flowers:
    -- Replace flora with dry shrub in desert sand and silver sand, as this is the only way to
    --      generate them. However, preserve grasses in sand dune biomes
    -- (In case the original sand node exists in the game, check for that, too)
    if minetest.get_item_group(under.name, "sand") == 1 and
            under.name ~= "unilib:sand_ordinary" and
            under.name ~= "default:sand" then

        if unilib.pkg_executed_table["plant_shrub_dry"] ~= nil then

            minetest.set_node(pos, {name = "unilib:plant_shrub_dry"})
            return

        elseif minetest.registered_nodes["default:sand"] ~= nil then

            minetest.set_node(pos, {name = "default:dry_shrub"})
            return

        end

    end

    if minetest.get_item_group(under.name, "soil") == 0 then
        return
    end

    local light = minetest.get_node_light(pos)
    if not light or light < unilib.light_min_grow_sapling then
        return
    end

    local pos0 = vector.subtract(pos, 4)
    local pos1 = vector.add(pos, 4)
    -- Notes from flowers:
    -- Testing shows that a threshold of 3 results in an appropriate maximum density of
    --      approximately 7 flora per 9x9 area.
    if #minetest.find_nodes_in_area(pos0, pos1, "group:flora") > 3 then
        return
    end

    local soils = minetest.find_nodes_in_area_under_air(pos0, pos1, "group:soil")
    local num_soils = #soils
    if num_soils >= 1 then

        for si = 1, math.min(3, num_soils) do

            local soil = soils[math.random(num_soils)]
            local soil_name = minetest.get_node(soil).name
            local soil_above = {x = soil.x, y = soil.y + 1, z = soil.z}
            light = minetest.get_node_light(soil_above)
            if light and light >= unilib.light_min_grow_sapling and
                    -- Only spread to same surface node
                    soil_name == under.name and
                    -- Desert sand is in the soil group
                    soil_name ~= "unilib:sand_desert" and
                    soil_name ~= "default:desert_sand" then

                minetest.set_node(soil_above, {name = node.name})

            end

        end

    end

end

---------------------------------------------------------------------------------------------------
-- Standard mushroom spreading
---------------------------------------------------------------------------------------------------

function unilib.mushroom_spread(pos, node)

    -- Adapted from flowers/init.lua
    -- Called by the ABM code in ../lib/system/abms.lua
    -- The original code was a public function to enable overeride by mods
    --
    -- Args:
    --      pos (table): e.g. {x = 1, y = 1, z = 1}
    --      node (table): e.g. {name = "unilib:foobar", param1 = 15, param2 = 0}

    if minetest.get_node_light(pos, 0.5) > 3 then

        if minetest.get_node_light(pos, nil) == 15 then
            minetest.remove_node(pos)
        end

        return

    end

    local positions = minetest.find_nodes_in_area_under_air(
        {x = pos.x - 1, y = pos.y - 2, z = pos.z - 1},
        {x = pos.x + 1, y = pos.y + 1, z = pos.z + 1},
        {"group:soil", "group:tree"}
    )
    if #positions == 0 then
        return
    end

    local pos2 = positions[math.random(#positions)]
    pos2.y = pos2.y + 1
    if minetest.get_node_light(pos2, 0.5) <= 3 then
        minetest.set_node(pos2, {name = node.name})
    end

end

---------------------------------------------------------------------------------------------------
-- Register growth stages
---------------------------------------------------------------------------------------------------

function unilib.register_growing(data_table)

    -- Original to unilib
    -- Called for any crop, produce, grass or plant that has multiple numbered growth stages (e.g.
    --      "unilib:crop_wheat_grow_1" > "unilib:crop_wheat_grow_8")
    --
    -- data_table compulsory fields:
    --      base_name (str): e.g. "unilib:crop_wheat_grow"
    --      mode (str): A string representing the code that handles the growth:
    --          "mtgame" if the crop was created by a call to unilib.register_crop_mtgame()
    --          "fredo" if the crop was created by a call to unilib.register_crop_fredo()
    --          "produce" if the produce was created by a call to unilib.register_produce_fredo()
    --          "other" for other growing items, such as grasses (growth is handled by the calling
    --              code itself)
    --      stage_max (int): The total number of growth stages, e.g. 8

    for i = 1, data_table.stage_max do

        unilib.grow_stage_table[data_table.base_name .. "_" .. i] = {
            base_name = data_table.base_name,
            mode = data_table.mode,
            stage = i,
            stage_max = data_table.stage_max,
        }

    end

end

---------------------------------------------------------------------------------------------------
-- Sapling placement
---------------------------------------------------------------------------------------------------

function unilib.sapling_on_place(
    itemstack, placer, pointed_thing, sapling_name, minp_relative, maxp_relative, interval
)
    -- Adapted from from default/trees.lua
    -- Sapling "on_place" function to check protection of node and resulting tree volume
    -- (Also used by the cactus in the "plant_cactus_ordinary" package)
    --
    -- Args:
    --      itemstack (obj): Minetest itemstack, e.g. ItemStack("unilib:tree_aspen_sapling 10")
    --      placer (obj): Minetest userdata, e.g. "userdata: 0x40e309d8"
    --      pointed_thing (table): Minetest pointed_thing table
    --      sapling_name (str): e.g. "unilib:tree_aspen_sapling"
    --      minp_relative (table): Minetest pos table, e.g. {x = -1, y = 0, z = -1}
    --      maxp_relative (table): Minetest pos table, e.g. {x = -1, y = 0, z = -1}
    --      interval (int): e.g. 2
    --
    -- Return values:
    --      Minetest itemstack, e.g. ItemStack("unilib:tree_aspen_sapling 10")

    -- Position of sapling
    local pos = pointed_thing.under
    local node = minetest.get_node_or_nil(pos)
    local pdef = node and minetest.registered_nodes[node.name]

    if pdef and pdef.on_rightclick and not (
        placer and
        placer:is_player() and
        placer:get_player_control().sneak
    ) then
        return pdef.on_rightclick(pos, node, placer, itemstack, pointed_thing)
    end

    if not pdef or not pdef.buildable_to then

        pos = pointed_thing.above
        node = minetest.get_node_or_nil(pos)
        pdef = node and minetest.registered_nodes[node.name]
        if not pdef or not pdef.buildable_to then
            return itemstack
        end

    end

    local player_name = placer and placer:get_player_name() or ""

    -- Check sapling position for protection
    if minetest.is_protected(pos, player_name) then

        minetest.record_protection_violation(pos, player_name)
        return itemstack

    end

    -- Check tree volume for protection
    if minetest.is_area_protected(
        vector.add(pos, minp_relative),
        vector.add(pos, maxp_relative),
        player_name,
        interval
    ) then
        minetest.record_protection_violation(pos, player_name)
        -- Print extra information to explain
        minetest.chat_send_player(player_name,
            S(
                "@1 will intersect protection on growth.",
                itemstack:get_definition().description
            )
        )

        return itemstack

    end

    unilib.log(
        "action",
        player_name .. " places node " .. sapling_name .. " at " .. minetest.pos_to_string(pos)
    )

    local take_item = not unilib.is_creative(player_name)
    local newnode = {name = sapling_name}
    local ndef = minetest.registered_nodes[sapling_name]
    minetest.set_node(pos, newnode)

    -- Run callback
    if ndef and ndef.after_place_node then

        -- Deepcopy place_to and pointed_thing because callback can modify it
        if ndef.after_place_node(table.copy(pos), placer,
                itemstack, table.copy(pointed_thing)) then
            take_item = false
        end

    end

    -- Run script hook
    for _, callback in ipairs(minetest.registered_on_placenodes) do
        -- Deepcopy pos, node and pointed_thing because callback can modify them
        if callback(
            table.copy(pos),
            table.copy(newnode),
            placer,
            table.copy(node or {}),
            itemstack,
            table.copy(pointed_thing)
        ) then
            take_item = false
        end
    end

    if take_item then
        itemstack:take_item()
    end

    return itemstack

end

---------------------------------------------------------------------------------------------------
-- Grow trees from saplings
---------------------------------------------------------------------------------------------------

function unilib.can_grow_sapling(pos, full_name)

    -- Adapted from default/trees.lua
    -- Can be called by anything. Called periodically from the on_timer() function of each tree/bush
    --      sapling
    --
    -- Args:
    --      pos (table): Location of the sapling, e.g. {x = 1, y = 1, z = 1}
    --      full_name (str): e.g. "unilib:tree_aspen_sapling"
    --
    -- Return values:
    --      true if the sapling should be grown, false if not

    -- Retrieve data for this sapling
    local data_table = unilib.sapling_table[full_name]
    if data_table == nil then
        return false
    end

    -- Check the sapling is "planted" on something
    local node_under = minetest.get_node_or_nil({x = pos.x, y = pos.y - 1, z = pos.z})
    if not node_under then
        return false
    end

    -- Check the node underneath
    if data_table.under_list == nil or unilib.sapling_everywhere_flag then

        -- Check the sapling is "planted" on some type of soil
        if minetest.get_item_group(node_under.name, "soil") == 0 then
            return false
        end

    else

        -- Check the sapling is "planted" on the right kind of node
        local match_flag = false
        for _, this_node in ipairs(data_table.under_list) do

            if this_node == node_under.name then

                match_flag = true
                break

            end

        end

        if not match_flag then
            return false
        end

    end

    -- Check that there are no obstructions immediately above the sapling (if a height was
    --      specified)
    -- Note that protection violations are checked in unilib.sapling_on_place()
    if data_table.min_height ~= nil then

        local nod = minetest.line_of_sight(
            {x = pos.x, y = pos.y + 1, z = pos.z},
            {x = pos.x, y = pos.y + data_table.min_height, z = pos.z}
        )
        if not nod then
            return false
        end

    end

    -- Check the sapling is receiving sufficient light
    local light_level = minetest.get_node_light(pos)
    if not light_level or
            (data_table.min_light ~= nil and light_level < data_table.min_light) or
            (data_table.min_light == nil and light_level < unilib.light_min_grow_sapling) then
        return false
    end

    return true

end

function unilib.is_snow_nearby(pos)

    -- Adapted from default/trees.lua
    -- Tests whether the coordinates have a neighbouring snow node (e.g. used by the "tree_pine"
    --      package to select a schematic with or without snow)
    --
    -- Args:
    --      pos (table): Location of the position to test, e.g. {x = 1, y = 1, z = 1}
    --
    -- Return values:
    --      pos of the snow node, or nil if no snow found

    return minetest.find_node_near(pos, 1, {"group:snowy"})

end

---------------------------------------------------------------------------------------------------
-- Handle leaf decay
---------------------------------------------------------------------------------------------------

local function leafdecay_after_destruct(pos, oldnode, def_table)

    -- Adapted from default/functions.lua

    for _, v in pairs(
        minetest.find_nodes_in_area(
            vector.subtract(pos, def_table.radius),
            vector.add(pos, def_table.radius),
            def_table.leaves
        )
    ) do
        local node = minetest.get_node(v)
        local timer = minetest.get_node_timer(v)
        if node.param2 ~= 1 and not timer:is_started() then
            timer:start(math.random(20, 120) / 10)
        end

    end

end

local function leafdecay_on_timer(pos, def_table)

    -- Adapted from default/functions.lua

    if minetest.find_node_near(pos, def_table.radius, def_table.trunks) then
        return false
    end

    local node = minetest.get_node(pos)
    local drops = minetest.get_node_drops(node.name)
    for _, item in ipairs(drops) do

        local is_leaf
        for _, v in pairs(def_table.leaves) do
            if v == item then
                is_leaf = true
            end
        end

        if minetest.get_item_group(item, "leafdecay_drop") ~= 0 or not is_leaf then

            minetest.add_item({
                x = pos.x - 0.5 + math.random(),
                y = pos.y - 0.5 + math.random(),
                z = pos.z - 0.5 + math.random(),
            }, item)

        end

    end

    minetest.remove_node(pos)
    minetest.check_for_falling(pos)

    -- Spawn a few particles for the removed node
    minetest.add_particlespawner({
        amount = 8,
        time = 0.001,
        minpos = vector.subtract(pos, {x=0.5, y=0.5, z=0.5}),
        maxpos = vector.add(pos, {x=0.5, y=0.5, z=0.5}),
        minvel = vector.new(-0.5, -1, -0.5),
        maxvel = vector.new(0.5, 0, 0.5),
        minacc = vector.new(0, -movement_gravity, 0),
        maxacc = vector.new(0, -movement_gravity, 0),
        minsize = 0,
        maxsize = 0,
        node = node,
    })

end

function unilib.register_leafdecay(def_table)

    -- Adapted from default/functions.lua
    -- Enables leaf decay for leaf nodes
    --
    -- Args:
    --      def_table (table): Table with the fields .trunks, .leaves, .radius

    for _, v in pairs(def_table.trunks) do

        unilib.override_item(v, {
            after_destruct = function(pos, oldnode)
                leafdecay_after_destruct(pos, oldnode, def_table)
            end,
        })

    end

    for _, v in pairs(def_table.leaves) do

        unilib.override_item(v, {
            on_timer = function(pos)
                leafdecay_on_timer(pos, def_table)
            end,
        })

    end

end

function unilib.register_quick_bush_leafdecay(part_name, radius)

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

function unilib.register_quick_tree_leafdecay(part_name, radius)

    -- Wrapper function. By searching for unilib.register_leafdecay() itself, we can quickly find
    --      any trees producing (for example) fruit
    --
    -- Args:
    --      part_name (str): e.g. "aspen"
    --      radius (int): e.g. 3. If nil, then the default radius of 3 is applied

    unilib.register_leafdecay({
        trunks = {"unilib:tree_" .. part_name .. "_trunk"},
        leaves = {"unilib:tree_" .. part_name .. "_leaves"},
        radius = radius or 3,
    })

end

---------------------------------------------------------------------------------------------------
-- Prevent leaf decay for placed leaves
---------------------------------------------------------------------------------------------------

function unilib.after_place_leaves(pos, placer, itemstack, pointed_thing)

    -- Adapted from default/functions.lua
    -- Prevents decay of placed leaves
    --
    -- Args:
    --      pos (table): Position of the placed node, e.g. {x = 1, y = 1, z = 1}
    --      placer (obj): Minetest userdata, e.g. "userdata: 0x40e309d8"
    --      itemstack (obj): Minetest itemstack, e.g. ItemStack("unilib:tree_aspen_leaves")
    --      pointed_thing (table): Minetest pointed_thing table

    if placer and placer:is_player() then

        local node = minetest.get_node(pos)
        node.param2 = 1
        minetest.set_node(pos, node)

    end

end

---------------------------------------------------------------------------------------------------
-- Set up 3d-rendered leaves (when in inventory or wielded)
---------------------------------------------------------------------------------------------------

function unilib.filter_leaves_img(img)

    if not unilib.rendered_leaves_flag then
        return img
    else
        return nil
    end

end

---------------------------------------------------------------------------------------------------
-- Regrow fruit, etc
---------------------------------------------------------------------------------------------------

function unilib.setup_regrowing_fruit(data_table)

    -- Adapted from default:apple and default:apple_mark
    -- Creates a placeholder which enables regrowing fruit, and sets up the regrowth code
    --      (e.g. "unilib:fruit_apple" can be regrown using "unilib:placeholder_fruit_apple")
    -- This function is designed for fruit and other things growing on trees (e.g. blossoms, nuts),
    --      but could be used in any comparable situation
    --
    -- N.B. This function should be called from within a package's .post() function. See the
    --      "fruit_apple" package for an example
    --
    -- data_table compulsory fields:
    --      fruit_name (str): The thing to regrow, e.g. "unilib:fruit_apple"
    --
    -- data_table optional fields:
    --      replace_mode (str): e.g. "defer"
    --      leaves_list (list): A surrounding node which must still exist, in order for the fruit to
    --          regrow, e.g. "unilib:tree_apple_leaves". If not specified or an empty list,
    --          "fruit_name" regrows regardless of its surroundings
    --      min_light(int): Minimum light for regrowth (1-14, default 11)
    --      orig_name (str): The placeholder's original name, e.g. "default:apple_mark"
    --      pkg_list (list): The package(s) that provides one or more of the items in "leaves_list".
    --          If not specified or an empty list, we assume that the calling package provides both
    --          the fruit and leaves nodes
    --      regrow_time (int): Regrowth time in seconds. If not specified, the regrowth time is the
    --          same as the standard sapling growth time (a random value between two limits)
    --
    -- Return values:
    --      The full name of the placeholder node, or nil if no placeholder was created

    local fruit_name = data_table.fruit_name

    local replace_mode = data_table.replace_mode or unilib.default_replace_mode
    local leaves_list = data_table.leaves_list or nil
    local min_light = data_table.min_light or 11
    local orig_name = data_table.orig_name or nil
    local pkg_list = data_table.pkg_list or nil
    local regrow_time = data_table.regrow_time or
            math.random(unilib.sapling_grow_min, unilib.sapling_grow_max)

    local pkg_loaded_flag = false
    if pkg_list ~= nil then

        for _, pkg in pairs(pkg_list) do

            if unilib.pkg_executed_table[pkg] ~= nil then

                pkg_loaded_flag = true
                break

            end

        end

    end

    if unilib.regrow_fruit_flag and pkg_loaded_flag then

        local placeholder_name = "unilib:placeholder_" .. unilib.get_item_name(fruit_name)

        unilib.register_node(placeholder_name, orig_name, replace_mode, {
            -- (no description)
            -- (no tiles)
            groups = {not_in_creative_inventory = 1},
            -- (no sounds)

            buildable_to = true,
            diggable = false,
            drawtype = "airlike",
            drop = "",
            paramtype = "light",
            pointable = false,
            sunlight_propagates = true,
            walkable = false,

            on_timer = function(pos, elapsed)

                if not minetest.find_node_near(pos, 1, leaves_list) then
                    minetest.remove_node(pos)
                elseif minetest.get_node_light(pos) < min_light then
                    minetest.get_node_timer(pos):start(regrow_time)
                else
                    minetest.set_node(pos, {name = fruit_name})
                end

            end,
        })

        unilib.override_item(fruit_name, {
            after_dig_node = function(pos, oldnode, oldmetadata, digger)

                if oldnode.param2 == 0 then

                    minetest.set_node(pos, {name = placeholder_name})
                    minetest.get_node_timer(pos):start(regrow_time)

                end

            end,
        })

        return placeholder_name

    else

        return nil

    end

end

---------------------------------------------------------------------------------------------------
-- Update sapling growth requirements
---------------------------------------------------------------------------------------------------

function unilib.update_sapling_growth_requirements()

    -- Called by ../lib/system/import_pkg.lua during the finalisation phase
    -- Some saplings require a specific dirt type on which to grow. If the Minetest setting is
    --      enabled, update these requirements to remove any dirts which have not been loaded
    -- N.B. The related Minetest setting, unilib.sapling_everywhere_flag, is handled above

    if not unilib.sapling_override_flag then
        return
    end

    for full_name, data_table in pairs(unilib.sapling_table) do

        if data_table.under_list ~= nil then

            local adj_list = {}

            for _, dirt_name in pairs(data_table.under_list) do

                if minetest.registered_nodes[dirt_name] ~= nil then
                    table.insert(adj_list, dirt_name)
                end

            end

            data_table.under_list = adj_list

        end

    end

end

---------------------------------------------------------------------------------------------------
-- Handle flowerpots (used with flowers, mushrooms, plants and saplings)
---------------------------------------------------------------------------------------------------

function unilib.register_flower_in_pot(full_name, orig_name)

    -- Original to unilib
    -- Can be called by unilib.register_flower() and unilib.register_beautiflower(), or
    --      independently by packages which create flowers or any other plants which are compatible
    --      with flowerpots
    -- Flowerpot packages should create an empty flowerpot in their .exec() functions, and then use
    --      list to register flowers in that pot during their .post() functionss
    --
    -- Some items are not suitable for use in flowerpots, and should not be used in calls to this
    --      function (and the ones below):
    --
    --      - Craftitems (and tools!)
    --      - Nodes drawn using a mesh
    --      - Nodes drawn with the .drawtype "firelike" or "nodebox"
    --      - Nodes that drop something other than themselves, e.g. seeds from "wild" plants
    --      - Nodes that drop nothing, i.e. .drop = ""
    --      - Nodes that would not be compatible in real life (e.g. underwater plants)
    --      - Nodes which have the "not_in_creative_inventory" group set
    --
    -- Arguments:
    --      full_name (str): e.g. unilib:flower_rose_red
    --      orig_name (str): e.g. flowers:rose

    if unilib.flowerpot_add_flowers_flag then
        unilib.flowerpot_compat_table[full_name] = orig_name or ""
    end

end

function unilib.register_mushroom_in_pot(full_name, orig_name)

    -- Modified version of unilib.register_flower_in_pot(), for mushrooms
    --
    -- Arguments:
    --      full_name (str): e.g. unilib:flower_rose_red
    --      orig_name (str): e.g. flowers:rose

    if unilib.flowerpot_add_mushrooms_flag then
        unilib.flowerpot_compat_table[full_name] = orig_name or ""
    end

end

function unilib.register_plant_in_pot(full_name, orig_name)

    -- Modified version of unilib.register_flower_in_pot(), for ferns, grasses and plants
    --
    -- Arguments:
    --      full_name (str): e.g. unilib:flower_rose_red
    --      orig_name (str): e.g. flowers:rose

    if unilib.flowerpot_add_plants_flag then
        unilib.flowerpot_compat_table[full_name] = orig_name or ""
    end

end

function unilib.register_sapling_in_pot(full_name, orig_name)

    -- Modified version of unilib.register_flower_in_pot(), for saplings
    --
    -- Arguments:
    --      full_name (str): e.g. unilib:flower_rose_red
    --      orig_name (str): e.g. flowers:rose

    if unilib.flowerpot_add_saplings_flag then
        unilib.flowerpot_compat_table[full_name] = orig_name or ""
    end

end
