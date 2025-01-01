---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- stone_block.lua
--      Registry functions for stone blocks
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

-- (Table used by block and brick variants)
local block_cracky_table = {2, 2, 1, 1, 1}

---------------------------------------------------------------------------------------------------
-- Registry functions for stone blocks
---------------------------------------------------------------------------------------------------

function unilib.stone._register_block(data_table)

    -- Original to unilib
    -- Creates a block stone node
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "aplite", a key in unilib.global.stone_table
    --      orig_name (str): e.g. "underch:aplite_block"
    --
    -- data_table optional fields:
    --      replace_mode (str): e.g. "defer"
    --      description (str): e.g. "Aplite Block"
    --      group_table (table): Non-standard block groups. If specified, they overwrite the
    --          standard block groups
    --      img_list (list): e.g. {"unilib_stone_aplite_block.png"}. If omitted, "part_name" is used
    --          to specify the image name in a standard format
    --      slab_img_list (list): If specified, a texture list to be used in slabs and other
    --          suitable stair nodes. If not specified, the node's own texture list is used
    --
    -- Return values:
    --      The full_name of the new node

    local part_name = data_table.part_name
    local orig_name = data_table.orig_name

    local replace_mode = data_table.replace_mode or unilib.default_replace_mode
    local description = data_table.description or S("Stone Block")
    local group_table = data_table.group_table or {}
    local img_list = data_table.img_list or {"unilib_stone_" .. part_name .. "_block.png"}
    local slab_img_list = data_table.slab_img_list or nil

    local full_name = "unilib:stone_" .. part_name .. "_block"
    local mini_table = unilib.global.stone_table[part_name]

    local hardness = mini_table.hardness
    if unilib.setting.real_stone_hardness_flag and mini_table.hardness_real ~= hardness then

        hardness = mini_table.hardness_real
        if group_table.cracky ~= nil then
            group_table.cracky = block_cracky_table[hardness]
        end

    end

    local adj_group_table = {
        cracky = block_cracky_table[hardness], stone = 1, stoneblock = 1,
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
    unilib.register_craft_3x3x9({
        output = full_name,
        ingredient = "unilib:stone_" .. part_name,
    })

    unilib.register_stone_block_cuttings({
        part_name = part_name,

        slab_img_list = slab_img_list,
    })

    return full_name

end

---------------------------------------------------------------------------------------------------
-- Register stairs/carvings/walls for stones and super stones
---------------------------------------------------------------------------------------------------

function unilib.stone._register_block_cuttings(data_table)

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

        local full_name = "unilib:stone_" .. part_name .. "_block"

        unilib.register_stairs(full_name, {
            group_type = "block",
            slab_img_list = slab_img_list,
        })
        unilib.register_carvings(full_name, {
            millwork_flag = true,
        })

    end

end
