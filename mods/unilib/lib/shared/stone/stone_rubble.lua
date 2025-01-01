---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- stone_rubble.lua
--      Registry functions for rubble
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Registry functions for rubble
---------------------------------------------------------------------------------------------------

function unilib.stone._register_rubble(data_table)

    -- Original to unilib
    -- Creates a rubble stone node (which behaves much like cobble, however carvings, walls and
    --      mossy variants can't be created from it, and only basic stairs can be made from its)
    -- Under ordinary circumstances, digging a weak smoothstone will produce rubble, rather than
    --      cobble (following the behaviour described in PFAA)
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "aplite", a key in unilib.global.stone_table
    --      orig_name (str): e.g. "underch:aplite_rubble"
    --
    -- data_table optional fields:
    --      replace_mode (str): e.g. "defer"
    --      description (str): e.g. "Aplite Rubble"
    --      group_table (table): Non-standard rubble groups. If specified, they overwrite the
    --          standard rubble groups
    --      img_list (list): e.g. {"unilib_stone_aplite_rubble.png"}. If omitted, "part_name" is
    --          used to specify the image name in a standard format
    --      slab_img_list (list): If specified, a texture list to be used in slabs and other
    --          suitable stair nodes. If not specified, the node's own texture list is used
    --
    -- Return values:
    --      The full_name of the new node

    local part_name = data_table.part_name
    local orig_name = data_table.orig_name

    local replace_mode = data_table.replace_mode or unilib.default_replace_mode
    local description = data_table.description or S("Rubble")
    local group_table = data_table.group_table or {}
    local img_list = data_table.img_list or {"unilib_stone_" .. part_name .. "_rubble.png"}
    local slab_img_list = data_table.slab_img_list or nil

    local full_name = "unilib:stone_" .. part_name .. "_rubble"

    local adj_group_table = {crumbly = 2, falling_node = 1, rubble = 1}
    for k, v in pairs(group_table) do
        adj_group_table[k] = v
    end

    unilib.register_node(full_name, orig_name, replace_mode, {
        description = description,
        tiles = img_list,
        groups = adj_group_table,
        sounds = unilib.global.sound_table.gravel,

        is_ground_content = false,
    })
    unilib.register_craft({
        type = "cooking",
        output = "unilib:stone_" .. part_name,
        recipe = full_name,
    })

    unilib.register_stone_rubble_cuttings({
        part_name = part_name,

        slab_img_list = slab_img_list,
    })

    return full_name

end

function unilib.stone._register_rubble_compressed(data_table)

    -- Original to unilib
    -- Creates a compressed rubble stone node, if the Minetest setting permits them
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "aplite", a key in unilib.global.stone_table
    --      orig_name (str): e.g. "compressed:aplite"
    --
    -- data_table optional fields:
    --      replace_mode (str): e.g. "defer"
    --      description (str): e.g. "Compressed Aplite Rubble"
    --      img_list (list): e.g. {"unilib_stone_aplite_rubble_compressed.png"}. If omitted,
    --          "part_name" is used to specify the image name in a standard format
    --
    -- Return values:
    --      The full_name of the new node, or nil if compressed rubble is not permitted

    if unilib.setting.squeezed_stone_flag then

        local part_name = data_table.part_name
        local orig_name = data_table.orig_name

        local replace_mode = data_table.replace_mode or unilib.default_replace_mode
        local description = data_table.description or S("Compressed Rubble")
        local img_list = data_table.img_list or
                {"unilib_stone_" .. part_name .. "_rubble_compressed.png"}

        local ingredient = "unilib:stone_" .. part_name .. "_rubble"
        local squeezed_name = "unilib:stone_" .. part_name .. "_rubble_compressed"

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

function unilib.stone._register_rubble_condensed(data_table)

    -- Original to unilib
    -- Creates a condensed rubble stone node, if the Minetest setting permits them
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "aplite", a key in unilib.global.stone_table
    --      orig_name (str): e.g. "condensed:aplite"
    --
    -- data_table optional fields:
    --      replace_mode (str): e.g. "defer"
    --      description (str): e.g. "Condensed Aplite Rubble"
    --      img_list (list): e.g. {"unilib_stone_aplite_rubble_condensed.png"}. If omitted,
    --          "part_name" is used to specify the image name in a standard format
    --
    -- Return values:
    --      The full_name of the new node, or nil if condensed rubble is not permitted

    if unilib.setting.squeezed_stone_flag then

        local part_name = data_table.part_name
        local orig_name = data_table.orig_name

        local replace_mode = data_table.replace_mode or unilib.default_replace_mode
        local description = data_table.description or S("Condensed Rubble")
        local img_list = data_table.img_list or
                {"unilib_stone_" .. part_name .. "_rubble_condensed.png"}

        local ingredient = "unilib:stone_" .. part_name .. "_rubble_compressed"
        local squeezed_name = "unilib:stone_" .. part_name .. "_rubble_condensed"

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

function unilib.stone._register_rubble_cuttings(data_table)

    -- Original to unilib; see the comments in unilib.register_stone_smooth_cuttings()
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "aplite", a key in unilib.global.stone_table
    --
    -- data_table optional fields:
    --      slab_img_list (list): If specified, a texture list to be used in slabs and other

    local part_name = data_table.part_name

    local slab_img_list = data_table.slab_img_list or nil

    local full_name = "unilib:stone_" .. part_name .. "_rubble"
    local def_table = core.registered_nodes[full_name]

    if unilib.global.super_stone_table[part_name] ~= nil then

        unilib.register_stairs(full_name, {
            cooked_name = "unilib:stone_" .. part_name,
            group_type = "rubble",
            slab_img_list = slab_img_list,
        })

    elseif unilib.setting.add_stairs_basic_flag then

        unilib.register_stairs(full_name, {
            basic_flag = true,
            cooked_name = "unilib:stone_" .. part_name,
            group_type = "rubble",
            slab_img_list = slab_img_list,
        })

    end

end
