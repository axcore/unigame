---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- stone_cobble.lua
--      Registry functions for cobblestone
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

-- (Table used by smooth and cobble variants)
local smooth_cracky_table = {3, 2, 1, 1, 1}

---------------------------------------------------------------------------------------------------
-- Registry functions for cobblestone
---------------------------------------------------------------------------------------------------

function unilib.stone._register_cobble(data_table)

    -- Original to unilib
    -- Creates a cobble stone node
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "aplite", a key in unilib.global.stone_table
    --      orig_name (str): e.g. "underch:aplite_cobble"
    --
    -- data_table optional fields:
    --      replace_mode (str): e.g. "defer"
    --      description (str): e.g. "Aplite Cobble"
    --      group_table (table): Non-standard cobble groups. If specified, they overwrite the
    --          standard cobble groups
    --      img_list (list): e.g. {"unilib_stone_aplite_cobble.png"}. If omitted, "part_name" is
    --          used to specify the image name in a standard format
    --      slab_img_list (list): If specified, a texture list to be used in slabs and other
    --          suitable stair nodes. If not specified, the node's own texture list is used
    --      wall_orig_name (str): e.g. "underch:aplite_cobble_wall"
    --
    -- Return values:
    --      The full_name of the new node

    local part_name = data_table.part_name
    local orig_name = data_table.orig_name

    local replace_mode = data_table.replace_mode or unilib.default_replace_mode
    local description = data_table.description or S("Cobblestone")
    local group_table = data_table.group_table or {}
    local img_list = data_table.img_list or {"unilib_stone_" .. part_name .. "_cobble.png"}
    local slab_img_list = data_table.slab_img_list or nil
    local wall_orig_name = data_table.wall_orig_name or nil

    local full_name = "unilib:stone_" .. part_name .. "_cobble"
    local mini_table = unilib.global.stone_table[part_name]

    local adj_group_table = {
        cobble = 1, cracky = smooth_cracky_table[mini_table.hardness], stone = 2,
    }

    for k, v in pairs(group_table) do
        adj_group_table[k] = v
    end

    unilib.register_node(full_name, orig_name, replace_mode, {
        description = description,
        tiles = img_list,
        groups = adj_group_table,
        sounds = unilib.global.sound_table.stone,

        is_ground_content = false,
    })
    unilib.register_craft({
        type = "cooking",
        output = "unilib:stone_" .. part_name,
        recipe = full_name,
    })

    unilib.register_stone_cobble_cuttings({
        part_name = part_name,

        replace_mode = replace_mode,
        slab_img_list = slab_img_list,
        wall_orig_name = wall_orig_name,
    })

    return full_name

end

function unilib.stone._register_cobble_mossy(data_table)

    -- Original to unilib
    -- Creates a mossy cobble stone node
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "aplite", a key in unilib.global.stone_table
    --      orig_name (str): e.g. "underch:aplite_mossy_cobble"
    --
    -- data_table optional fields:
    --      replace_mode (str): e.g. "defer"
    --      description (str): e.g. "Mossy Aplite Cobble"
    --      group_table (table): Non-standard mossy cobble groups. If specified, they overwrite the
    --          standard mossy cobble groups
    --      img_list (list): e.g. {"unilib_stone_aplite_cobble_mossy.png"}. If omitted, "part_name"
    --          is used to specify the image name in a standard format
    --      slab_img_list (list): If specified, a texture list to be used in slabs and other
    --          suitable stair nodes. If not specified, the node's own texture list is used
    --      wall_orig_name (str): e.g. "underch:aplite_mossy_cobble_wall"
    --
    -- Return values:
    --      The full_name of the new node

    local part_name = data_table.part_name
    local orig_name = data_table.orig_name

    local replace_mode = data_table.replace_mode or unilib.default_replace_mode
    local description = data_table.description or S("Mossy Cobblestone")
    local group_table = data_table.group_table or {}
    local img_list = data_table.img_list or {"unilib_stone_" .. part_name .. "_cobble_mossy.png"}
    local slab_img_list = data_table.slab_img_list or nil
    local wall_orig_name = data_table.wall_orig_name or nil

    local full_name = "unilib:stone_" .. part_name .. "_cobble_mossy"
    local mini_table = unilib.global.stone_table[part_name]

    local adj_group_table = {
        cracky = smooth_cracky_table[mini_table.hardness], mossycobble = 1, stone = 1,
    }

    for k, v in pairs(group_table) do
        adj_group_table[k] = v
    end

    unilib.register_node(full_name, orig_name, replace_mode, {
        description = description,
        tiles = img_list,
        groups = adj_group_table,
        sounds = unilib.global.sound_table.stone,

        is_ground_content = false,
    })
    unilib.register_craft({
        type = "cooking",
        output = "unilib:stone_" .. part_name,
        recipe = full_name,
    })

    unilib.register_stone_cobble_mossy_cuttings({
        part_name = part_name,

        replace_mode = replace_mode,
        slab_img_list = slab_img_list,
        wall_orig_name = wall_orig_name,
    })

    return full_name

end

function unilib.stone._register_cobble_compressed(data_table)

    -- Original to unilib
    -- Creates a compressed cobble stone node, if the Minetest setting permits them
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "aplite", a key in unilib.global.stone_table
    --      orig_name (str): e.g. "compressed:aplite"
    --
    -- data_table optional fields:
    --      replace_mode (str): e.g. "defer"
    --      description (str): e.g. "Compressed Aplite Cobble"
    --      img_list (list): e.g. {"unilib_stone_aplite_cobble_compressed.png"}. If omitted,
    --          "part_name" is used to specify the image name in a standard format
    --
    -- Return values:
    --      The full_name of the new node, or nil if compressed cobble is not permitted

    if unilib.setting.squeezed_stone_flag then

        local part_name = data_table.part_name
        local orig_name = data_table.orig_name

        local replace_mode = data_table.replace_mode or unilib.default_replace_mode
        local description = data_table.description or S("Compressed Cobblestone")
        local img_list = data_table.img_list or
                {"unilib_stone_" .. part_name .. "_cobble_compressed.png"}

        local ingredient = "unilib:stone_" .. part_name .. "_cobble"
        local squeezed_name = "unilib:stone_" .. part_name .. "_cobble_compressed"

        unilib.register_node(squeezed_name, orig_name, replace_mode, {
            description = description,
            tiles = img_list,
            groups = {compressedstone = 1, cracky = 2},
            sounds = unilib.global.sound_table.stone,
        })
        unilib.misc.set_squeezed_recipes(ingredient, squeezed_name)
        core.register_craft({
            type = "cooking",
            output = "unilib:stone_" .. part_name .. " 9",
            recipe = squeezed_name,
        })

        return squeezed_name

    else

        return nil

    end

end

function unilib.stone._register_cobble_condensed(data_table)

    -- Original to unilib
    -- Creates a condensed cobble stone node, if the Minetest setting permits them
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "aplite", a key in unilib.global.stone_table
    --      orig_name (str): e.g. "condensed:aplite"
    --
    -- data_table optional fields:
    --      replace_mode (str): e.g. "defer"
    --      description (str): e.g. "Condensed Aplite Cobble"
    --      img_list (list): e.g. {"unilib_stone_aplite_cobble_condensed.png"}. If omitted,
    --          "part_name" is used to specify the image name in a standard format
    --
    -- Return values:
    --      The full_name of the new node, or nil if condensed cobble not permitted

    if unilib.setting.squeezed_stone_flag then

        local part_name = data_table.part_name
        local orig_name = data_table.orig_name

        local replace_mode = data_table.replace_mode or unilib.default_replace_mode
        local description = data_table.description or S("Condensed Cobblestone")
        local img_list = data_table.img_list or
                {"unilib_stone_" .. part_name .. "_cobble_condensed.png"}

        local ingredient = "unilib:stone_" .. part_name .. "_cobble_compressed"
        local squeezed_name = "unilib:stone_" .. part_name .. "_cobble_condensed"

        unilib.register_node(squeezed_name, orig_name, replace_mode, {
            description = description,
            tiles = img_list,
            groups = {condensedstone = 1, cracky = 1},
            sounds = unilib.global.sound_table.stone,

            stack_max = unilib.global.squeezed_stack_max,
        })
        unilib.misc.set_squeezed_recipes(ingredient, squeezed_name)

        return squeezed_name

    else

        return nil

    end

end

---------------------------------------------------------------------------------------------------
-- Register stairs/carvings/walls for stones and super stones
---------------------------------------------------------------------------------------------------

function unilib.stone._register_cobble_cuttings(data_table)

    -- Original to unilib; see the comments in unilib.register_super_stone_smooth_cuttings()
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "aplite", a key in unilib.global.stone_table
    --
    -- data_table optional fields:
    --      replace_mode (str): e.g. "defer"
    --      slab_img_list (list): If specified, a texture list to be used in slabs and other
    --          suitable stair nodes. If not specified, the node's own texture list is used
    --      wall_orig_name (str): e.g. "underch:aplite_cobble_wall"

    local part_name = data_table.part_name

    local replace_mode = data_table.replace_mode or unilib.default_replace_mode
    local slab_img_list = data_table.slab_img_list or nil
    local wall_orig_name = data_table.wall_orig_name or nil

    local full_name = "unilib:stone_" .. part_name .. "_cobble"
    local def_table = core.registered_nodes[full_name]

    if unilib.global.super_stone_table[part_name] ~= nil then

        -- Super stones have stairs, carvings and walls
        unilib.register_stairs(full_name, {
            cooked_name = "unilib:stone_" .. part_name,
            group_type = "cobble",
            slab_img_list = slab_img_list,
            super_flag = true,
        })
        unilib.register_carvings(full_name, {
            column_flag = true,
            millwork_flag = true,
        })
        unilib.register_wall({
            orig_name = wall_orig_name,
            ingredient = full_name,

            replace_mode = replace_mode,
            description = unilib.utils.brackets(S("Wall"), def_table.description),
            sound_name = "stone",
            img_list = def_table.tiles,
        })

    elseif unilib.setting.add_stairs_basic_flag then

        -- All stones, not just super stones, have basic stairs (if basic stairs are enabled in
        --      general)
        unilib.register_stairs(full_name, {
            basic_flag = true,
            cooked_name = "unilib:stone_" .. part_name,
            group_type = "cobble",
            slab_img_list = slab_img_list,
        })

        -- In addition, all stones have cobble walls
        unilib.register_wall({
            orig_name = wall_orig_name,
            ingredient = full_name,

            replace_mode = replace_mode,
            description = unilib.utils.brackets(S("Wall"), def_table.description),
            sound_name = "stone",
            img_list = def_table.tiles,
        })

    end

end

function unilib.stone._register_cobble_mossy_cuttings(data_table)

    -- Original to unilib; see the comments in unilib.register_super_stone_smooth_cuttings()
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "aplite", a key in unilib.global.stone_table
    --
    -- data_table optional fields:
    --      replace_mode (str): e.g. "defer"
    --      slab_img_list (list): If specified, a texture list to be used in slabs and other
    --          suitable stair nodes. If not specified, the node's own texture list is used
    --      wall_orig_name (str): e.g. "underch:aplite_cobble_wall"

    local part_name = data_table.part_name

    local replace_mode = data_table.replace_mode or unilib.default_replace_mode
    local slab_img_list = data_table.slab_img_list or nil
    local wall_orig_name = data_table.wall_orig_name or nil

    if unilib.global.super_stone_table[part_name] ~= nil then

        local full_name = "unilib:stone_" .. part_name .. "_cobble_mossy"
        local def_table = core.registered_nodes[full_name]

        unilib.register_stairs(full_name, {
            cooked_name = "unilib:stone_" .. part_name,
            group_type = "mossy_cobble",
            slab_img_list = slab_img_list,
        })
        unilib.register_carvings(full_name, {
            millwork_flag = true,
        })
        unilib.register_wall({
            orig_name = wall_orig_name,
            ingredient = full_name,

            replace_mode = replace_mode,
            description = unilib.utils.brackets(S("Wall"), def_table.description),
            sound_name = "stone",
            img_list = def_table.tiles,
        })

    end

end
