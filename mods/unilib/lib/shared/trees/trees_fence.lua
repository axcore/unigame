---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- trees_fence.lua
--      Registry functions for fences
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

-- (From default/functions.lua)
local fence_collision_extra = core.settings:get_bool("enable_fence_tall") and 3/8 or 0

---------------------------------------------------------------------------------------------------
-- Registry functions for fences
---------------------------------------------------------------------------------------------------

function unilib.trees._register_fence(data_table)

    -- Adapted from default/nodes.lua
    -- Creates a fence for a tree type already registered in an earlier call to
    --      unilib.register_tree()
    -- This function expects a definition table as an argument, used in the call to
    --      unilib.register_node(). Any fields not supplied by the definition table are given
    --      default values
    -- The definition table may contain the pseudo-fields "texture" and "ingredient", which if
    --      specified are converted into real fields
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "aspen", a key in unilib.global.tree_table
    --      full_name (str): e.g. "unilib:tree_aspen_wood_fence"
    --      orig_name (str): e.g. "default:fence_aspen_wood"
    --      def_table (table): The partial definition table
    --
    -- data_table optional fields:
    --      replace_mode (str): e.g. "defer"
    --      burntime (int): e.g. 5. If 0, the item is not flammable
    --
    -- Return values:
    --      The full_name of the new node

    local part_name = data_table.part_name
    local full_name = data_table.full_name
    local orig_name = data_table.orig_name
    local def_table = data_table.def_table

    local replace_mode = data_table.replace_mode or unilib.default_replace_mode
    local burntime = data_table.burntime or 7

    local img = "unilib_fence_overlay.png^" .. def_table.texture ..
            "^unilib_fence_overlay.png^[makealpha:255,126,126"

    unilib.register_craft({
        output = full_name .. " 4",
        recipe = {
            {def_table.ingredient, 'group:stick', def_table.ingredient},
            {def_table.ingredient, 'group:stick', def_table.ingredient},
        },
    })
    if burntime ~= 0 then

        unilib.register_craft({
            type = "fuel",
            recipe = full_name,
            burntime = burntime,
        })

    end

    -- Allow almost everything to be overridden by default values
    local default_fields_table = {
        tiles = {def_table.texture},
        groups = {},

        collision_box = {
            type = "connected",
            fixed = {-1/8, -1/2, -1/8, 1/8, 1/2 + fence_collision_extra, 1/8},
            -- connect_top =
            -- connect_bottom =
            connect_front = {-1/8, -1/2, -1/2, 1/8, 1/2 + fence_collision_extra, -1/8},
            connect_left = {-1/2, -1/2, -1/8, -1/8, 1/2 + fence_collision_extra, 1/8},
            connect_back = {-1/8, -1/2, 1/8, 1/8, 1/2 + fence_collision_extra, 1/2},
            connect_right = { 1/8, -1/2, -1/8, 1/2, 1/2 + fence_collision_extra, 1/8}
        },
        connects_to = {"group:fence", "group:wood", "group:tree", "group:wall"},
        drawtype = "nodebox",
        inventory_image = img,
        is_ground_content = false,
        node_box = {
            type = "connected",
            fixed = {-1/8, -1/2, -1/8, 1/8, 1/2, 1/8},
            -- connect_top =
            -- connect_bottom =
            connect_front = {
                {-1/16, 3/16, -1/2, 1/16, 5/16, -1/8},
                {-1/16, -5/16, -1/2, 1/16, -3/16, -1/8},
            },
            connect_left = {
                {-1/2, 3/16, -1/16, -1/8, 5/16, 1/16},
                {-1/2, -5/16, -1/16, -1/8, -3/16, 1/16},
            },
            connect_back = {
                {-1/16, 3/16, 1/8, 1/16, 5/16, 1/2},
                {-1/16, -5/16, 1/8, 1/16, -3/16, 1/2},
            },
            connect_right = {
                {1/8, 3/16, -1/16, 1/2, 5/16, 1/16},
                {1/8, -5/16, -1/16, 1/2, -3/16, 1/16},
            },
        },
        paramtype = "light",
        sunlight_propagates = true,
        wield_image = img,
    }

    for k, v in pairs(default_fields_table) do
        if def_table[k] == nil then
            def_table[k] = v
        end
    end

    -- Always add to the fence group, even if no groups provided
    def_table.groups.fence = 1

    def_table.texture = nil
    def_table.ingredient = nil

    unilib.register_node(full_name, orig_name, replace_mode, def_table)

    return full_name

end

function unilib.trees._register_fence_rail(data_table)

    -- Adapted from default/nodes.lua
    -- Creates a fence rail for a tree type already registered in an earlier call to
    --      unilib.register_tree()
    -- This function expects a definition table as an argument, used in the call to
    --      unilib.register_node(). Any fields not supplied by the definition table are given
    --      default values
    -- The definition table may contain the pseudo-fields "texture" and "ingredient", which if
    --      specified are converted into real fields
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "aspen", a key in unilib.global.tree_table
    --      full_name (str): e.g. "unilib:tree_aspen_wood_fence_rail"
    --      orig_name (str): e.g. "default:fence_rail_aspen_wood"
    --      def_table (table): The partial definition table
    --
    -- data_table optional fields:
    --      replace_mode (str): e.g. "defer"
    --      burntime (int): e.g. 3. If 0, the item is not flammable
    --
    -- Return values:
    --      The full_name of the new node

    local part_name = data_table.part_name
    local full_name = data_table.full_name
    local orig_name = data_table.orig_name
    local def_table = data_table.def_table

    local replace_mode = data_table.replace_mode or unilib.default_replace_mode
    local burntime = data_table.burntime or 5

    local img = "unilib_fence_rail_overlay.png^" .. def_table.texture ..
            "^unilib_fence_rail_overlay.png^[makealpha:255,126,126"

    unilib.register_craft({
        output = full_name .. " 16",
        recipe = {
            {def_table.ingredient, def_table.ingredient},
            {"", ""},
            {def_table.ingredient, def_table.ingredient},
        },
    })
    if burntime ~= 0 then

        unilib.register_craft({
            type = "fuel",
            recipe = full_name,
            burntime = burntime,
        })

    end

    -- Allow almost everything to be overridden
    local default_fields_table = {
        tiles = {def_table.texture},
        groups = {},

        collision_box = {
            type = "connected",
            fixed = {-1/8, -1/2, -1/8, 1/8, 1/2 + fence_collision_extra, 1/8},
            -- connect_top =
            -- connect_bottom =
            connect_front = {-1/8, -1/2, -1/2, 1/8, 1/2 + fence_collision_extra, -1/8},
            connect_left = {-1/2, -1/2, -1/8, -1/8, 1/2 + fence_collision_extra, 1/8},
            connect_back = {-1/8, -1/2, 1/8, 1/8, 1/2 + fence_collision_extra, 1/2},
            connect_right = { 1/8, -1/2, -1/8, 1/2, 1/2 + fence_collision_extra, 1/8}
        },
        connects_to = {"group:fence", "group:wall"},
        drawtype = "nodebox",
        inventory_image = img,
        is_ground_content = false,
        node_box = {
            type = "connected",
            fixed = {{-1/16, 3/16, -1/16, 1/16, 5/16, 1/16},
                 {-1/16, -3/16, -1/16, 1/16, -5/16, 1/16}},
            -- connect_top =
            -- connect_bottom =
            connect_front = {
                {-1/16, 3/16, -1/2, 1/16, 5/16, -1/16},
                {-1/16, -5/16, -1/2, 1/16, -3/16, -1/16},
            },
            connect_left = {
                {-1/2, 3/16, -1/16, -1/16, 5/16, 1/16},
                {-1/2, -5/16, -1/16, -1/16, -3/16, 1/16},
            },
            connect_back = {
                {-1/16, 3/16, 1/16, 1/16, 5/16, 1/2 },
                {-1/16, -5/16, 1/16, 1/16, -3/16, 1/2},
            },
            connect_right = {
                {1/16, 3/16, -1/16, 1/2, 5/16, 1/16},
                {1/16, -5/16, -1/16, 1/2, -3/16, 1/16},
            },
        },
        paramtype = "light",
        sunlight_propagates = true,
        wield_image = img,
    }

    for k, v in pairs(default_fields_table) do
        if def_table[k] == nil then
            def_table[k] = v
        end
    end

    -- Always add to the fence group, even if no group provided
    def_table.groups.fence = 1

    def_table.texture = nil
    def_table.ingredient = nil

    unilib.register_node(full_name, orig_name, replace_mode, def_table)

    return full_name

end
