---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- trees_fence_quick.lua
--      Quick registry functions for fences
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Quick registry functions for fences
---------------------------------------------------------------------------------------------------

function unilib.trees._register_fence_all(data_table)

    -- Quickly register all three fence types (fences, fence rails, gates)
    -- This function is intended for packages, whose original mods didn't specify any fences;
    --      therefore this function can be called with just the bare minimum of arguments
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "aspen", a key in unilib.global.tree_table
    --
    -- data_table optional fields:
    --      replace_mode (str): e.g. "defer"
    --      burnlevel (int): value in the range 0-5, see ../lib/system/global/global_variables.lua.
    --          If 0, the item is not flammable. If 1-5, overrides the value of "burntime"
    --      fence_description (str): e.g. "Aspen Wood Fence"
    --      gate_description (str): e.g. "Aspen Wood Fence Gate"
    --      rail_description (str): e.g. "Aspen Wood Fence Rail"

    local part_name = data_table.part_name

    local replace_mode = data_table.replace_mode or unilib.default_replace_mode
    local burnlevel = data_table.burnlevel or nil
    local fence_description = data_table.fence_description or S("Wooden Fence")
    local rail_description = data_table.rail_description or S("Wooden Fence Rail")
    local gate_description = data_table.gate_description or S("Wooden Fence Gate")

    local img = "unilib_tree_" .. part_name .. "_wood.png"

    unilib.register_fence_quick({
        part_name = part_name,
        orig_name = nil,

        replace_mode = replace_mode,
        base_img = img,
        burnlevel = burnlevel,
        description = fence_description,
        group_table = nil,
    })

    unilib.register_fence_rail_quick({
        part_name = part_name,
        orig_name = nil,

        replace_mode = replace_mode,
        base_img = img,
        burnlevel = burnlevel,
        description = rail_description,
        group_table = nil,
    })

    unilib.register_fence_gate_quick({
        part_name = part_name,
        orig_name = {nil, nil},

        replace_mode = replace_mode,
        base_img = img,
        burnlevel = burnlevel,
        description = gate_description,
        group_table = nil,
    })

end

function unilib.trees._register_fence_quick(data_table)

    -- Adapted from default:fence_wood
    -- Creates a fence for a tree type already registered in an earlier call to
    --      unilib.register_tree()
    -- This function creates a definition table, and passes it on to unilib.register_fence().
    --      That function can be called directly, if preferred
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "aspen", a key in unilib.global.tree_table
    --      orig_name (str): e.g. "default:fence_aspen_wood"
    --
    -- data_table optional fields:
    --      replace_mode (str): e.g. "defer"
    --      base_img (str): If specified, overrides the custom image that is expected for this fence
    --      burnlevel (int): value in the range 0-5, see ../lib/system/global/global_variables.lua.
    --          If 0, the item is not flammable. If 1-5, overrides the value of "burntime"
    --      burntime (int): e.g. 5. If 0, the item is not flammable
    --      description (str): e.g. "Aspen Wood Fence"
    --      group_table (table): Complete group table
    --      ingredient (str): If specified, overrides the ingredient used in the craft recipe
    --
    -- Return values:
    --      The full_name of the new node

    local part_name = data_table.part_name
    local orig_name = data_table.orig_name

    local replace_mode = data_table.replace_mode or unilib.default_replace_mode
    local base_img = data_table.base_img or "unilib_tree_" .. part_name .. "_wood_fence.png"
    local burnlevel = data_table.burnlevel or nil
    local burntime = data_table.burntime or 7
    local description = data_table.description or S("Wooden Fence")
    local group_table = data_table.group_table or nil
    local ingredient = data_table.ingredient or "unilib:tree_" .. part_name .. "_wood"

    local full_name = "unilib:tree_" .. part_name .. "_wood_fence"

    local base_inv_img = data_table.base_img or "unilib_tree_" .. part_name .. "_wood.png"
    local inv_img = "unilib_fence_overlay.png^" .. base_inv_img ..
            "^unilib_fence_overlay.png^[makealpha:255,126,126"

    if group_table == nil then
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2}
    end

    if burnlevel ~= nil and burnlevel ~= 0 then

        burntime = unilib.global.tree_burn_table.fence[burnlevel]

    elseif burnlevel == 0 then

        burntime = 0
        group_table.flammable = nil

    end

    unilib.register_fence({
        part_name = part_name,
        full_name = full_name,
        orig_name = orig_name,
        def_table = {
            description = description,
            texture = base_img,
            groups = group_table,
            sounds = unilib.global.sound_table.wood,

            ingredient = ingredient,
            inventory_image = inv_img,
            wield_image = inv_img,
        },

        replace_mode = replace_mode,
        burntime = burntime,
    })

    return full_name

end

function unilib.trees._register_fence_rail_quick(data_table)

    -- Adapted from default:fence_rail_wood
    -- Creates a fence rail for a tree type already registered in an earlier call to
    --      unilib.register_tree()
    -- This function creates a definition table, and passes it on to unilib.register_fence_rail().
    --      That function can be called directly, if preferred
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "aspen", a key in unilib.global.tree_table
    --      orig_name (str): e.g. "default:fence_rail_aspen_wood"
    --
    -- data_table optional fields:
    --      replace_mode (str): e.g. "defer"
    --      base_img (str): If specified, overrides the custom image that is expected for this fence
    --      burnlevel (int): value in the range 0-5, see ../lib/system/global/global_variables.lua.
    --          If 0, the item is not flammable. If 1-5, overrides the value of "burntime"
    --      burntime (int): e.g. 3. If 0, the item is not flammable
    --      description (str): e.g. "Aspen Wood Fence Rail"
    --      group_table (table): Complete group table
    --      ingredient (str): If specified, overrides the ingredient used in the craft recipe
    --
    -- Return values:
    --      The full_name of the new node

    local part_name = data_table.part_name
    local orig_name = data_table.orig_name

    local replace_mode = data_table.replace_mode or unilib.default_replace_mode
    local base_img = data_table.base_img or "unilib_tree_" .. part_name .. "_wood_fence_rail.png"
    local burnlevel = data_table.burnlevel or nil
    local burntime = data_table.burntime or 5
    local description = data_table.description or S("Wooden Fence Rail")
    local group_table = data_table.group_table or nil
    local ingredient = data_table.ingredient or "unilib:tree_" .. part_name .. "_wood"

    local full_name = "unilib:tree_" .. part_name .. "_wood_fence_rail"

    local base_inv_img = data_table.base_img or "unilib_tree_" .. part_name .. "_wood.png"
    local inv_img = "unilib_fence_rail_overlay.png^" .. base_inv_img ..
                "^unilib_fence_rail_overlay.png^[makealpha:255,126,126"

    if group_table == nil then
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2}
    end

    if burnlevel ~= nil and burnlevel ~= 0 then

        burntime = unilib.global.tree_burn_table.fence_rail[burnlevel]

    elseif burnlevel == 0 then

        burntime = 0
        group_table.flammable = nil

    end

    unilib.register_fence_rail({
        part_name = part_name,
        full_name = full_name,
        orig_name = orig_name,
        def_table = {
            description = description,
            texture = base_img,
            groups = group_table,
            sounds = unilib.global.sound_table.wood,

            ingredient = ingredient,
            inventory_image = inv_img,
            wield_image = inv_img,
        },

        replace_mode = replace_mode,
        burntime = burntime,
    })

    return full_name

end

function unilib.trees._register_fence_gate_quick(data_table)

    -- Adapted from doors/init.lua
    -- Creates a door for a tree type already registered in an earlier call to
    --      unilib.register_tree()
    -- This function creates a definition table, and passes it on to the standard gate function in
    --      ../lib/shared/access/access_gate.lua. That function can be called directly, if preferred
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "aspen", a key in unilib.global.tree_table
    --      orig_name (list):
    --          e.g. {"doors:gate_aspen_wood_closed", "doors:gate_aspen_wood_open"}
    --
    -- data_table optional fields:
    --      replace_mode (str): e.g. "defer"
    --      base_img (str): If specified, overrides the custom image that is expected for this gate
    --      burnlevel (int): value in the range 0-5, see ../lib/system/global/global_variables.lua.
    --          If 0, the item is not flammable. If 1-5, overrides the value of "burntime"
    --      burntime (int): e.g. 5. If 0, the item is not flammable
    --      description (str): e.g. "Aspen Wood Fence Gate"
    --      group_table (table): Complete group table
    --      ingredient (str): If specified, overrides the ingredient used in the craft recipe
    --
    -- Return values:
    --      The full_name of the new node

    local part_name = data_table.part_name
    local orig_name = data_table.orig_name

    local replace_mode = data_table.replace_mode or unilib.default_replace_mode
    local base_img = data_table.base_img or "unilib_tree_" .. part_name .. "_wood.png"
    local burnlevel = data_table.burnlevel or nil
    local burntime = data_table.burntime or 7
    local description = data_table.description or S("Wooden Fence Gate")
    local group_table = data_table.group_table or nil
    local ingredient = data_table.ingredient or "unilib:tree_" .. part_name .. "_wood"

    local full_name = "unilib:gate_" .. part_name .. "_closed"

    if group_table == nil then
        group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2}
    end

    if burnlevel ~= nil and burnlevel ~= 0 then

        burntime = unilib.global.tree_burn_table.fence_gate[burnlevel]

    elseif burnlevel == 0 then

        burntime = 0
        group_table.flammable = nil

    end

    local def_table = {
        description = description,
        texture = base_img,
        groups = group_table,

        ingredient = ingredient,
    }

    unilib.register_gate({
        part_name = part_name,
        orig_name = orig_name,
        def_table = def_table,

        replace_mode = replace_mode,
    })
    if burntime ~= 0 then

        unilib.register_craft({
            type = "fuel",
            recipe = full_name,
            burntime = burntime,
        })

    end

    return full_name

end
