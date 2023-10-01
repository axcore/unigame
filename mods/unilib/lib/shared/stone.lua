---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- stone.lua
--      Set up shared functions for stone
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

-- (Table used by smooth and cobble variants)
local smooth_cracky_table = {3, 2, 1, 1, 1}
-- (Table used by block and brick variants)
local block_cracky_table = {2, 2, 1, 1, 1}
-- (Converts a hardness value in the range 1-5, into the correct output)
local cobble_mode_table = {"rubble", "cobble", "cobble", "smooth", "smooth"}

-- (Maximum stack size for consdensed cobble/rubble)
local condensed_max_stack = 99
if unilib.underch_overstack_condensed_flag then
    condensed_max_stack = 999
end

---------------------------------------------------------------------------------------------------
-- Notes
---------------------------------------------------------------------------------------------------

-- For compatibility with underch and uchu, the following groups should be added to most stone nodes
--      already in the "stone" group:
--          smoothstone stoneblock stonebrick cobble/rubble mossycobble
--          compressedstone condensedstone
-- Note that sandstone nodes traditionally have non-standard groups

---------------------------------------------------------------------------------------------------
-- Register stone types
---------------------------------------------------------------------------------------------------

function unilib.register_stone(data_table)

    -- Original to unilib
    -- Registers the stone type in a global variable
    --
    -- data_table compulsory fields:
    --      part_name (str): Stone nodes (smooth, block, brick, cobble etc) have a consistent naming
    --          system. All nodes from the same smooth stone share a common component, e.g. "aplite"
    --          from "unilib:stone_aplite", "unilib:stone_aplite_block", "unilib:stone_aplite_brick"
    --          etc
    --      description (str): A string used as the basis for the .description field in all
    --          derivative nodes, based on a description of the smooth stone (e.g. "Aplite")
    --
    -- data_table optional fields:
    --      basic_platform_flag (bool): If true, advtrains platforms for the smooth variant (only)
    --          of this stone type are created
    --      category (str): "intrusive" for igneous intrusive rocks, "extrusive" for igneous
    --          extrusive rocks, "sedimentary" for sedimentary rocks, "metamorphic" for metamorphic
    --          rocks, "clay_dirt" for clay/dirt stones like laterite, "other" for rocks that
    --          don't fit into those categories (usually because they are fictional, e.g. ordinary
    --          stone)
    --      fictional_flag (bool): If true, this stone does not exist in reality. This
    --          classification applies in the broadest sense; ordinary stone from minetest_game
    --          is classified as fictional, but silver sandstone is not (because sandstone itself
    --          is not fictional)
    --      grinder_flag (bool): If true, technic grinder recipes are added for the smooth, cobble
    --          and compressed variants of this stone type
    --      grinder_powder (str): The grinder output, when using smooth stone as the input. If not
    --          specified or the output is not available, then "unilib:stone_ordinary_powder" is the
    --          output. Ignored if grinder_flag is false
    --      grinder_gravel (str): The grinder output, when using cobble/compressed cobble as the
    --          input. If not specified or the output is not available, then
    --          "unilib:gravel_ordinary" is the output. Ignored if grinder_flag is false
    --      hardness (int): Value in the range 1-5, corresponding to the PFAA classification:
    --          UNILIB  PFAA            CRACKY      NOTES
    --          1       weak            3           Default value. Digging usually produces rubble
    --          2       medium          2           Digging usually produces cobble
    --          3       strong          1           Digging usually produces cobble
    --          4       very strong     1           Digging usually produces smooth stone
    --          5       n/a             1           Digging usually produces smooth stone
    --          N.B. Hardness 5 is intended mostly for fictional stones, like obscurite, that need
    --              special handling
    --      hardness_real = value
    --          A hardness, also in the range 1-5, matching the real-world properties of a stone.
    --              The value is available to any code that wants to programmatically override each
    --              stone's default behaviour. In most cases, the values of .hardness and
    --              .hardness_real will be the same; when they differ, it is usually because the
    --              original mod's code has specified an unrealistic hardness
    --      moss_flag (bool): If true, the moss-growth ABM is applied to the cobble variant for this
    --          stone type
    --      no_smooth_flag = bool or nil
    --          If true, there is no smooth stone variant for this stone type
    --      platform_flag (bool): If true, advtrains platforms for the smooth, block and brick
    --          variants of this stone type are created. Ignored if .basic_platform_flag is true
    --      not_super_flag (bool): If true, this stone is not suitable for use as a super stone

    local part_name = data_table.part_name
    local description = data_table.description

    local basic_platform_flag = data_table.basic_platform_flag or false
    local category = data_table.category or "default"
    local fictional_flag = data_table.fictional_flag or false
    local grinder_flag = data_table.grinder_flag or false
    local grinder_powder = data_table.grinder_powder or nil
    local grinder_gravel = data_table.grinder_gravel or nil
    local hardness = data_table.hardness or 1
    local hardness_real = data_table.hardness_real or hardness
    local moss_flag = data_table.moss_flag or false
    local no_smooth_flag = data_table.no_smooth_flag or false
    local platform_flag = data_table.platform_flag or false
    local not_super_flag = data_table.not_super_flag or false

    -- Prepare the list of stone variants available to be used as train platforms
    -- (advtrains is called during the package consolidation stage to create these train plaform
    --      nodes)
    local platform_list = nil
    if platform_flag then

        platform_list = {
            "unilib:stone_" .. part_name,
            "unilib:stone_" .. part_name .. "_block",
            "unilib:stone_" .. part_name .. "_brick",
        }

    elseif basic_platform_flag then

        platform_list = {
            "unilib:stone_" .. part_name,
        }

    end

    -- Update global variables
    if not_super_flag then
        unilib.super_stone_table[part_name] = nil
    elseif unilib.super_stone_mode == "everything" then
        unilib.super_stone_table[part_name] = true
    end

    unilib.stone_table[part_name] = {
        part_name = part_name,
        description = description,

        category = category,
        fictional_flag = fictional_flag,
        grinder_flag = grinder_flag,
        grinder_powder = grinder_powder,
        grinder_gravel = grinder_gravel,
        hardness = hardness,
        hardness_real = hardness_real,
        moss_flag = moss_flag,
        no_smooth_flag = no_smooth_flag,
        platform_list = platform_list,
        super_flag = unilib.super_stone_table[part_name] or false,
    }

end

---------------------------------------------------------------------------------------------------
-- Register stone variants
---------------------------------------------------------------------------------------------------

function unilib.register_stone_smooth(data_table)

    -- Original to unilib
    -- Creates a smooth stone node
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "aplite", a key in unilib.stone_table
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
    local mini_table = unilib.stone_table[part_name]

    local hardness = mini_table.hardness
    if unilib.real_stone_hardness_flag and mini_table.hardness_real ~= hardness then

        hardness = mini_table.hardness_real
        if group_table.cracky ~= nil then
            group_table.cracky = smooth_cracky_table[hardness]
        end

    end

    if cobble_mode == nil then

        cobble_mode = cobble_mode_table[hardness]

    elseif cobble_mode == "optional_cobble" then

        if unilib.sandstone_cobble_rubble_flag then
            cobble_mode = "cobble"
        else
            cobble_mode = "smooth"
        end

    elseif cobble_mode == "optional_rubble" then

        if unilib.sandstone_cobble_rubble_flag then
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
        sounds = unilib.sound_table.stone,

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

function unilib.register_stone_block(data_table)

    -- Original to unilib
    -- Creates a block stone node
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "aplite", a key in unilib.stone_table
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
    local mini_table = unilib.stone_table[part_name]

    local hardness = mini_table.hardness
    if unilib.real_stone_hardness_flag and mini_table.hardness_real ~= hardness then

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
        sounds = unilib.sound_table.stone,

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

function unilib.register_stone_brick(data_table)

    -- Original to unilib
    -- Creates a brick stone node
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "aplite", a key in unilib.stone_table
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
    local mini_table = unilib.stone_table[part_name]

    local adj_group_table = {
        cracky = block_cracky_table[mini_table.hardness], stone = 1, stonebrick = 1,
    }

    for k, v in pairs(group_table) do
        adj_group_table[k] = v
    end

    local on_place, place_param2
    if not unilib.auto_rotate_brick_flag then
        on_place = minetest.rotate_node
    else
        place_param2 = 0
    end

    unilib.register_node(full_name, orig_name, replace_mode, {
        description = description,
        tiles = img_list,
        groups = adj_group_table,
        sounds = unilib.sound_table.stone,

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

function unilib.register_stone_cobble(data_table)

    -- Original to unilib
    -- Creates a cobble stone node
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "aplite", a key in unilib.stone_table
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
    local mini_table = unilib.stone_table[part_name]

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
        sounds = unilib.sound_table.stone,

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

function unilib.register_stone_cobble_mossy(data_table)

    -- Original to unilib
    -- Creates a mossy cobble stone node
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "aplite", a key in unilib.stone_table
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
    local mini_table = unilib.stone_table[part_name]

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
        sounds = unilib.sound_table.stone,

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

function unilib.register_stone_cobble_compressed(data_table)

    -- Original to unilib
    -- Creates a compressed cobble stone node
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "aplite", a key in unilib.stone_table
    --      orig_name (str): e.g. "compressed:aplite"
    --
    -- data_table optional fields:
    --      replace_mode (str): e.g. "defer"
    --      description (str): e.g. "Compressed Aplite Cobble"
    --      img_list (list): e.g. {"unilib_stone_aplite_cobble_compressed.png"}. If omitted,
    --          "part_name" is used to specify the image name in a standard format
    --
    -- Return values:
    --      The full_name of the new node

    local part_name = data_table.part_name
    local orig_name = data_table.orig_name

    local replace_mode = data_table.replace_mode or unilib.default_replace_mode
    local description = data_table.description or S("Compressed Cobblestone")
    local img_list = data_table.img_list or
            {"unilib_stone_" .. part_name .. "_cobble_compressed.png"}

    local full_name = "unilib:stone_" .. part_name .. "_cobble_compressed"

    unilib.register_node(full_name, orig_name, replace_mode, {
        description = description,
        tiles = img_list,
        groups = {compressedstone = 1, cracky = 2},
        sounds = unilib.sound_table.stone,
    })
    unilib.register_craft_3x3({
        output = full_name,
        ingredient = "unilib:stone_" .. part_name .. "_cobble",
    })
    unilib.register_craft({
        type = "shapeless",
        output = "unilib:stone_" .. part_name .. "_cobble 9",
        recipe = {full_name},
    })
    minetest.register_craft({
        type = "cooking",
        output = "unilib:stone_" .. part_name .. " 9",
        recipe = full_name,
    })

    return full_name

end

function unilib.register_stone_cobble_condensed(data_table)

    -- Original to unilib
    -- Creates a condensed cobble stone node
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "aplite", a key in unilib.stone_table
    --      orig_name (str): e.g. "condensed:aplite"
    --
    -- data_table optional fields:
    --      replace_mode (str): e.g. "defer"
    --      description (str): e.g. "Condensed Aplite Cobble"
    --      img_list (list): e.g. {"unilib_stone_aplite_cobble_condensed.png"}. If omitted,
    --          "part_name" is used to specify the image name in a standard format
    --
    -- Return values:
    --      The full_name of the new node

    local part_name = data_table.part_name
    local orig_name = data_table.orig_name

    local replace_mode = data_table.replace_mode or unilib.default_replace_mode
    local description = data_table.description or S("Condensed Cobblestone")
    local img_list = data_table.img_list or
            {"unilib_stone_" .. part_name .. "_cobble_condensed.png"}

    local full_name = "unilib:stone_" .. part_name .. "_cobble_condensed"

    unilib.register_node(full_name, orig_name, replace_mode, {
        description = description,
        tiles = img_list,
        groups = {condensedstone = 1, cracky = 1},
        sounds = unilib.sound_table.stone,

        stack_max = condensed_max_stack,
    })
    unilib.register_craft_3x3({
        output = full_name,
        ingredient = "unilib:stone_" .. part_name .. "_cobble_compressed",
    })
    unilib.register_craft({
        type = "shapeless",
        output = "unilib:stone_" .. part_name .. "_cobble_compressed 9",
        recipe = {full_name},
    })

    return full_name

end

function unilib.register_stone_rubble(data_table)

    -- Original to unilib
    -- Creates a rubble stone node (which behaves much like cobble, however carvings, walls and
    --      mossy variants can't be created from it, and only basic stairs can be made from its)
    -- Under ordinary circumstances, digging a weak smoothstone will produce rubble, rather than
    --      cobble (following the behaviour described in PFAA)
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "aplite", a key in unilib.stone_table
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
        sounds = unilib.sound_table.gravel,

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

function unilib.register_stone_rubble_compressed(data_table)

    -- Original to unilib
    -- Creates a compressed rubble stone node
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "aplite", a key in unilib.stone_table
    --      orig_name (str): e.g. "compressed:aplite"
    --
    -- data_table optional fields:
    --      replace_mode (str): e.g. "defer"
    --      description (str): e.g. "Compressed Aplite Rubble"
    --      img_list (list): e.g. {"unilib_stone_aplite_rubble_compressed.png"}. If omitted,
    --          "part_name" is used to specify the image name in a standard format
    --
    -- Return values:
    --      The full_name of the new node

    local part_name = data_table.part_name
    local orig_name = data_table.orig_name

    local replace_mode = data_table.replace_mode or unilib.default_replace_mode
    local description = data_table.description or S("Compressed Rubble")
    local img_list = data_table.img_list or
            {"unilib_stone_" .. part_name .. "_rubble_compressed.png"}

    local full_name = "unilib:stone_" .. part_name .. "_rubble_compressed"

    unilib.register_node(full_name, orig_name, replace_mode, {
        description = description,
        tiles = img_list,
        groups = {compressedstone = 1, cracky = 2},
        sounds = unilib.sound_table.stone,
    })
    unilib.register_craft_3x3({
        output = full_name,
        ingredient = "unilib:stone_" .. part_name .. "_rubble",
    })
    unilib.register_craft({
        type = "shapeless",
        output = "unilib:stone_" .. part_name .. "_rubble 9",
        recipe = {full_name},
    })
    minetest.register_craft({
        type = "cooking",
        output = "unilib:stone_" .. part_name .. " 9",
        recipe = full_name,
    })

    return full_name

end

function unilib.register_stone_rubble_condensed(data_table)

    -- Original to unilib
    -- Creates a condensed rubble stone node
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "aplite", a key in unilib.stone_table
    --      orig_name (str): e.g. "condensed:aplite"
    --
    -- data_table optional fields:
    --      replace_mode (str): e.g. "defer"
    --      description (str): e.g. "Condensed Aplite Rubble"
    --      img_list (list): e.g. {"unilib_stone_aplite_rubble_condensed.png"}. If omitted,
    --          "part_name" is used to specify the image name in a standard format
    --
    -- Return values:
    --      The full_name of the new node

    local part_name = data_table.part_name
    local orig_name = data_table.orig_name

    local replace_mode = data_table.replace_mode or unilib.default_replace_mode
    local description = data_table.description or S("Condensed Rubble")
    local img_list = data_table.img_list or
            {"unilib_stone_" .. part_name .. "_rubble_condensed.png"}

    local full_name = "unilib:stone_" .. part_name .. "_rubble_condensed"

    unilib.register_node(full_name, orig_name, replace_mode, {
        description = description,
        tiles = img_list,
        groups = {condensedstone = 1, cracky = 1},
        sounds = unilib.sound_table.stone,

        stack_max = condensed_max_stack,
    })
    unilib.register_craft_3x3({
        output = full_name,
        ingredient = "unilib:stone_" .. part_name .. "_rubble_compressed",
    })
    unilib.register_craft({
        type = "shapeless",
        output = "unilib:stone_" .. part_name .. "_rubble_compressed 9",
        recipe = {full_name},
    })

    return full_name

end

function unilib.register_stone_cobble_or_rubble_or_nothing(data_table)

    -- Original to unilib
    -- Called for a stone type, whose .hardness and .hardness_real values are different, and when
    --      unilib is creating a new cobble or rubble node (that doesn't appear in the original
    --      mod's code)
    -- Depending on the the stone's .hardness_real, a cobble node, or a rubble node, or nothing at
    --      all should be generated

    -- data_table compulsory fields:
    --      part_name (str): e.g. "siltstone_dark", a key in unilib.stone_table
    --      cobble_description (str): e.g. "Dark Siltstone Cobble"
    --      rubble_description (str): e.g. "Dark Siltstone Rubble"
    --
    -- data_table optional fields:
    --      replace_mode (str): e.g. "defer"
    --      override_drop_flag (bool): If true, the smoothstone node is overriden to drop the
    --          the cobble or rubble node created by this function, if any

    local part_name = data_table.part_name
    local cobble_description = data_table.cobble_description
    local rubble_description = data_table.rubble_description

    local replace_mode = data_table.replace_mode or unilib.default_replace_mode
    local override_drop_flag = data_table.override_drop_flag or false

    local mini_table = unilib.stone_table[part_name]

    if mini_table.hardness_real == 1 then

        unilib.register_stone_rubble({
            part_name = part_name,
            orig_name = nil,

            replace_mode = replace_mode,
            description = rubble_description,
            img_list = {"unilib_stone_" .. part_name .. ".png^unilib_stone_rubble_overlay.png"},
        })
        if override_drop_flag then

            unilib.override_item("unilib:stone_" .. part_name, {
                drop = "unilib:stone_" .. part_name .. "_rubble",
            })

        end

    elseif mini_table.hardness_real <= 3 then

        unilib.register_stone_cobble({
            part_name = part_name,
            orig_name = nil,

            replace_mode = replace_mode,
            description = cobble_description,
            img_list = {"unilib_stone_" .. part_name .. ".png^unilib_stone_cobble_overlay.png"},
        })
        if override_drop_flag then

            unilib.override_item("unilib:stone_" .. part_name, {
                drop = "unilib:stone_" .. part_name .. "_cobble",
            })

        end

    end

end

---------------------------------------------------------------------------------------------------
-- Register stairs/carvings/walls for super stones
---------------------------------------------------------------------------------------------------

function unilib.register_stone_smooth_cuttings(data_table)

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
    --      part_name (str): e.g. "aplite", a key in unilib.stone_table
    --
    -- data_table optional fields:
    --      drop_name (str): If specified, the node dropped when the smoothstone node is dug. If not
    --          specified, then an appropriate node is used
    --      sandstone_flag (bool): If true, the stone is a sandstone, and therefore cobble or rubble
    --          is only dropped if unilib.sandstone_cobble_rubble_flag is true. This argument is
    --          ignore if the "drop_name" argument is specified
    --      slab_img_list (list): If specified, a texture list to be used in slabs and other
    --          suitable stair nodes. If not specified, the node's own texture list is used

    local part_name = data_table.part_name

    local drop_name = data_table.drop_name or nil
    local sandstone_flag = data_table.sandstone_flag or false
    local slab_img_list = data_table.slab_img_list or nil

    local full_name = "unilib:stone_" .. part_name

    if drop_name == nil then

        local drop_type = cobble_mode_table[unilib.get_stone_actual_hardness(part_name)]
        if drop_type ~= "smooth" then
            drop_name = full_name .. "_" .. drop_type
        end

        if sandstone_flag and not unilib.sandstone_cobble_rubble_flag then
            drop_name = nil
        end

    end

    if unilib.super_stone_table[part_name] ~= nil then

        -- Super stones have stairs and carvings
        unilib.register_stairs(full_name, {
            drop_name = drop_name,
            group_type = "smooth",
            slab_img_list = slab_img_list,
        })
        unilib.register_carvings(full_name, {
            all_flag = true,
        })

    elseif unilib.add_stairs_basic_flag then

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

function unilib.register_stone_block_cuttings(data_table)

    -- Original to unilib; see the comments in unilib.register_super_stone_smooth_cuttings()
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "aplite", a key in unilib.stone_table
    --
    -- data_table optional fields:
    --      slab_img_list (list): If specified, a texture list to be used in slabs and other
    --          suitable stair nodes. If not specified, the node's own texture list is used

    local part_name = data_table.part_name

    local slab_img_list = data_table.slab_img_list or nil

    if unilib.super_stone_table[part_name] ~= nil then

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

function unilib.register_stone_brick_cuttings(data_table)

    -- Original to unilib; see the comments in unilib.register_super_stone_smooth_cuttings()
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "aplite", a key in unilib.stone_table
    --
    -- data_table optional fields:
    --      slab_img_list (list): If specified, a texture list to be used in slabs and other
    --          suitable stair nodes. If not specified, the node's own texture list is used

    local part_name = data_table.part_name

    local slab_img_list = data_table.slab_img_list or nil

    if unilib.super_stone_table[part_name] ~= nil then

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

function unilib.register_stone_cobble_cuttings(data_table)

    -- Original to unilib; see the comments in unilib.register_super_stone_smooth_cuttings()
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "aplite", a key in unilib.stone_table
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
    local def_table = minetest.registered_nodes[full_name]

    if unilib.super_stone_table[part_name] ~= nil then

        -- Super stones have stairs, carvings and walls
        unilib.register_stairs(full_name, {
            cooked_name = "unilib:stone_" .. part_name,
            group_type = "cobble",
            slab_img_list = slab_img_list,
        })
        unilib.register_carvings(full_name, {
            column_flag = true,
            millwork_flag = true,
        })
        unilib.register_wall({
            orig_name = wall_orig_name,
            ingredient = full_name,

            replace_mode = replace_mode,
            description = unilib.brackets(S("Wall"), def_table.description),
            sound_name = "stone",
            img_list = def_table.tiles,
        })

    elseif unilib.add_stairs_basic_flag then

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
            description = unilib.brackets(S("Wall"), def_table.description),
            sound_name = "stone",
            img_list = def_table.tiles,
        })

    end

end

function unilib.register_stone_cobble_mossy_cuttings(data_table)

    -- Original to unilib; see the comments in unilib.register_super_stone_smooth_cuttings()
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "aplite", a key in unilib.stone_table
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

    if unilib.super_stone_table[part_name] ~= nil then

        local full_name = "unilib:stone_" .. part_name .. "_cobble_mossy"
        local def_table = minetest.registered_nodes[full_name]

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
            description = unilib.brackets(S("Wall"), def_table.description),
            sound_name = "stone",
            img_list = def_table.tiles,
        })

    end

end

function unilib.register_stone_rubble_cuttings(data_table)

    -- Original to unilib; see the comments in unilib.register_stone_smooth_cuttings()
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "aplite", a key in unilib.stone_table
    --
    -- data_table optional fields:
    --      slab_img_list (list): If specified, a texture list to be used in slabs and other

    local part_name = data_table.part_name

    local slab_img_list = data_table.slab_img_list or nil

    local full_name = "unilib:stone_" .. part_name .. "_rubble"
    local def_table = minetest.registered_nodes[full_name]

    if unilib.super_stone_table[part_name] ~= nil then

        unilib.register_stairs(full_name, {
            cooked_name = "unilib:stone_" .. part_name,
            group_type = "rubble",
            slab_img_list = slab_img_list,
        })

    elseif unilib.add_stairs_basic_flag then

        unilib.register_stairs(full_name, {
            basic_flag = true,
            cooked_name = "unilib:stone_" .. part_name,
            group_type = "rubble",
            slab_img_list = slab_img_list,
        })

    end

end

---------------------------------------------------------------------------------------------------
-- Get hardness-adjusted values
---------------------------------------------------------------------------------------------------

function unilib.get_adjusted_cracky(part_name, smooth_cracky, block_cracky)

    -- Called by some stone packages, for which the stone's in-game and real-world hardness values
    --      are different
    -- If they are indeed different, adjusts the value of the .cracky node group for smoothstones
    --      and blocks
    --
    -- Args:
    --      part_name (str): e.g. "ordinary" for unilib:stone_ordinary, unilib:stone_ordinary_block,
    --          etc
    --      smooth_cracky (int or nil): The value of the .cracky node group for the smoothstone
    --          variant. This original value is returned unless the stone's .hardness and
    --          .hardness_real are different, in which case a standard value is returned. If the
    --          value is not required, the argument's value can be nil (and nil is returned)
    --      block_cracky (int or nil): The value of the .cracky node group for the block variant.
    --          This original value is returned unless the stone's .hardness and .hardness_real are
    --          different, in which case a standard value is returned. If the value is not required,
    --          the argument's value can be nil (and nil is returned)
    --
    -- Return values:
    --      The adjusted values of smooth_cracky and block_cracky

    local mini_table = unilib.stone_table[part_name]

    if not unilib.real_stone_hardness_flag then

        return smooth_cracky, block_cracky

    else

        if smooth_cracky ~= nil then
            smooth_cracky = smooth_cracky_table[mini_table.hardness_real]
        end

        if block_cracky ~= nil then
            block_cracky = block_cracky_table[mini_table.hardness_real]
        end

        return smooth_cracky, block_cracky

    end

end

function unilib.get_stone_actual_hardness(part_name)

    local mini_table = unilib.stone_table[part_name]
    local hardness = mini_table.hardness
    if unilib.real_stone_hardness_flag and mini_table.hardness_real ~= hardness then
        hardness = mini_table.hardness_real
    end

    return hardness

end
