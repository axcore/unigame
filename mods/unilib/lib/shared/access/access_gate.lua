---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- access_gate.lua
--      Register (fence) gates
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

local fence_collision_extra = core.settings:get_bool("enable_fence_tall") and 3/8 or 0

---------------------------------------------------------------------------------------------------
-- Register (fence) gates
---------------------------------------------------------------------------------------------------

function unilib.access._register_gate(data_table)

    -- Adapted from doors/init.lua
    -- Creates a fence gate for a tree type already registered in an earlier call to
    --      unilib.register_tree()
    -- This function expects a partial definition table as an argument, set up as if it were to be
    --      used in a call to unilib.register_node()
    -- However, only a few of its fields are used in the actual definition table passed to
    --      unilib.register_node(); any other fields are ignored:
    --          .description
    --          .texture (a pseudo-field whose value is used as the .tiles field, after some
    --              adjustments in this function)
    --          .groups
    --          .sounds
    --          .ingredient (a pseudo-field whose value is used to set the craft recipe)
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "aspen", a key in unilib.global.tree_table
    --      orig_name (list):
    --          e.g. {"doors:gate_aspen_wood_closed", "doors:gate_aspen_wood_open"}
    --      def_table (table): The definition table described above
    --
    -- data_table optional fields:
    --      replace_mode (str): e.g. "defer"

    local part_name = data_table.part_name
    local orig_name = data_table.orig_name
    local def_table = data_table.def_table

    local replace_mode = data_table.replace_mode or unilib.default_replace_mode

    local full_name = "unilib:gate_" .. part_name

    local adj_def_table = {
        description = def_table.description,
        tiles = {},
        groups = def_table.groups,
        sounds = def_table.sounds,

        connect_sides = {"left", "right"},
        drawtype = "mesh",
        drop = full_name .. "_closed",
        is_ground_content = false,
        paramtype = "light",
        paramtype2 = "facedir",
        selection_box = {
            type = "fixed",
            fixed = {-1/2, -1/2, -1/4, 1/2, 1/2, 1/4}
        },
        sunlight_propagates = true,

        on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)

            local node_def = core.registered_nodes[node.name]
            core.swap_node(pos, {name = node_def._gate, param2 = node.param2})
            core.sound_play(
                node_def._gate_sound,
                {pos = pos, gain = 0.15, max_hear_distance = 8},
                true
            )

            return itemstack

        end,
    }

    if type(def_table.texture) == "string" then

        adj_def_table.tiles[1] = {name = def_table.texture, backface_culling = true}

    elseif def_table.texture.backface_culling == nil then

        adj_def_table.tiles[1] = table.copy(def_table.texture)
        adj_def_table.tiles[1].backface_culling = true

    else

        fence_def_table.tiles[1] = def_table.texture

    end

    if not adj_def_table.sounds then
        adj_def_table.sounds = unilib.global.sound_table.wood
    end

    adj_def_table.groups.fence = 1

    local fence_closed_table = table.copy(adj_def_table)
    fence_closed_table.mesh = "unilib_gate_closed.obj"
    fence_closed_table._gate = full_name .. "_open"
    fence_closed_table._gate_sound = "unilib_gate_open"
    fence_closed_table.collision_box = {
        type = "fixed",
        fixed = {-1/2, -1/2, -1/8, 1/2, 1/2 + fence_collision_extra, 1/8}
    }

    local fence_open_table = table.copy(adj_def_table)
    fence_open_table.mesh = "unilib_gate_open.obj"
    fence_open_table._gate = full_name .. "_closed"
    fence_open_table._gate_sound = "unilib_gate_close"
    fence_open_table.groups.not_in_creative_inventory = 1
    fence_open_table.collision_box = {
        type = "fixed",
        fixed = {
            {-1/2, -1/2, -1/8, -3/8, 1/2 + fence_collision_extra, 1/8},
            {-1/2, -3/8, -1/2, -3/8, 3/8, 0}
        },
    }

    -- ("orig_name" should be a list containing both variants, the "closed" variant first)
    unilib.register_node(full_name .. "_closed", orig_name, replace_mode, fence_closed_table)
    unilib.register_node(full_name .. "_open", nil, replace_mode, fence_open_table)

    unilib.register_craft({
        output = full_name .. "_closed",
        recipe = {
            {"group:stick", def_table.ingredient, "group:stick"},
            {"group:stick", def_table.ingredient, "group:stick"},
        },
    })

end
