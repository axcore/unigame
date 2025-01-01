---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ropes
-- Code:    MIT
-- Media:   unknown (textures), CC0 (sounds)
---------------------------------------------------------------------------------------------------

unilib.pkg.shared_ropes = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

local c_air = core.get_content_id("air")

-- N.B. In the original code, the ropes can drop into air or airlike-nodes, but stop at other
--      obstructions. If it's necessary to modify this behaviour, then these variables can be
--      changed
local can_extend_into_table = {["air"] = true}
local can_extend_into_airlike_flag = true

-- Rope lengths increase in multiples of 50
local min_rope_length = 50
-- Burntime for ropes and wood
local rope_burntime = 6
local wood_burntime = 7

-- Table providing the node_box for each spool, and the tile set to use for each spool (in the
--      range 1-5)
local spool_data = {
    {
        node_box = {
            {-0.125, -0.125, -0.25, 0.125, 0.125, 0.25},
            {-0.125, -0.25, -0.125, 0.125, 0.25, 0.125},
            {-0.125, -0.1875, -0.1875, 0.125, 0.1875, 0.1875},
            {-0.1875, -0.5, -0.125, -0.125, 0.125, 0.125},
            {0.125, -0.5, -0.125, 0.1875, 0.125, 0.125},
        },
        img_set = 1,
    },
    {
        node_box = {
            {-0.1875, -0.125, -0.25, 0.1875, 0.125, 0.25},
            {-0.1875, -0.25, -0.125, 0.1875, 0.25, 0.125},
            {-0.1875, -0.1875, -0.1875, 0.1875, 0.1875, 0.1875},
            {-0.25, -0.5, -0.125, -0.1875, 0.125, 0.125},
            {0.1875, -0.5, -0.125, 0.25, 0.125, 0.125},
        },
        img_set = 2,
    },
    {
        node_box = {
            {-0.25, -0.125, -0.25, 0.25, 0.125, 0.25},
            {-0.25, -0.25, -0.125, 0.25, 0.25, 0.125},
            {-0.25, -0.1875, -0.1875, 0.25, 0.1875, 0.1875},
            {-0.3125, -0.5, -0.125, -0.25, 0.125, 0.125},
            {0.25, -0.5, -0.125, 0.3125, 0.125, 0.125},
        },
        img_set = 3,
    },
    {
        node_box = {
            {-0.3125, -0.125, -0.25, 0.3125, 0.125, 0.25},
            {-0.3125, -0.25, -0.125, 0.3125, 0.25, 0.125},
            {-0.3125, -0.1875, -0.1875, 0.3125, 0.1875, 0.1875},
            {-0.375, -0.5, -0.125, -0.3125, 0.125, 0.125},
            {0.3125, -0.5, -0.125, 0.375, 0.125, 0.125},
        },
        img_set = 4,
    },
    {
        node_box = {
            {-0.375, -0.125, -0.25, 0.375, 0.125, 0.25},
            {-0.375, -0.25, -0.125, 0.375, 0.25, 0.125},
            {-0.375, -0.1875, -0.1875, 0.375, 0.1875, 0.1875},
            {-0.4375, -0.5, -0.125, -0.375, 0.125, 0.125},
            {0.375, -0.5, -0.125, 0.4375, 0.125, 0.125},
        },
        img_set = 5,
    },
    {
        node_box = {
            {-0.1875, -0.1875, -0.3125, 0.1875, 0.1875, 0.3125},
            {-0.1875, -0.3125, -0.1875, 0.1875, 0.3125, 0.1875},
            {-0.1875, -0.25, -0.25, 0.1875, 0.25, 0.25},
            {-0.25, -0.5, -0.125, -0.1875, 0.125, 0.125},
            {0.1875, -0.5, -0.125, 0.25, 0.125, 0.125},
        },
        img_set = 2,
    },
    {
        node_box = {
            {-0.25, -0.1875, -0.3125, 0.25, 0.1875, 0.3125},
            {-0.25, -0.3125, -0.1875, 0.25, 0.3125, 0.1875},
            {-0.25, -0.25, -0.25, 0.25, 0.25, 0.25},
            {-0.3125, -0.5, -0.125, -0.25, 0.125, 0.125},
            {0.25, -0.5, -0.125, 0.3125, 0.125, 0.125},
        },
        img_set = 3,
    },
    {
        node_box = {
            {-0.3125, -0.1875, -0.3125, 0.3125, 0.1875, 0.3125},
            {-0.3125, -0.3125, -0.1875, 0.3125, 0.3125, 0.1875},
            {-0.3125, -0.25, -0.25, 0.3125, 0.25, 0.25},
            {-0.375, -0.5, -0.125, -0.3125, 0.125, 0.125},
            {0.3125, -0.5, -0.125, 0.375, 0.125, 0.125},
        },
        img_set = 4,
    },
    {
        node_box = {
            {-0.375, -0.1875, -0.3125, 0.375, 0.1875, 0.3125},
            {-0.375, -0.3125, -0.1875, 0.375, 0.3125, 0.1875},
            {-0.375, -0.25, -0.25, 0.375, 0.25, 0.25},
            {-0.4375, -0.5, -0.125, -0.375, 0.125, 0.125},
            {0.375, -0.5, -0.125, 0.4375, 0.125, 0.125},
        },
        img_set = 5,
    },
}

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function get_spool_tiles(img_set, tint)

    return {
        string.format(
            "unilib_rope_mining_spool_%i.png^[colorize:%s^" ..
                    "unilib_rope_mining_spool_%i.png^unilib_rope_mining_%i.png",
            img_set,
            tint,
            img_set,
            img_set
        ),
        string.format(
            "unilib_rope_mining_spool_%i.png^[colorize:%s^" ..
                    "unilib_rope_mining_spool_%i.png^unilib_rope_mining_%i.png",
            img_set,
            tint,
            img_set,
            img_set
        ),
        string.format(
            "unilib_rope_mining_spool_side.png^[colorize:%s^unilib_rope_mining_spool_side.png",
            tint
        ),
        string.format(
            "unilib_rope_mining_spool_side.png^[colorize:%s^unilib_rope_mining_spool_side.png",
            tint
        ),
        string.format(
            "unilib_rope_mining_spool_%i.png^[colorize:%s^" ..
                    "unilib_rope_mining_spool_%i.png^unilib_rope_mining_%i.png",
            img_set,
            tint,
            img_set,
            img_set
        ),
        string.format(
            "unilib_rope_mining_spool_%i.png^" ..
                    "[colorize:%s^unilib_rope_mining_spool_%i.png^unilib_rope_mining_%i.png",
            img_set,
            tint,
            img_set,
            img_set
        ),
    }

end

local function move_players_down(pos, radius)

    local all_objects = core.get_objects_inside_radius(
        {x = pos.x, y = pos.y + radius, z = pos.z},
        radius
    )
    local players = {}
    local _, obj

    for _, obj in pairs(all_objects) do

        if obj:is_player() then

            local obj_pos = obj:get_pos()
            if math.abs(obj_pos.x - pos.x) < 0.5 and math.abs(obj_pos.z - pos.z) < 0.5 then
                obj:set_pos({x = obj_pos.x, y = obj_pos.y - 1, z = obj_pos.z}, true)
            end

        end

    end
end

---------------------------------------------------------------------------------------------------
-- Shared functions (ropes and rope ladders)
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_ropes.can_place_rope_in_node(target_node_name)

    if can_extend_into_table[target_node_name] == true then
        return true
    end

    local target_def = core.registered_nodes[target_node_name]
    if target_def then

        if target_def.drawtype == "airlike" and can_extend_into_airlike_flag then
            return true
        end

        if target_def.groups and target_def.groups.ropes_can_extend_into then
            return true
        end

    end

    return false

end

function unilib.pkg.shared_ropes.make_rope_on_timer(rope_node_name)

    return function(pos, elapsed)

        local currentend = core.get_node(pos)
        local currentmeta = core.get_meta(pos)
        local currentlength = currentmeta:get_int("length_remaining")
        local placer_name = currentmeta:get_string("placer")
        local newpos = {x = pos.x, y = pos.y - 1, z = pos.z}
        local newnode = core.get_node(newpos)
        local oldnode = core.get_node(pos)

        if currentlength > 1 and (
            not core.is_protected(newpos, placer_name) or
            core.check_player_privs(placer_name, "protection_bypass")
        ) then

            if unilib.pkg.shared_ropes.can_place_rope_in_node(newnode.name) then

                core.add_node(newpos, {name = currentend.name, param2 = oldnode.param2})
                local newmeta = core.get_meta(newpos)
                newmeta:set_int("length_remaining", currentlength - 1)
                newmeta:set_string("placer", placer_name)
                core.set_node(pos, {name = rope_node_name, param2 = oldnode.param2})
                move_players_down(pos, 1)

            else

                local timer = core.get_node_timer(pos)
                timer:start(1)

            end

        end

    end

end

function unilib.pkg.shared_ropes.destroy_rope(pos, nodes)

    local top = pos.y
    local bottom = pos.y - 15
    local voxel_manip = core.get_voxel_manip()
    local vmdata = {}

    local finished = false
    local ids_to_destroy = {}
    for _, node in pairs(nodes) do

        if core.registered_nodes[node] then
            ids_to_destroy[core.get_content_id(node)] = true
        end

    end

    while not finished do

        local emin, emax = voxel_manip:read_from_map(
            {x = pos.x, y = bottom, z = pos.z},
            {x = pos.x, y = top, z = pos.z}
        )

        voxel_manip:get_data(vmdata)
        local voxel_area = VoxelArea:new{MinEdge = emin, MaxEdge = emax}
        bottom = emin.y
        for y = top, bottom, -1 do

            local index = voxel_area:index(pos.x, y, pos.z)
            if ids_to_destroy[vmdata[index]] then
                vmdata[index] = c_air
            else
                finished = true
                break
            end

        end

        voxel_manip:set_data(vmdata)
        voxel_manip:write_to_map()
        voxel_manip:update_map()
        top = bottom - 1
        bottom = bottom - 15

    end

end

function unilib.pkg.shared_ropes.hanging_after_destruct(pos, top_node, middle_node, bottom_node)

    local node = core.get_node(pos)
    if node.name == top_node or node.name == middle_node or node.name == bottom_node then

        -- This was done by another ladder or rope node changing this one, don't react
        return

    end

    -- One up
    pos.y = pos.y + 1
    local node_above = core.get_node(pos)
    if node_above.name == middle_node then
        core.swap_node(pos, {name = bottom_node, param2 = node_above.param2})
    end

    -- One down
    pos.y = pos.y - 2
    local node_below = core.get_node(pos)
    if node_below.name == middle_node then
        unilib.pkg.shared_ropes.destroy_rope(pos, {middle_node, bottom_node})
    elseif node_below.name == bottom_node then
        core.swap_node(pos, {name = "air"})
    end

end

---------------------------------------------------------------------------------------------------
-- Shared functions (extendable ladders)
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_ropes.ladder_extender(
    pos, node, clicker, itemstack, pointed_thing, ladder_node, standing_limit
)
    -- on_rightclick() can be called by other mods, make sure we have all the parameters we need
    if pointed_thing == nil or itemstack == nil then
        return itemstack
    end

    local clicked_stack = ItemStack(itemstack)

    -- true if we're pointing up at the ladder from below and there's a buildable space below it
    -- This check allows us to extend ladders downward
    local pointing_directly_below = pointed_thing.above.x == pos.x and
            pointed_thing.above.z == pos.z and
            pointed_thing.above.y == pos.y - 1 and
            core.registered_nodes[core.get_node(pointed_thing.above).name].buildable_to

    if clicked_stack:get_name() == ladder_node and not pointing_directly_below then

        local param2 = core.get_node(pos).param2
        local dir = core.facedir_to_dir(param2)
        -- Only add ladder segments up to five nodes above the one clicked on
        local scan_limit = pos.y + 6
        pos.y = pos.y + 1
        while pos.y < scan_limit and core.get_node(pos).name == ladder_node do

            param2 = core.get_node(pos).param2
            pos.y = pos.y + 1

        end

        if pos.y < scan_limit and core.registered_nodes[core.get_node(pos).name].buildable_to then

            -- Scan downward behind the ladder to find support
            local behind_pos = vector.add(pos, core.facedir_to_dir(param2))
            local target_height = pos.y - standing_limit - 1
            while behind_pos.y > target_height and
                    core.registered_nodes[core.get_node(behind_pos).name].buildable_to do
                behind_pos.y = behind_pos.y - 1
            end

            -- If there's enough support, build a new ladder segment
            if behind_pos.y > target_height then

                if core.is_protected(pos, clicker:get_player_name()) then

                    core.record_protection_violation(clicker:get_player_name())

                else

                    core.set_node(pos, {name = ladder_node, param2 = param2})
                    if not core.settings:get_bool("creative_mode") then
                        clicked_stack:take_item(1)
                    end

                end

            end

        end

    elseif clicked_stack:get_definition().type == "node" then

        return core.item_place_node(itemstack, clicker, pointed_thing)

    end

    return clicked_stack

end

---------------------------------------------------------------------------------------------------
-- Shared functions (register mining rope spools)
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_ropes.register_spool(data_table)

    -- Adapted from ropes/ropeboxes.lua
    -- Creates a spool of mining rope
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "steel"
    --      orig_name (str): e.g. "ropes:steel1rope_block"
    --      description (str): e.g. "Steel Spool"
    --      ingredient (str): e.g. "unilib:metal_steel_ingot"
    --      tint (str): e.g. "#ffffff"
    --
    -- data_table optional fields:
    --      replace_mode (str): e.g. "defer"
    --      flammable (int): Node definition flammable group, e.g. 2
    --      multiple (int): A number in the range 1-9 (depending on the type of spool), The number
    --          is multiplied by 50 to produce the rope's maximum length; thus 3 becomes 150 metres
    --
    -- Return values:
    --      The full_name of the new node

    local part_name = data_table.part_name
    local orig_name = data_table.orig_name
    local description = data_table.description
    local ingredient = data_table.ingredient
    local tint = data_table.tint

    local replace_mode = data_table.replace_mode or unilib.default_replace_mode
    local flammable = data_table.flammable or nil
    local multiple = data_table.multiple or 1

    local spool_name = "unilib:rope_mining_spool_" .. part_name .. "_" ..
            (min_rope_length * multiple) .. "m"

    local spool_def_table = {
        description = unilib.utils.brackets(
            S("Coiled Rope"), description .. " " .. (multiple * min_rope_length) .. "m"
        ),
        tiles = get_spool_tiles(spool_data[multiple].img_set, tint),
        -- ("mining_rope" group was "rope_block" in original code)
        groups = {attached_node = 1, choppy = 2, mining_rope = 1, oddly_breakable_by_hand = 1},
        -- (no sounds)

        climbable = true,
        collision_box = {type = "regular"},
        drawtype = "nodebox",
        -- N.B. is_ground_content = false not in original code; added to match other ropes
        is_ground_content = false,
        node_box = {
            type = "fixed",
            fixed = spool_data[multiple].node_box
        },
        paramtype = "light",
        paramtype2 = "wallmounted",
        selection_box = {type = "regular"},
        sunlight_propagates = true,
        use_texture_alpha = "clip",
        walkable = false,

        after_destruct = function(pos)

            local pos_below = {x = pos.x, y = pos.y - 1, z = pos.z}
            unilib.pkg.shared_ropes.destroy_rope(
                pos_below,
                {"unilib:rope_mining", "unilib:rope_mining_bottom"}
            )

        end,

        after_place_node = function(pos, placer)

            local pos_below = {x = pos.x, y = pos.y - 1, z = pos.z}
            local placer_name = placer:get_player_name()

            if core.is_protected(pos_below, placer_name) and
                    not core.check_player_privs(placer, "protection_bypass") then
                return
            end

            local node_below = core.get_node(pos_below)
            if unilib.pkg.shared_ropes.can_place_rope_in_node(node_below.name) then

                core.add_node(pos_below, {name = "unilib:rope_mining_bottom"})
                local meta = core.get_meta(pos_below)
                meta:set_int("length_remaining", min_rope_length * multiple)
                meta:set_string("placer", placer:get_player_name())

            end

        end,

        on_place = function(itemstack, placer, pointed_thing)

            if pointed_thing.type == "node" then

                local target_node = core.get_node(pointed_thing.under)
                local target_def = core.registered_nodes[target_node.name]
                if target_def.walkable == false then
                    return itemstack
                end

            end

            return core.item_place(itemstack, placer, pointed_thing)

        end,
    }

    if flammable then

        spool_def_table.groups.flammable = flammable

        unilib.register_craft({
            type = "fuel",
            recipe = spool_name,
            burntime = (rope_burntime * multiple) + wood_burntime,
        })

    end

    unilib.register_node(spool_name, orig_name, replace_mode, spool_def_table)

    if multiple == 1 then

        unilib.register_craft({
            output = spool_name,
            recipe = {
                {ingredient},
                {"group:vines"},
            },
        })

    else

        for i = 1, multiple - 1 do

            local recipe_table = {
                "unilib:rope_mining_spool_" .. part_name .. "_" .. (min_rope_length * i) .. "m"
            }

            for n = 1, multiple - i do
                table.insert(recipe_table, "unilib:rope_mining_segment")
            end

            unilib.register_craft({
                type = "shapeless",
                output = spool_name,
                recipe = recipe_table
            })

        end

        -- (Allow reverse recipe, as in the original mod)
        unilib.register_craft({
            type = "shapeless",
            output = "unilib:rope_mining_segment",
            recipe = {spool_name},
            replacements = {
                {
                    spool_name,
                    "unilib:rope_mining_spool_" .. part_name .. "_" .. (multiple - 1) .. "m",
                },
            },
        })

    end

    return spool_name

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_ropes.init()

    return {
        description = "Shared functions for ropes and extendable ladders (from ropes mod)",
        suggested = {
            "rope_mining",                      -- group:vines
        },
    }

end
