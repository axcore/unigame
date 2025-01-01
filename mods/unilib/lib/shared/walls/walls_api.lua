---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- walls_api.lua
--      API functions for walls
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

-- (From default/functions.lua)
local fence_collision_extra = core.settings:get_bool("enable_fence_tall") and 3/8 or 0

---------------------------------------------------------------------------------------------------
-- API functions for walls
---------------------------------------------------------------------------------------------------

function unilib.walls._register_wall(data_table)

    -- Adapted from walls/init.lua, walls:XXX
    -- Creates a wall node, unless the Minetest setting is not enabled, nothing happens
    --
    -- data_table compulsory fields:
    --      orig_name (str): e.g. "walls:cobble"
    --      ingredient (str): e.g. "unilib:stone_ordinary_cobble"
    --
    -- data_table optional fields:
    --      replace_mode (str): e.g. "defer"
    --      description (str): e.g. "Ordinary Cobblestone Wall"
    --      group_table (table): e.g. {cracky = 3, stone = 2, wall = 1}
    --      sound_name (str): e.g. "stone", a key in unilib.global.sound_table
    --      img_list (str or list): e.g. {"unilib_stone_ordinary_cobble.png"}
    --
    -- Return values:
    --      The new item's full_name (or nil if walls are disabled)

    local orig_name = data_table.orig_name
    local ingredient = data_table.ingredient

    local replace_mode = data_table.replace_mode or unilib.default_replace_mode
    local description = data_table.description or S("Wall")
    local group_table = data_table.group_table or {cracky = 3, stone = 2, wall = 1}
    local sound_name = data_table.sound_name or "node"
    local img_list = data_table.img_list or {"unilib_unknown.png"}

    local full_name = ingredient .. "_wall"

    if not unilib.setting.add_walls_flag then
        return nil
    end

    -- The wall is pole-like until it connects to neighbouring nodes
    unilib.register_node(full_name, orig_name, replace_mode, {
        description = description,
        tiles = img_list,
        groups = group_table,
        sounds = unilib.global.sound_table[sound_name],

        collision_box = {
            type = "connected",
            fixed = {-1/4, -1/2, -1/4, 1/4, 1/2 + fence_collision_extra, 1/4},
            -- connect_top =
            -- connect_bottom =
            connect_front = {-1/4, -1/2, -1/2, 1/4, 1/2 + fence_collision_extra, -1/4},
            connect_left = {-1/2, -1/2, -1/4, -1/4, 1/2 + fence_collision_extra, 1/4},
            connect_back = {-1/4, -1/2, 1/4, 1/4, 1/2 + fence_collision_extra, 1/2},
            connect_right = {1/4, -1/2, -1/4, 1/2, 1/2 + fence_collision_extra, 1/4},
        },
        connects_to = {"group:fence", "group:stone", "group:wall", "group:wall_connected"},
        drawtype = "nodebox",
        is_ground_content = false,
        node_box = {
            type = "connected",
            fixed = {-1/4, -1/2, -1/4, 1/4, 1/2, 1/4},
            -- connect_top =
            -- connect_bottom =
            connect_front = {-3/16, -1/2, -1/2, 3/16, 3/8, -1/4},
            connect_left = {-1/2, -1/2, -3/16, -1/4, 3/8, 3/16},
            connect_back = {-3/16, -1/2, 1/4, 3/16, 3/8, 1/2},
            connect_right = { 1/4, -1/2, -3/16, 1/2, 3/8, 3/16},
        },
        paramtype = "light",
        walkable = true,
    })
    unilib.register_craft({
        output = ingredient .. "_wall" .. " 6",
        recipe = {
            { "", "", "" },
            { ingredient, ingredient, ingredient},
            { ingredient, ingredient, ingredient},
        },
    })

    -- Walls created by minetest_game/walls have an arbitrary name format, so they must be
    --      unregistered here, rather than in ../lib/system/register/register_support_item.lua (as
    --      is the case for stairs)
    -- As explained in that file, even when a main node is hidden, any equivalent stairs/wall nodes
    --      are unregistered
    if (replace_mode == "replace" or replace_mode == "hide") and
             core.registered_nodes[orig_name] ~= nil then
        core.unregister_item(orig_name)
    end

    return full_name

end
