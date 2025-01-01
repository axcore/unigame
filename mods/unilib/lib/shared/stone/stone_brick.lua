---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- stone_brick.lua
--      Registry functions for stone bricks
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

-- (Table used by block and brick variants)
local block_cracky_table = {2, 2, 1, 1, 1}

---------------------------------------------------------------------------------------------------
-- Registry functions for stone bricks
---------------------------------------------------------------------------------------------------

function unilib.stone._register_brick(data_table)

    -- Original to unilib
    -- Creates a brick stone node
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "aplite", a key in unilib.global.stone_table
    --      orig_name (str): e.g. "underch:aplite_brick"
    --
    -- data_table optional fields:
    --      replace_mode (str): e.g. "defer"
    --      description (str): e.g. "Aplite Brick"
    --      group_table (table): Non-standard brick groups. If specified, they overwrite the
    --          standard brick groups
    --      img_list (list): e.g. {"unilib_stone_aplite_brick.png"}. If omitted, "part_name" is used
    --          to specify the image name in a standard format
    --      slab_img_list (list): If specified, a texture list to be used in slabs and other
    --          suitable stair nodes. If not specified, the node's own texture list is used
    --
    -- Return values:
    --      The full_name of the new node

    local part_name = data_table.part_name
    local orig_name = data_table.orig_name

    local replace_mode = data_table.replace_mode or unilib.default_replace_mode
    local description = data_table.description or S("Stone Brick")
    local group_table = data_table.group_table or {}
    local img_list = data_table.img_list or {"unilib_stone_" .. part_name .. "_brick.png"}
    local slab_img_list = data_table.slab_img_list or nil

    local full_name = "unilib:stone_" .. part_name .. "_brick"
    local mini_table = unilib.global.stone_table[part_name]

    local adj_group_table = {
        cracky = block_cracky_table[mini_table.hardness], stone = 1, stonebrick = 1,
    }

    for k, v in pairs(group_table) do
        adj_group_table[k] = v
    end

    local on_place, place_param2
    if not unilib.setting.auto_rotate_brick_flag then
        on_place = core.rotate_node
    else
        place_param2 = 0
    end

    unilib.register_node(full_name, orig_name, replace_mode, {
        description = description,
        tiles = img_list,
        groups = adj_group_table,
        sounds = unilib.global.sound_table.stone,

        is_ground_content = false,
        paramtype2 = "facedir",
        place_param2 = place_param2,

        on_place = on_place,
    })
    unilib.register_craft_2x2x4({
        output = full_name,
        ingredient = "unilib:stone_" .. part_name,
    })

    unilib.register_stone_brick_cuttings({
        part_name = part_name,

        slab_img_list = slab_img_list,
    })

    return full_name

end

---------------------------------------------------------------------------------------------------
-- Register stairs/carvings/walls for stones and super stones
---------------------------------------------------------------------------------------------------

function unilib.stone._register_brick_cuttings(data_table)

    -- Original to unilib; see the comments in unilib.register_super_stone_smooth_cuttings()
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "aplite", a key in unilib.global.stone_table
    --
    -- data_table optional fields:
    --      slab_img_list (list): If specified, a texture list to be used in slabs and other
    --          suitable stair nodes. If not specified, the node's own texture list is used

    local part_name = data_table.part_name

    local slab_img_list = data_table.slab_img_list or nil

    if unilib.global.super_stone_table[part_name] ~= nil then

        local full_name = "unilib:stone_" .. part_name .. "_brick"

        unilib.register_stairs(full_name, {
            group_type = "brick",
            img_rotate_flag = true,
            slab_img_list = slab_img_list,
        })
        unilib.register_carvings(full_name, {
            brick_flag = true,
        })

    end

end
