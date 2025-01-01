---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- stone_smooth.lua
--      Registry functions for smooth stone
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

-- (Table used by smooth and cobble variants)
local smooth_cracky_table = {3, 2, 1, 1, 1}
-- (Converts a hardness value in the range 1-5, into the correct output)
local cobble_mode_table = {"rubble", "cobble", "cobble", "smooth", "smooth"}

---------------------------------------------------------------------------------------------------
-- Registry functions for smooth stone
---------------------------------------------------------------------------------------------------

function unilib.stone._register_smooth(data_table)

    -- Original to unilib
    -- Creates a smooth stone node
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "aplite", a key in unilib.global.stone_table
    --      orig_name (str): e.g. "underch:aplite"
    --
    -- data_table optional fields:
    --      replace_mode (str): e.g. "defer"
    --      cobble_mode (str): What happens when smoothstone is dug: "cobble" to produce cobble,
    --          "rubble" to produce rubble, "smooth" to produce smoothstone, "optional_cobble" and
    --          "optional_rubble" to produce those variants (if the Minetest setting permits it,
    --          otherwise produces smoothstone). If not specified or an unrecognised value, then the
    --          output depends on the stone's hardness (see the table above). In general, when the
    --          original mod provides a cobble texture, the package will create a cobble node,
    --          rather than a rubble node
    --      description (str): e.g. "Aplite"
    --      group_table (table): Non-standard smoothstone groups. If specified, they overwrite the
    --          standard smoothstone groups
    --      img_list (list): e.g. {"unilib_stone_aplite.png"}. If omitted, "part_name" is used to
    --          specify the image name in a standard format
    --      slab_img_list (list): If specified, a texture list to be used in slabs and other
    --          suitable stair nodes. If not specified, the node's own texture list is used
    --
    -- Return values:
    --      The full_name of the new node

    local part_name = data_table.part_name
    local orig_name = data_table.orig_name

    local replace_mode = data_table.replace_mode or unilib.default_replace_mode
    local cobble_mode = data_table.cobble_mode or nil
    local description = data_table.description or S("Smooth Stone")
    local group_table = data_table.group_table or {}
    local img_list = data_table.img_list or {"unilib_stone_" .. part_name .. ".png"}
    local slab_img_list = data_table.slab_img_list or nil

    local full_name = "unilib:stone_" .. part_name
    local mini_table = unilib.global.stone_table[part_name]

    local hardness = mini_table.hardness
    if unilib.setting.real_stone_hardness_flag and mini_table.hardness_real ~= hardness then

        hardness = mini_table.hardness_real
        if group_table.cracky ~= nil then
            group_table.cracky = smooth_cracky_table[hardness]
        end

    end

    if cobble_mode == nil then

        cobble_mode = cobble_mode_table[hardness]

    elseif cobble_mode == "optional_cobble" then

        if unilib.setting.sandstone_cobble_rubble_flag then
            cobble_mode = "cobble"
        else
            cobble_mode = "smooth"
        end

    elseif cobble_mode == "optional_rubble" then

        if unilib.setting.sandstone_cobble_rubble_flag then
            cobble_mode = "rubble"
        else
            cobble_mode = "smooth"
        end

    end

    local drop_name
    if cobble_mode == "cobble" or cobble_mode == "rubble" then

        drop_name = full_name .. "_" .. cobble_mode

    else

        -- cobble_mode == "smooth"
        drop_name = full_name

    end

    local adj_group_table = {
        cracky = smooth_cracky_table[hardness], smoothstone = 1, stone = 1,
    }

    for k, v in pairs(group_table) do
        adj_group_table[k] = v
    end

    unilib.register_node(full_name, orig_name, replace_mode, {
        description = description,
        tiles = img_list,
        groups = adj_group_table,
        sounds = unilib.global.sound_table.stone,

        drop = drop_name,
    })

    unilib.register_stone_smooth_cuttings({
        part_name = part_name,

        slab_img_list = slab_img_list,
    })

    -- N.B. The call to unilib.register_stone_trap() does nothing if the "mineral_mese" package is
    --      not available
    unilib.register_stone_trap({
        orig_name = nil,
        ingredient = full_name,
        replace_mode = replace_mode,
        group_table = {cracky = 3},
    })

    return full_name

end

function unilib.stone._register_smooth_compressed(data_table)

    -- Original to unilib
    -- Creates a compressed smoothstone node, if the Minetest setting permits them
    -- This function is intended for stones that don't have a cobble or rubble variant, not for
    --      smoothstones in general. All other stones should create compressed cobble/rubble instead
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "pounamu", a key in unilib.global.stone_table
    --      orig_name (str): e.g. "mod_name:item_name"
    --
    -- data_table optional fields:
    --      replace_mode (str): e.g. "defer"
    --      description (str): e.g. "Compressed Pounamu"
    --      img_list (list): e.g. {"unilib_stone_pounamu_compressed.png"}. If omitted, "part_name"
    --          is used to specify the image name in a standard format
    --
    -- Return values:
    --      The full_name of the new node, or nil if compressed smoothstone is not permitted

    if unilib.setting.squeezed_stone_flag then

        local part_name = data_table.part_name
        local orig_name = data_table.orig_name

        local replace_mode = data_table.replace_mode or unilib.default_replace_mode
        local description = data_table.description or S("Compressed Stone")
        local img_list = data_table.img_list or {"unilib_stone_" .. part_name .. "_compressed.png"}

        local ingredient = "unilib:stone_" .. part_name
        local squeezed_name = ingredient .. "_compressed"

        unilib.register_node(squeezed_name, orig_name, replace_mode, {
            description = description,
            tiles = img_list,
            groups = {compressedstone = 1, cracky = 2},
            sounds = unilib.global.sound_table.stone,
        })
        unilib.misc.set_squeezed_recipes(ingredient, squeezed_name)

        return squeezed_name

    else

        return nil

    end

end

function unilib.stone._register_smooth_condensed(data_table)

    -- Original to unilib
    -- Creates a condensed smoothstone node, if the Minetest setting permits them
    -- This function is intended for stones that don't have a cobble or rubble variant, not for
    --      smoothstones in general. All other stones should create compressed cobble/rubble instead
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "pounamu", a key in unilib.global.stone_table
    --      orig_name (str): e.g. "mod_name:item_name"
    --
    -- data_table optional fields:
    --      replace_mode (str): e.g. "defer"
    --      description (str): e.g. "Condensed Pounamu"
    --      img_list (list): e.g. {"unilib_stone_pounamu_condensed.png"}. If omitted, "part_name" is
    --          used to specify the image name in a standard format
    --
    -- Return values:
    --      The full_name of the new node, or nil if condensed smoothstone not permitted

    if unilib.setting.squeezed_stone_flag then

        local part_name = data_table.part_name
        local orig_name = data_table.orig_name

        local replace_mode = data_table.replace_mode or unilib.default_replace_mode
        local description = data_table.description or S("Condensed Stone")
        local img_list = data_table.img_list or {"unilib_stone_" .. part_name .. "_condensed.png"}

        local ingredient = "unilib:stone_" .. part_name .. "_compressed"
        local squeezed_name = "unilib:stone_" .. part_name .. "_condensed"

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

function unilib.stone._register_smooth_cuttings(data_table)

    -- Original to unilib
    -- Some original mods specify stairs, carvings and/or walls for their stones, but most do not
    --      (and never in a consistent way)
    -- In unilib code, we add stairs/carvings/walls in a consistent way
    -- In order to prevent countless thousands of unnecessary items; we only add new stairs/
    --      carvings/walls to super stones (but we add a few basic stairs to everything)
    --
    -- This function is called for smoothstones; the functions just below are called for blocks,
    --      bricks, cobble, mossy cobble and rubble
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "aplite", a key in unilib.global.stone_table
    --
    -- data_table optional fields:
    --      drop_name (str): If specified, the node dropped when the smoothstone node is dug. If not
    --          specified, then an appropriate node is used
    --      sandstone_flag (bool): If true, the stone is a sandstone, and therefore cobble or rubble
    --          is only dropped if unilib.setting.sandstone_cobble_rubble_flag is true. This
    --          argument is ignore if the "drop_name" argument is specified
    --      slab_img_list (list): If specified, a texture list to be used in slabs and other
    --          suitable stair nodes. If not specified, the node's own texture list is used

    local part_name = data_table.part_name

    local drop_name = data_table.drop_name or nil
    local sandstone_flag = data_table.sandstone_flag or false
    local slab_img_list = data_table.slab_img_list or nil

    local full_name = "unilib:stone_" .. part_name

    if drop_name == nil then

        local drop_type = cobble_mode_table[unilib.stone.get_actual_hardness(part_name)]
        if drop_type ~= "smooth" then
            drop_name = full_name .. "_" .. drop_type
        end

        if sandstone_flag and not unilib.setting.sandstone_cobble_rubble_flag then
            drop_name = nil
        end

    end

    if unilib.global.super_stone_table[part_name] ~= nil then

        -- Super stones have stairs and carvings
        unilib.register_stairs(full_name, {
            drop_name = drop_name,
            group_type = "smooth",
            slab_img_list = slab_img_list,
            super_flag = true,
        })
        unilib.register_carvings(full_name, {
            all_flag = true,
        })

    elseif unilib.setting.add_stairs_basic_flag then

        -- All stones, not just super stones, have basic stairs (if basic stairs are enabled in
        --      general)
        unilib.register_stairs(full_name, {
            basic_flag = true,
            drop_name = drop_name,
            group_type = "smooth",
            slab_img_list = slab_img_list,
        })

    end

end
