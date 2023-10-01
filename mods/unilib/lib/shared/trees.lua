---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- trees.lua
--      Set up shared functions for trees
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

-- (From default/functions.lua)
local fence_collision_extra = minetest.settings:get_bool("enable_fence_tall") and 3/8 or 0

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function get_sapling_growth_time(minp_table, maxp_table)

    -- Called by unilib.register_tree_sapling() (but not by unilib.register_tree_sapling_lbm() or
    --      unilib.register_tree_sapling_custom()
    -- Gets the growth time for a sapling after it is placed in the world
    -- By default, the value is randomised between a minimum and maximum value specified by
    --      Minetest settings, which may be varied depending on the tree's height
    --
    -- Args:
    --      minp_table, maxp_table (table): Tables describing the volume occupied by the fully-
    --          grown tree; from which this function extracts a height
    --
    -- Return values:
    --      Returns a time in seconds

    if unilib.sapling_quick_grow_flag or not unilib.sapling_variable_grow_flag then
        return math.random(unilib.sapling_grow_min, unilib.sapling_grow_max)
    end

    -- Extract the approximate height of the tree from its expected volume, correcting for
    --      extreme values (just in case)
    local height = maxp_table.y - minp_table.y
    if height < 5 then
        height = 5
    elseif height > 50 then
        height = 50
    end

    -- Assume an average tree height of 10; so an actual tree height of 20 doubles the growth times,
    --      an actual tree height of 5 halves it
    local factor = height / 10
    return math.floor(math.random(unilib.sapling_grow_min, unilib.sapling_grow_max) * factor)

end

---------------------------------------------------------------------------------------------------
-- Register tree types
---------------------------------------------------------------------------------------------------

function unilib.register_tree(data_table)

    -- Original to unilib
    -- Registers the tree type in a global variable, which can be used by any packages that want to
    --      create items crafted from multiple types of wood (e.g. the "light_post_mese" package)
    --
    -- data_table compulsory fields:
    --      part_name (str): Tree nodes (trunks, wood, leaves etc) have a consistent naming system.
    --          All nodes from the same tree share a common component, e.g. "aspen" from
    --          "unilib:tree_aspen_trunk", "unilib:tree_aspen_wood", etc
    --      description (str): A string used as the basis for the .description field in all
    --          derivative nodes, based on a description of the wood node (e.g. "Aspen Wood"). Note
    --          that the description might include the word "tree", when convenient, e.g.
    --          "Jungle Tree Wood". Note also that the wood node might not exist, in which a
    --          hypothetical description is provided (which is better than nothing)
    --
    -- data_table optional fields:
    --      burnlevel (int): If specified, a value in the range 1-5, corresponding to
    --          unilib.tree_burn_table
    --      not_super_flag (bool): If true, this tree is not suitable for use as a super tree

    local part_name = data_table.part_name
    local description = data_table.description

    local burnlevel = data_table.description or nil
    local not_super_flag = data_table.not_super_flag or false

    -- Update global variables
    if not_super_flag then
        unilib.super_tree_table[part_name] = nil
    elseif unilib.super_tree_mode == "everything" then
        unilib.super_tree_table[part_name] = true
    end

    unilib.tree_table[part_name] = {
        part_name = part_name,

        description = description,
        burnlevel = burnlevel,
        super_flag = unilib.super_tree_table[part_name] or false,
    }

end

---------------------------------------------------------------------------------------------------
-- Register tree nodes
---------------------------------------------------------------------------------------------------

function unilib.register_tree_trunk(data_table)

    -- Adapted from default:tree
    -- Creates a tree trunk node for a tree type already registered in an earlier call to
    --      unilib.register_tree()
    -- N.B. Tree trunks from default are not registered for millwork carvings (even though the
    --      mymillwork code does that), to be consistent with the lack of stairs
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "aspen", a key in unilib.tree_table
    --      orig_name (str): e.g. "default:aspen_tree"
    --
    -- data_table optional fields:
    --      replace_mode (str): e.g. "defer"
    --      burnlevel (int): value in the range 0-5, see ../lib/system/global.lua. If 0, the item is
    --          not flammable. If 1-5, overrides the value of "burntime"
    --      burntime (int): e.g. 22. If 0, the item is not flammable
    --      common_group (int): e.g. 3; used to set the "choppy" and "flammable" groups
    --      description (str): e.g. "Aspen Tree Trunk"
    --      group_table (table): Complete group table; overrides "common_group" if that is also
    --          specified
    --      sci_name (str): e.g. "Populus tremula". The string may contain just the genus if the
    --          species isn't identifiable, or can be omitted entirely when necessary
    --      strip_flag (bool): If true, the trunk can be stripped using a tree chisel (and a
    --          separate bark-less node is created); assumes that the textures exist, and that
    --          the "item_chisel_tree" package is available. (N.B. Only applied to super trees)
    --      variant_name (str): e.g. "small". If specified, this function has already been called
    --           with the same "part_name"; this call creates a trunk variant (e.g. originally
    --           "unilib:tree_poplar_trunk", now "unilib:tree_poplar_trunk_small")
    --
    -- Return values:
    --      The full_name of the new node

    local part_name = data_table.part_name
    local orig_name = data_table.orig_name

    local replace_mode = data_table.replace_mode or unilib.default_replace_mode
    local burnlevel = data_table.burnlevel or nil
    local burntime = data_table.burntime or 30
    local common_group = data_table.common_group or 2
    local description = data_table.description or S("Tree Trunk")
    local group_table = data_table.group_table or nil
    local sci_name = data_table.sci_name or nil
    local strip_flag = data_table.strip_flag or false
    local variant_name = data_table.variant_name or nil

    local full_name, trunk_img, top_img
    if variant_name == nil then

        full_name = "unilib:tree_" .. part_name .. "_trunk"
        trunk_img = "unilib_tree_" .. part_name .. "_trunk.png"
        top_img = "unilib_tree_" .. part_name .. "_trunk_top.png"

    else

        full_name = "unilib:tree_" .. part_name .. "_trunk_" .. variant_name
        trunk_img = "unilib_tree_" .. part_name .. "_trunk_" .. variant_name .. ".png"
        top_img = "unilib_tree_" .. part_name .. "_trunk_top_" .. variant_name .. ".png"

    end

    if group_table == nil then

        group_table = {
            choppy = common_group, flammable = common_group, oddly_breakable_by_hand = 1, tree = 1,
        }

    end

    if burnlevel ~= nil and burnlevel ~= 0 then

        burntime = unilib.tree_burn_table.trunk[burnlevel]

    elseif burnlevel == 0 then

        burntime = 0
        group_table.flammable = nil

    end

    unilib.register_node(full_name, orig_name, replace_mode, {
        description = unilib.annotate(description, sci_name),
        tiles = {top_img, top_img, trunk_img},
        groups = group_table,
        sounds = unilib.sound_table.wood,

        is_ground_content = false,
        paramtype2 = "facedir",

        on_place = minetest.rotate_node,
    })
    if burntime ~= 0 then

        unilib.register_craft({
            type = "fuel",
            recipe = full_name,
            burntime = burntime,
        })

    end

    if strip_flag and unilib.super_tree_table[part_name] ~= nil then
        unilib.register_tree_trunk_stripped(data_table)
    end

    return full_name

end

function unilib.register_tree_trunk_stripped(data_table)

    -- Code adapted from stripped_tree/functions.lua
    -- Provides a tree trunk whose bark has been stripped using a tree chisel. Usually called by
    --      unilib.register_tree_trunk(), can be called directly from the package if necessary
    -- "data_table" is in the same format used in calls to unilib.register_tree_trunk(data_table)
    --      (but some fields are ignored)
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "aspen", a key in unilib.tree_table
    --      orig_name (str): e.g. "default:aspen_tree"
    --
    -- data_table optional fields:
    --      replace_mode (str): e.g. "defer"
    --      burnlevel (int): ignored
    --      burntime (int): ignored
    --      common_group (int): e.g. 3; used to set the "choppy" and "flammable" groups
    --      description (str): e.g. "Aspen Tree Trunk"
    --      group_table (table): Complete group table; overrides "common_group" if that is also
    --          specified
    --      sci_name (str): ignored
    --      strip_flag (bool): ignored
    --      variant_name (str): e.g. "small". If specified, this function has already been called
    --           with the same "part_name"; this call creates a trunk variant (e.g. originally
    --           "unilib:tree_poplar_trunk", now "unilib:tree_poplar_trunk_small")
    --
    -- Return values:
    --      The full_name of the new node

    local part_name = data_table.part_name
    local orig_name = data_table.orig_name

    local replace_mode = data_table.replace_mode or unilib.default_replace_mode
--  local burnlevel = data_table.burnlevel or nil
--  local burntime = data_table.burntime or 30
    local common_group = data_table.common_group or 2
    local description = data_table.description or S("Tree Trunk")
    local group_table = data_table.group_table or nil
--  local sci_name = data_table.sci_name or nil
--  local strip_flag = data_table.strip_flag or false
    local variant_name = data_table.variant_name or nil

    local full_name
    if variant_name == nil then
        full_name = "unilib:tree_" .. part_name .. "_trunk"
    else
        full_name = "unilib:tree_" .. part_name .. "_trunk_" .. variant_name
    end

    local bark_name = "unilib:item_bark_tree"
    local strip_full_name = full_name .. "_stripped"
    local strip_orig_name_list = {}

    for _, this_full_name in ipairs(unilib.convert_to_list(orig_name)) do

        local mod_name, item_name = unilib.split_name(this_full_name)
        table.insert(strip_orig_name_list, mod_name .. ":stripped_" .. item_name)

    end

    local trunk_img = "unilib_tree_" .. part_name .. "_trunk_stripped.png"
    local top_img = "unilib_tree_" .. part_name .. "_trunk_top_stripped.png"

    if group_table == nil then

        group_table = {
            choppy = common_group, flammable = common_group, not_in_creative_inventory = 1,
            oddly_breakable_by_hand = 1, tree = 1,
        }

    else

        group_table.not_in_creative_inventory = 1

    end

    unilib.register_node(strip_full_name, strip_orig_name_list, replace_mode, {
        description = unilib.brackets(description, S("Stripped")),
        tiles = {top_img, top_img, trunk_img},
        groups = group_table,
        sounds = unilib.sound_table.wood,

        is_ground_content = false,
        paramtype2 = "facedir",

        on_place = minetest.rotate_node,
    })

    -- Reverse craft recipe to restore the trunk's bark
    unilib.register_craft({
        output = full_name,
        recipe = {
            {"", bark_name, ""},
            {bark_name, strip_full_name, bark_name},
            {"", bark_name, ""},
        },
    })

    return strip_full_name

end

function unilib.register_tree_wood(data_table)

    -- Adapted from default:wood
    -- Creates a tree wood node for a tree type already registered in an earlier call to
    --      unilib.register_tree()
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "aspen", a key in unilib.tree_table
    --      orig_name (str): e.g. "default:aspen_wood"
    --
    -- data_table optional fields:
    --      replace_mode (str): e.g. "defer"
    --      burnlevel (int): value in the range 0-5, see ../lib/system/global.lua. If 0, the item is
    --          not flammable. If 1-5, overrides the value of "burntime"
    --      burntime (int): e.g. 5. If 0, the item is not flammable
    --      common_group (int): e.g. 3; used to set the "choppy" and "flammable" groups
    --      description (str): e.g. "Aspen Wood Planks"
    --      group_table (table): Complete group table; overrides "common_group" if that is also
    --          specified
    --      variant_name (str or nil): e.g. "small". If specified, this function has already been
    --          called with the same "part_name"; this call creates a wood variant (e.g.
    --              originally "unilib:tree_poplar_wood", now "unilib:tree_poplar_wood_small")
    --
    -- Return values:
    --      The full_name of the new node

    local part_name = data_table.part_name
    local orig_name = data_table.orig_name

    local replace_mode = data_table.replace_mode or unilib.default_replace_mode
    local burnlevel = data_table.burnlevel or nil
    local burntime = data_table.burntime or 7
    local common_group = data_table.common_group or 2
    local description = data_table.description or S("Wood Planks")
    local group_table = data_table.group_table or nil
    local variant_name = data_table.variant_name or nil

    local full_name, img
    if variant_name == nil then

        full_name = "unilib:tree_" .. part_name .. "_wood"
        img = "unilib_tree_" .. part_name .. "_wood.png"

    else

        full_name = "unilib:tree_" .. part_name .. "_wood_" .. variant_name
        img = "unilib_tree_" .. part_name .. "_wood_" .. variant_name .. ".png"

    end

    if group_table == nil then

        group_table = {
            choppy = common_group, flammable = common_group, oddly_breakable_by_hand = 2, wood = 1,
        }

    end

    local on_place, place_param2
    if not unilib.auto_rotate_wood_flag then
        on_place = minetest.rotate_node
    else
        place_param2 = 0
    end

    if burnlevel ~= nil and burnlevel ~= 0 then

        burntime = unilib.tree_burn_table.wood[burnlevel]

    elseif burnlevel == 0 then

        burntime = 0
        group_table.flammable = nil

    end

    unilib.register_node(full_name, orig_name, replace_mode, {
        description = description,
        tiles = {img},
        groups = group_table,
        sounds = unilib.sound_table.wood,

        is_ground_content = false,
        paramtype2 = "facedir",
        place_param2 = place_param2,

        on_place = on_place,
    })
    unilib.register_craft({
        output = full_name .. " 4",
        recipe = {
            {"unilib:tree_" .. part_name .. "_trunk"},
        }
    })
    if burntime ~= 0 then

        unilib.register_craft({
            type = "fuel",
            recipe = full_name,
            burntime = burntime,
        })

    end

    unilib.register_tree_wood_cuttings(part_name)

    return full_name

end

function unilib.register_tree_leaves(data_table)

    -- Adapted from default:leaves
    -- Creates a tree leaves node for a tree type already registered in an earlier call to
    --      unilib.register_tree()
    -- Should normally be followed by a call to unilib.register_leafdecay() in
    --      ../lib/shared/flora.lua
    -- Note that, unlike other functions in this file, there is no facility for making leaves
    --      non-flammable
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "aspen", a key in unilib.tree_table
    --      orig_name (str): e.g. "default:aspen_leaves"
    --
    -- data_table optional fields:
    --      replace_mode (str): e.g. "defer"
    --      base_img (str): If specified, overrides the standard image that is expected for these
    --          leaves
    --      description (str): e.g. "Aspen Tree Leaves"
    --      drawtype (str): If specified, "allfaces_optional" or "plantlike"
    --      drop_table (str): Complete drop table
    --      group_table (table): Complete group table
    --      sapling_rarity (int): e.g. 20 (1 in 20 chance of dropping a sapling)
    --      sci_name (str): e.g. "Populus tremula". The string may contain just the genus if the
    --          species isn't identifiable, or can be omitted entirely when necessary
    --      special_list (str or list): If specified, .special_tiles field for trees that need them
    --          (e.g. Acacia trees)
    --      variant_name (str or nil): e.g. "small". If specified, this function has already been
    --          called with the same "part_name"; this call creates a leaves variant (e.g.
    --              originally "unilib:tree_poplar_leaves", now "unilib:tree_poplar_leaves_small")
    --      visual_scale (int): e.g. 1.3
    --
    -- Return values:
    --      The full_name of the new node

    local part_name = data_table.part_name
    local orig_name = data_table.orig_name

    local replace_mode = data_table.replace_mode or unilib.default_replace_mode
    local base_img = data_table.base_img or nil
    local description = data_table.description or S("Tree Leaves")
    local drawtype = data_table.drawtype or unilib.leaves_drawtype
    local drop_table = data_table.drop_table or nil
    local group_table = data_table.group_table or nil
    local sapling_rarity = data_table.sapling_rarity or 20
    local sci_name = data_table.sci_name or nil
    local special_list = data_table.special_list or nil        -- e.g. for acacia
    local variant_name = data_table.variant_name or nil
    local visual_scale = data_table.visual_scale or unilib.leaves_visual_scale

    local full_name, inv_img
    if variant_name == nil then

        full_name = "unilib:tree_" .. part_name .. "_leaves"
        if base_img == nil then
            base_img = "unilib_tree_" .. part_name .. "_leaves.png"
        end

    else

        full_name = "unilib:tree_" .. part_name .. "_leaves_" .. variant_name
        if base_img == nil then
            base_img = "unilib_tree_" .. part_name .. "_leaves_" .. variant_name .. ".png"
        end

    end

    inv_img = unilib.filter_leaves_img(base_img)

    if drop_table == nil then

        if not unilib.leaves_drop_sticks_flag then

            drop_table = {
                max_items = 1,
                items = {
                    {items = {"unilib:tree_" .. part_name .. "_sapling"}, rarity = sapling_rarity},
                    {items = {full_name}},
                },
            }

        else

            -- Drop ordinary sticks at the same rate as saplings. Since the user has enabled the
            --      setting, we assume that the package "item_stick_ordinary" is available
            drop_table = {
                max_items = 1,
                items = {
                    {items = {"unilib:tree_" .. part_name .. "_sapling"}, rarity = sapling_rarity},
                    {items = {"unilib:item_stick_ordinary"}, rarity = sapling_rarity},
                    {items = {full_name}},
                },
            }

        end

    end

    if group_table == nil then
        group_table = {flammable = 2, leafdecay = 3, leaves = 1, snappy = 3}
    end

    unilib.register_node(full_name, orig_name, replace_mode, {
        description = unilib.annotate(description, sci_name),
        tiles = {base_img},
        groups = group_table,
        sounds = unilib.sound_table.leaves,

        drawtype = drawtype,
        drop = drop_table,
        inventory_image = inv_img,
        is_ground_content = false,
        paramtype = "light",
        special_tiles = special_list,
        visual_scale = visual_scale,
        walkable = unilib.walkable_leaves_flag,
        waving = 1,
        wield_img = inv_img,

        after_place_node = unilib.after_place_leaves,
    })

    return full_name

end

function unilib.register_tree_sapling(data_table)

    -- Adapted from default:sapling
    -- Creates a tree sapling node for a tree type already registered in an earlier call to
    --      unilib.register_tree()
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "aspen", a key in unilib.tree_table
    --      orig_name (str): e.g. "default:aspen_sapling"
    --
    -- data_table optional fields:
    --      replace_mode (str): e.g. "defer"
    --      burnlevel (int): value in the range 0-5, see ../lib/system/global.lua. If 0, the item is
    --          not flammable. If 1-5, overrides the value of "burntime"
    --      burntime (int): e.g. 4. If 0, the item is not flammable
    --      common_group (int): e.g. 3; used to set the "flammable" group
    --      description (str): e.g. "Aspen Tree Sapling"
    --      group_table (table): Complete group table; overrides "common_group" if that is also
    --          specified
    --      grow_func (func): Function called by unilib.grow_tree_sapling(), instead of executing
    --          its normal code. Used for special handling of sapling growth, overriding code for
    --          schematics and L-system trees
    --      ltree_model (table): L-system tree model for trees that need them, overriding code for
    --          schematics
    --      max_volume (int): Maximum interval of interior volume check, in the call to
    --          unilib.sapling_on_place()
    --      min_light (int): Minimum light required for sapling growth
    --      maxp_table (table):
    --      minp_table (table):
    --          maxp, minp to be checked, relative to sapling pos, in the call to
    --          unilib.sapling_on_place()
    --      offset_list (list): x/y/z adjustments used in the call to minetest.place_schematic()
    --      replace_func (func): When the sapling is replaced by a tree, minetest.place_schematic()
    --          is called. If specified, this function is called to provide a replacement table used
    --          as an argument in the minetest.place_schematic() call, for example to replace pink
    --          sakura leaves with white sakura leaves 10% of the time (see the "tree_sakura"
    --          package for a code example). The function receives the sapling's pos table as an
    --          argument
    --      schem_list (list):
    --          A list of schematics, one of which is chosen at random when the tree is grown from
    --              a sapling. If using a non-conventional schematic name, then the list can
    --              consist of one item (which is therefore always chosen)
    --          Each item in the list is a mini list, in the form
    --              [schematic_name, offset_x, offset_y, offset_z]
    --          ...where "schematic_name" is a file in ../mts/ (not including its file extension),
    --              and offset_x/offset_y/offset_z are optional values; if specified, they replace
    --              the values in the .offset_list field
    --      sci_name (str): e.g. "Populus tremula". The string may contain just the genus if the
    --          species isn't identifiable, or can be omitted entirely when necessary
    --      select_table (table): Table used in the .selection_box field in the
    --          minetest.register_node() call
    --      under_list (list or nil): If specified, one or more nodes on top of which the sapling
    --          must be "planted" in order for it to grow. If an empty list, the sapling doesn't
    --          grow on anything. If nil, the sapling can grow on any dirt. Best practice is to
    --          include both the original node name and its unilib equivalent, e.g.
    --          { "unilib:dirt_ordinary_with_turf_bamboo", "ethereal:bamboo_dirt" }
    --      variant_name (str or nil): e.g. "small". If specified, this function has already been
    --          called with the same "part_name"; this call creates a sapling variant (e.g.
    --              originally "unilib:tree_poplar_sapling", now "unilib:tree_poplar_sapling_small")
    --
    -- Return values:
    --      The full_name of the new node

    local part_name = data_table.part_name
    local orig_name = data_table.orig_name

    local replace_mode = data_table.replace_mode or unilib.default_replace_mode
    local burnlevel = data_table.burnlevel or nil
    local burntime = data_table.burntime or 5
    local common_group = data_table.common_group or 2
    local description = data_table.description or S("Tree Sapling")
    local group_table = data_table.group_table or nil
    local grow_func = data_table.grow_func or nil
    local ltree_model = data_table.ltree_model or nil
    local max_volume = data_table.max_volume or 4
    local min_light = data_table.min_light or unilib.light_min_grow_sapling
    local maxp_table = data_table.maxp_table or {x = 3, y = 6, z = 3}
    local minp_table = data_table.minp_table or {x = -3, y = 1, z = -3}
    local offset_list = data_table.offset_list or {3, 1, 3}
    local replace_func = data_table.replace_func or nil
    local schem_list = data_table.schem_list or nil
    local sci_name = data_table.sci_name or nil
    local select_table = data_table.select_table or {-4 / 16, -0.5, -4 / 16, 4 / 16, 7 / 16, 4 / 16}
    local under_list = data_table.under_list or nil
    local variant_name = data_table.variant_name or nil

    local full_name, img
    if variant_name == nil then

        full_name = "unilib:tree_" .. part_name .. "_sapling"
        img = "unilib_tree_" .. part_name .. "_sapling.png"

    else

        full_name = "unilib:tree_" .. part_name .. "_sapling_" .. variant_name
        img = "unilib_tree_" .. part_name .. "_sapling_" .. variant_name .. ".png"

    end

    if group_table == nil then

        group_table = {
            attached_node = 1, dig_immediate = 3, flammable = common_group, sapling = 1, snappy = 2,
        }

    end

    if burnlevel ~= nil and burnlevel ~= 0 then

        burntime = unilib.tree_burn_table.sapling[burnlevel]

    elseif burnlevel == 0 then

        burntime = 0
        group_table.flammable = nil

    end

    -- (The .offset_list field provides fallback values for the .schem_list field, when they are
    --      not specified directly)
    if schem_list ~= nil then

        for _, mini_list in pairs(schem_list) do

            for i = 2, 4 do

                if mini_list[i] == nil then
                    mini_list[i] = offset_list[i - 1]
                end

            end

        end

    end

    unilib.register_node(full_name, orig_name, replace_mode, {
        description = unilib.annotate(description, sci_name),
        tiles = {img},
        groups = group_table,
        sounds = unilib.sound_table.leaves,

        drawtype = "plantlike",
        inventory_image = img,
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = select_table
        },
        sunlight_propagates = true,
        walkable = false,
        wield_image = img,

        on_construct = function(pos)

            --[[
            minetest.get_node_timer(pos):start(
                math.random(unilib.sapling_grow_min, unilib.sapling_grow_max)
            )
            ]]--
            minetest.get_node_timer(pos):start(get_sapling_growth_time(minp_table, maxp_table))

        end,

        on_place = function(itemstack, placer, pointed_thing)

            itemstack = unilib.sapling_on_place(
                itemstack,
                placer,
                pointed_thing,
                full_name,
                -- minp, maxp to be checked, relative to sapling pos
                -- minp_relative.y = 1 because sapling pos has been checked
                minp_table,
                maxp_table,
                -- Maximum interval of interior volume check
                max_volume
            )

            return itemstack

        end,

        on_timer = function(pos)

            if not unilib.can_grow_sapling(pos, full_name) then

                -- Try again later
                minetest.get_node_timer(pos):start(unilib.sapling_grow_retry)
                return

            else

                unilib.grow_tree_sapling(pos, full_name)

            end

        end,
    })
    if burntime ~= 0 then

        unilib.register_craft({
            type = "fuel",
            recipe = full_name,
            burntime = burntime,
        })

    end
    unilib.register_tree_sapling_lbm({
        part_name = part_name,
    })

    -- Update global variables
    local data_table = {
        part_name = part_name,
        sapling_type = "tree",

        min_height = maxp_table.y,
        offset_list = offset_list,
        schem_list = schem_list,
    }

    if grow_func ~= nil then
        data_table.grow_func = grow_func
    end

    if ltree_model ~= nil then
        data_table.ltree_model = ltree_model
    end

    if min_light ~= unilib.light_min_grow_sapling then
        data_table.min_light = min_light
    end

    if replace_func ~= nil then
        data_table.replace_func = replace_func
    end

    if under_list ~= nil then
        data_table.under_list = under_list
    end

    unilib.sapling_table[full_name] = data_table

    -- Saplings can be placed in flowerpots, if settings permit it
    unilib.register_sapling_in_pot(full_name, orig_name)

    -- All done
    return full_name

end

function unilib.register_tree_sapling_lbm(data_table)

    -- Adapted from default/trees.lua
    -- Usually called from unilib.register_tree_sapling()
    -- Creates an LBM for a tree type already registered in an earlier call to
    --      unilib.register_tree()
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "aspen", a key in unilib.tree_table

    local part_name = data_table.part_name

    unilib.register_lbm({
        label = "Convert tree sapling to node timer [unilib]",
        name = "unilib:lbm_system_convert_tree_" .. part_name,
        nodenames = {"unilib:tree_" .. part_name .. "_sapling"},

        action = function(pos)

            minetest.get_node_timer(pos):start(
                math.random(unilib.sapling_grow_min, unilib.sapling_grow_max)
            )

        end
    })

end

function unilib.register_tree_sapling_custom(data_table)

    -- A stripped-down version of unilib.register_tree_sapling(), to be used with saplings that
    --      use non-standard sapling code
    -- Assuming that the unilib.register_node() has already been called to create the sapling
    --      "full_name", modify it to add a timer
    -- The specified function is used instead of calling unilib.grow_tree_sapling(), as we
    --      normally would
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "fern", a key in unilib.tree_table
    --      grow_func (func): Function called by unilib.grow_tree_sapling(), instead of executing
    --          its normal code. Used for special handling of sapling growth
    --
    -- data_table optional fields:
    --      Any property of unilib.sapling_table(), excluding .part_name, .sapling_type and
    --          .grow_func

    local part_name = data_table.part_name
    local grow_func = data_table.grow_func

    local full_name = "unilib:tree_" .. part_name .. "_sapling"

    unilib.override_item(full_name, {

        on_construct = function(pos)

            minetest.get_node_timer(pos):start(
                math.random(unilib.sapling_grow_min, unilib.sapling_grow_max)
            )

        end,

        on_timer = function(pos)

            if not unilib.can_grow_sapling(pos, full_name) then

                -- Try again 5 minutes later
                minetest.get_node_timer(pos):start(unilib.sapling_grow_min)
                return

            else

                grow_func(pos, full_name)

            end

        end,
    })

    -- Update global variables
    data_table.sapling_type = "tree"
    unilib.sapling_table[full_name] = data_table

end

function unilib.register_tree_panel(data_table)

    -- Adapted from moreblocks:all_faces_tree
    -- Creates a tree panel node for a tree type already registered in an earlier call to
    --      unilib.register_tree()
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "aspen", a key in unilib.tree_table
    --      orig_name (str): e.g. "moreblocks:all_faces_aspen_tree"
    --
    -- data_table optional fields:
    --      replace_mode (str): e.g. "defer"
    --      burnlevel (int): value in the range 0-5, see ../lib/system/global.lua. If 0, the item is
    --          not flammable. If 1-5, overrides the value of "burntime"
    --      burntime (int): e.g. 22. If 0, the item is not flammable
    --      common_group (int): e.g. 3; used to set the "choppy" and "flammable" groups
    --      description (str): e.g. "Aspen Wood Panel"
    --      group_table (table): Complete group table; overrides "common_group" if that is also
    --          specified
    --
    -- Return values:
    --      The full_name of the new node

    local part_name = data_table.part_name
    local orig_name = data_table.orig_name

    local replace_mode = data_table.replace_mode or unilib.default_replace_mode
    local burnlevel = data_table.burnlevel or nil
    local burntime = data_table.burntime or 22
    local common_group = data_table.common_group or 3
    local description = data_table.description or S("Wood Panel")
    local group_table = data_table.group_table or nil

    local full_name = "unilib:tree_" .. part_name .. "_panel"
    local trunk_name = "unilib:tree_" .. part_name .. "_trunk"

    if group_table == nil then

        group_table = {
            choppy = common_group, flammable = common_group, oddly_breakable_by_hand = 1, wood = 1,
        }

    end

    if burnlevel ~= nil and burnlevel ~= 0 then

        burntime = unilib.tree_burn_table.panel[burnlevel]

    elseif burnlevel == 0 then

        burntime = 0
        group_table.flammable = nil

    end

    unilib.register_node(full_name, orig_name, replace_mode, {
        description = description,
        tiles = {"unilib_tree_" .. part_name .. "_trunk_top.png"},
        groups = group_table,
        sounds = unilib.sound_table.wood,
    })
    unilib.register_craft({
        output = full_name .. " 8",
        recipe = {
            {trunk_name, trunk_name, trunk_name},
            {trunk_name, "", trunk_name},
            {trunk_name, trunk_name, trunk_name},
        }
    })
    if burntime ~= 0 then

        unilib.register_craft({
            type = "fuel",
            recipe = full_name,
            burntime = burntime,
        })

    end

    unilib.register_tree_panel_cuttings(part_name)

    return full_name

end

---------------------------------------------------------------------------------------------------
-- Register stairs/carvings for super trees
---------------------------------------------------------------------------------------------------

function unilib.register_tree_wood_cuttings(part_name)

    -- Original to unilib
    -- Some original mods specify stairs and/or carvings for their trees, but most do not (and never
    --      in a consistent way)
    -- In unilib code, we add stairs/carvings in a consistent way
    -- In order to prevent countless thousands of unnecessary items; we only add new stairs/
    --      carvings/walls to super trees (but we add a few basic stairs to everything)
    --
    -- This function is called for woods; the function just below is called for panels
    --
    -- Args:
    --      part_name (str): e.g. "aspen", a key in unilib.tree_table

    local full_name = "unilib:tree_" .. part_name .. "_wood"

    if unilib.super_tree_table[part_name] ~= nil then

        -- Super trees have stairs and carvings
        unilib.register_stairs(full_name, {
            group_type = "wood",
        })
        unilib.register_carvings(full_name, {
            column_flag = true,
            millwork_flag = true,
        })

    elseif unilib.add_stairs_basic_flag then

        -- All trees, not just super trees, have basic stairs (if basic stairs are enabled in
        --      general)
        unilib.register_stairs(full_name, {
            basic_flag = true,
            group_type = "wood",
        })

    end

end

function unilib.register_tree_panel_cuttings(part_name)

    local full_name = "unilib:tree_" .. part_name .. "_panel"

    if unilib.super_tree_table[part_name] ~= nil then

        unilib.register_stairs(full_name)

    elseif unilib.add_stairs_basic_flag then

        unilib.register_stairs(full_name, {
            basic_flag = true,
        })

    end

end

---------------------------------------------------------------------------------------------------
-- Grow tree saplings
---------------------------------------------------------------------------------------------------

function unilib.grow_tree_sapling(pos, full_name)

    -- Adapted from default/trees.lua
    -- Can be called by anything. Called periodically from the on_timer() function of each tree
    --      sapling
    -- Converts a sapling into a tree

    -- Retrieve data for this sapling
    local data_table = unilib.sapling_table[full_name]
    if data_table == nil then
        return false
    end

    if data_table.grow_func ~= nil then

        -- Some trees provide special handling for growing the sapling
        -- (It's the responsibility of the called function to remove the sapling)
        data_table.grow_func(pos, full_name)

    elseif data_table.ltree_model ~= nil then

        -- Grow an L-system tree, first removing the sapling
        minetest.remove_node(pos)
        minetest.spawn_tree(pos, data_table.ltree_model)

    else

        -- Grow the tree using a schematic

        -- (Compulsory)
        local part_name = data_table.part_name
        -- (Optional)
        local offset_list = data_table.offset_list or {3, 1, 3}
        local schem_list = data_table.schem_list

        unilib.log(
            "action",
            "The " .. part_name .. " tree sapling grows into a tree at " ..
                    minetest.pos_to_string(pos)
        )

        local replace_table
        if data_table.replace_func ~= nil then
            replace_table = data_table.replace_func(pos)
        end

        if schem_list == nil then

            -- Use a schematic whose name is in a standard format
            local mts_path = unilib.path_mod .. "/mts/unilib_tree_" .. part_name ..
                    "_from_sapling.mts"
            if not unilib.is_file(mts_path) then
                mts_path = unilib.path_mod .. "/mts/unilib_tree_" .. part_name .. ".mts"
            end

            minetest.remove_node(pos)
            minetest.place_schematic(
                {
                    x = pos.x - offset_list[1],
                    y = pos.y - offset_list[2],
                    z = pos.z - offset_list[3],
                },
                mts_path,
                "0",
                replace_table,
                false
            )

        else

            -- Use one of the specified schematics at random
            local mini_list = schem_list[math.random(#schem_list)]

            minetest.remove_node(pos)
            minetest.place_schematic(
                {x = pos.x - mini_list[2], y = pos.y - mini_list[3], z = pos.z - mini_list[4]},
                unilib.path_mod .. "/mts/" .. mini_list[1] .. ".mts",
                "0",
                replace_table,
                false
            )

        end

    end

end

---------------------------------------------------------------------------------------------------
-- Register fences (quickly)
---------------------------------------------------------------------------------------------------

function unilib.register_fence_all(data_table)

    -- Quickly register all three fence types (fences, fence rails, gates)
    -- This function is intended for packages, whose original mods didn't specify any fences;
    --      therefore this function can be called with just the bare minimum of arguments
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "aspen", a key in unilib.tree_table
    --
    -- data_table optional fields:
    --      replace_mode (str): e.g. "defer"
    --      burnlevel (int): value in the range 0-5, see ../lib/system/global.lua. If 0, the item is
    --          not flammable. If 1-5, overrides the value of "burntime"
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

function unilib.register_fence_quick(data_table)

    -- Adapted from default:fence_wood
    -- Creates a fence for a tree type already registered in an earlier call to
    --      unilib.register_tree()
    -- This function creates a definition table, and passes it on to unilib.register_fence().
    --      That function can be called directly, if preferred
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "aspen", a key in unilib.tree_table
    --      orig_name (str): e.g. "default:fence_aspen_wood"
    --
    -- data_table optional fields:
    --      replace_mode (str): e.g. "defer"
    --      base_img (str): If specified, overrides the custom image that is expected for this fence
    --      burnlevel (int): value in the range 0-5, see ../lib/system/global.lua. If 0, the item is
    --          not flammable. If 1-5, overrides the value of "burntime"
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

        burntime = unilib.tree_burn_table.fence[burnlevel]

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
            sounds = unilib.sound_table.wood,

            ingredient = ingredient,
            inventory_image = inv_img,
            wield_image = inv_img,
        },

        replace_mode = replace_mode,
        burntime = burntime,
    })

    return full_name

end

function unilib.register_fence_rail_quick(data_table)

    -- Adapted from default:fence_rail_wood
    -- Creates a fence rail for a tree type already registered in an earlier call to
    --      unilib.register_tree()
    -- This function creates a definition table, and passes it on to unilib.register_fence_rail().
    --      That function can be called directly, if preferred
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "aspen", a key in unilib.tree_table
    --      orig_name (str): e.g. "default:fence_rail_aspen_wood"
    --
    -- data_table optional fields:
    --      replace_mode (str): e.g. "defer"
    --      base_img (str): If specified, overrides the custom image that is expected for this fence
    --      burnlevel (int): value in the range 0-5, see ../lib/system/global.lua. If 0, the item is
    --          not flammable. If 1-5, overrides the value of "burntime"
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

        burntime = unilib.tree_burn_table.fence_rail[burnlevel]

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
            sounds = unilib.sound_table.wood,

            ingredient = ingredient,
            inventory_image = inv_img,
            wield_image = inv_img,
        },

        replace_mode = replace_mode,
        burntime = burntime,
    })

    return full_name

end

function unilib.register_fence_gate_quick(data_table)

    -- Adapted from doors/init.lua
    -- Creates a door for a tree type already registered in an earlier call to
    --      unilib.register_tree()
    -- This function creates a definition table, and passes it on to the standard gate function in
    --      ../lib/shared/doors. That function can be called directly, if preferred
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "aspen", a key in unilib.tree_table
    --      orig_name (list):
    --          e.g. {"doors:gate_aspen_wood_closed", "doors:gate_aspen_wood_open"}
    --
    -- data_table optional fields:
    --      replace_mode (str): e.g. "defer"
    --      base_img (str): If specified, overrides the custom image that is expected for this gate
    --      burnlevel (int): value in the range 0-5, see ../lib/system/global.lua. If 0, the item is
    --          not flammable. If 1-5, overrides the value of "burntime"
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

        burntime = unilib.tree_burn_table.fence_gate[burnlevel]

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

---------------------------------------------------------------------------------------------------
-- Register fences
---------------------------------------------------------------------------------------------------

function unilib.register_fence(data_table)

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
    --      part_name (str): e.g. "aspen", a key in unilib.tree_table
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
        }
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

function unilib.register_fence_rail(data_table)

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
    --      part_name (str): e.g. "aspen", a key in unilib.tree_table
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
        }
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

---------------------------------------------------------------------------------------------------
-- Register bookshelves
---------------------------------------------------------------------------------------------------

local bookshelf_formspec =
        "size[8,7;]" ..
        "list[context;books;0,0.3;8,2;]" ..
        "list[current_player;main;0,2.85;8,1;]" ..
        "list[current_player;main;0,4.08;8,3;8]" ..
        "listring[context;books]" ..
        "listring[current_player;main]" ..
        unilib.get_hotbar_bg(0, 2.85)

local function update_bookshelf(pos)

    -- Adapted from default:bookshelf

    local meta = minetest.get_meta(pos)
    local inv = meta:get_inventory()
    local invlist = inv:get_list("books")

    local formspec = bookshelf_formspec
    -- Inventory slots overlay
    local bx, by = 0, 0.3
    local n_written, n_empty = 0, 0

    -- (Bookshelf has room for 16 books)
    for i = 1, 16 do

        if i == 9 then

            bx = 0
            by = by + 1

        end

        local stack = invlist[i]
        if stack:is_empty() then

            formspec = formspec ..
                "image[" .. bx .. "," .. by .. ";1,1;unilib_furniture_shelf_bookshelf_slot.png]"

        else

            local metatable = stack:get_meta():to_table() or {}
            if metatable.fields and metatable.fields.text then
                n_written = n_written + stack:get_count()
            else
                n_empty = n_empty + stack:get_count()
            end

        end

        bx = bx + 1

    end

    meta:set_string("formspec", formspec)
    if n_written + n_empty == 0 then
        meta:set_string("infotext", S("Empty Bookshelf"))
    else
        meta:set_string("infotext", S("Bookshelf (@1 written, @2 empty books)", n_written, n_empty))
    end

end

function unilib.register_bookshelf(data_table)

    -- Adapted from default:bookshelf
    -- Creates a bookshelf for a tree type already registered in an earlier call to
    --      unilib.register_tree()
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "aspen", a key in unilib.tree_table
    --      orig_name (str): e.g. "default:bookshelf"
    --
    -- data_table optional fields:
    --      replace_mode (str): e.g. "defer"
    --      burnlevel (int): value in the range 0-5, see ../lib/system/global.lua. If 0, the item is
    --          not flammable. If 1-5, overrides the value of "burntime"
    --      burntime (int): e.g. 22. If 0, the item is not flammable
    --      description (str): e.g. "Bookshelf (Aspend Wood)"
    --      group_table (table): Complete group table
    --
    -- Return values:
    --      The full_name of the new node

    local part_name = data_table.part_name
    local orig_name = data_table.orig_name

    local replace_mode = data_table.replace_mode or unilib.default_replace_mode
    local burnlevel = data_table.burnlevel or nil
    local burntime = data_table.burntime or 30
    local description = data_table.description or S("Wooden Bookshelf")
    local group_table = data_table.group_table or nil

    local full_name = "unilib:furniture_shelf_bookshelf_" .. part_name
    local book_name = "unilib:item_book_ordinary"
    local ingredient = "unilib:tree_" .. part_name .. "_wood"
    local shelf_img = "unilib_tree_" .. part_name .. "_wood.png" ..
            "^unilib_furniture_shelf_bookshelf_overlay.png"
    local wood_img = "unilib_tree_" .. part_name .. "_wood.png"

    if group_table == nil then
        group_table = {choppy = 3, flammable = 3, oddly_breakable_by_hand = 2}
    end

    if burnlevel ~= nil and burnlevel ~= 0 then

        burntime = unilib.tree_burn_table.bookshelf[burnlevel]

    elseif burnlevel == 0 then

        burntime = 0
        group_table.flammable = nil

    end

    unilib.register_node(full_name, orig_name, replace_mode, {
        description = description,
        tiles = {wood_img, wood_img, wood_img, wood_img, shelf_img, shelf_img},
        groups = group_table,
        sounds = unilib.sound_table.wood,

        is_ground_content = false,
        paramtype2 = "facedir",

        allow_metadata_inventory_put = function(pos, listname, index, stack)

            if minetest.get_item_group(stack:get_name(), "book") ~= 0 then
                return stack:get_count()
            end
            return 0

        end,

        can_dig = function(pos,player)

            local inv = minetest.get_meta(pos):get_inventory()
            return inv:is_empty("books")

        end,

        on_blast = function(pos)

            local drops = {}
            unilib.get_inventory_drops(pos, "books", drops)
            drops[#drops+1] = full_name
            minetest.remove_node(pos)
            return drops

        end,

        on_construct = function(pos)

            local meta = minetest.get_meta(pos)
            local inv = meta:get_inventory()
            inv:set_size("books", 8 * 2)
            update_bookshelf(pos)

        end,

        on_metadata_inventory_move = function(
            pos, from_list, from_index, to_list, to_index, count, player
        )
            unilib.log("action", player:get_player_name() ..
                    " moves stuff in bookshelf at " .. minetest.pos_to_string(pos))
            update_bookshelf(pos)

        end,

        on_metadata_inventory_put = function(pos, listname, index, stack, player)

            unilib.log("action", player:get_player_name() ..
                    " puts stuff to bookshelf at " .. minetest.pos_to_string(pos))
            update_bookshelf(pos)

        end,

        on_metadata_inventory_take = function(pos, listname, index, stack, player)

            unilib.log("action", player:get_player_name() ..
                    " takes stuff from bookshelf at " .. minetest.pos_to_string(pos))
            update_bookshelf(pos)

        end,
    })
    unilib.register_craft({
        output = full_name,
        recipe = {
            {ingredient, ingredient, ingredient},
            {book_name, book_name, book_name},
            {ingredient, ingredient, ingredient},
        }
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

---------------------------------------------------------------------------------------------------
-- Register vessel shelves
---------------------------------------------------------------------------------------------------

local vessels_shelf_formspec =
    "size[8,7;]" ..
    "list[context;vessels;0,0.3;8,2;]" ..
    "list[current_player;main;0,2.85;8,1;]" ..
    "list[current_player;main;0,4.08;8,3;8]" ..
    "listring[context;vessels]" ..
    "listring[current_player;main]" ..
    unilib.get_hotbar_bg(0, 2.85)

local function update_vessels_shelf(pos)

    -- Adapted from vessels:shelf

    local meta = minetest.get_meta(pos)
    local inv = meta:get_inventory()
    local invlist = inv:get_list("vesels")

    local formspec = vessels_shelf_formspec
    -- Inventory slots overlay
    local vx, vy = 0, 0.3
    local n_items = 0

    -- (Vessels shelf has room for 16 vessels)
    for i = 1, 16 do

        if i == 9 then

            vx = 0
            vy = vy + 1

        end

        if not invlist or invlist[i]:is_empty() then

            formspec = formspec ..
                "image[" .. vx .. "," .. vy .. ";1,1;unilib_furniture_shelf_vessel_slot.png]"

        else

            local stack = invlist[i]
            if not stack:is_empty() then
                n_items = n_items + stack:get_count()
            end

        end

        vx = vx + 1

    end

    meta:set_string("formspec", formspec)
    if n_items == 0 then
        meta:set_string("infotext", S("Empty Vessels Shelf"))
    else
        meta:set_string("infotext", S("Vessels Shelf (@1 items)", n_items))
    end

end

function unilib.register_vessels_shelf(data_table)

    -- Adapted from vessels:shelf
    -- Creates a vessels shelf for a tree type already registered in an earlier call to
    --      unilib.register_tree()
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "aspen", a key in unilib.tree_table
    --      orig_name (str): e.g. "vessels:shelf"
    --
    -- data_table compulsory fields:
    --      replace_mode (str): e.g. "defer"
    --      burnlevel (int): value in the range 0-5, see ../lib/system/global.lua. If 0, the item is
    --          not flammable. If 1-5, overrides the value of "burntime"
    --      burntime (int): e.g. 22. If 0, the item is not flammable
    --      description (str): e.g. "Vessels Shelf (Aspen Wood)"
    --      group_table (table): Complete group table
    --
    -- Return values:
    --      The full_name of the new node

    local part_name = data_table.part_name
    local orig_name = data_table.orig_name

    local replace_mode = data_table.replace_mode or unilib.default_replace_mode
    local burnlevel = data_table.burnlevel or nil
    local burntime = data_table.burntime or 30
    local description = data_table.description or S("Wooden Vessels Shelf")
    local group_table = data_table.group_table or nil

    local full_name = "unilib:furniture_shelf_vessel_" .. part_name
    local ingredient = "unilib:tree_" .. part_name .. "_wood"
    local shelf_img = "unilib_tree_" .. part_name .. "_wood.png" ..
            "^unilib_furniture_shelf_vessel_overlay.png"
    local wood_img = "unilib_tree_" .. part_name .. "_wood.png"

    if group_table == nil then
        group_table = {choppy = 3, flammable = 3, oddly_breakable_by_hand = 2}
    end

    if burnlevel ~= nil and burnlevel ~= 0 then

        burntime = unilib.tree_burn_table.vessels_shelf[burnlevel]

    elseif burnlevel == 0 then

        burntime = 0
        group_table.flammable = nil

    end

    unilib.register_node(full_name, orig_name, replace_mode, {
        description = description,
        tiles = {wood_img, wood_img, wood_img, wood_img, shelf_img, shelf_img},
        groups = group_table,
        sounds = unilib.sound_table.wood,

        is_ground_content = false,
        paramtype2 = "facedir",

        allow_metadata_inventory_put = function(pos, listname, index, stack, player)

            if minetest.get_item_group(stack:get_name(), "vessel") ~= 0 then
                return stack:get_count()
            end
            return 0

        end,

        can_dig = function(pos,player)

            local inv = minetest.get_meta(pos):get_inventory()
            return inv:is_empty("vessels")

        end,

        on_blast = function(pos)

            local drops = {}
            default.get_inventory_drops(pos, "vessels", drops)
            drops[#drops + 1] = full_name
            minetest.remove_node(pos)
            return drops

        end,

        on_construct = function(pos)

            local meta = minetest.get_meta(pos)
            update_vessels_shelf(pos)
            local inv = meta:get_inventory()
            inv:set_size("vessels", 8 * 2)

        end,

        on_metadata_inventory_move = function(
            pos, from_list, from_index, to_list, to_index, count, player
        )
            unilib.log("action", player:get_player_name() ..
                   " moves stuff in vessels shelf at " .. minetest.pos_to_string(pos))
            update_vessels_shelf(pos)

        end,

        on_metadata_inventory_put = function(pos, listname, index, stack, player)

            unilib.log("action", player:get_player_name() ..
                   " moves stuff to vessels shelf at " .. minetest.pos_to_string(pos))
            update_vessels_shelf(pos)

        end,

        on_metadata_inventory_take = function(pos, listname, index, stack, player)

            unilib.log("action", player:get_player_name() ..
                   " takes stuff from vessels shelf at " .. minetest.pos_to_string(pos))
            update_vessels_shelf(pos)

        end,
    })
    unilib.register_craft({
        output = full_name,
        recipe = {
            {ingredient, ingredient, ingredient},
            {"group:vessel", "group:vessel", "group:vessel"},
            {ingredient, ingredient, ingredient},
        }
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

---------------------------------------------------------------------------------------------------
-- Register utility shelves
---------------------------------------------------------------------------------------------------

function unilib.register_utility_shelf(data_table)

    -- Adapted from moreblocks:empty_shelf and xdecor:multishelf
    -- Creates a utility shelf for a tree type already registered in an earlier call to
    --      unilib.register_tree()
    -- Unlike bookshelves and vessels shelves, utility shelves can contain any item
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "aspen", a key in unilib.tree_table
    --      orig_name (str): e.g. "moreblocks:empty_shelf"
    --
    -- data_table compulsory fields:
    --      replace_mode (str): e.g. "defer"
    --      burnlevel (int): value in the range 0-5, see ../lib/system/global.lua. If 0, the item is
    --          not flammable. If 1-5, overrides the value of "burntime"
    --      burntime (int): e.g. 22. If 0, the item is not flammable
    --      description (str): e.g. "Utility Shelf (Aspen Wood)"
    --      group_table (table): Complete group table
    --
    -- Return values:
    --      The full_name of the new node

    local part_name = data_table.part_name
    local orig_name = data_table.orig_name

    local replace_mode = data_table.replace_mode or unilib.default_replace_mode
    local burnlevel = data_table.burnlevel or nil
    local burntime = data_table.burntime or 22
    local description = data_table.description or S("Wooden Utility Shelf")
    local group_table = data_table.group_table or nil

    local full_name = "unilib:furniture_shelf_utility_" .. part_name
    local wood_img = "unilib_tree_" .. part_name .. "_wood.png"
    local shelf_img = wood_img .. "^unilib_furniture_shelf_utility_overlay.png"
    local wood_name = "unilib:tree_" .. part_name .. "_wood"

    if group_table == nil then
        group_table = {choppy = 3, flammable = 3, oddly_breakable_by_hand = 2}
    end

    if burnlevel ~= nil and burnlevel ~= 0 then

        burntime = unilib.tree_burn_table.utility_shelf[burnlevel]

    elseif burnlevel == 0 then

        burntime = 0
        group_table.flammable = nil

    end

    unilib.register_node(full_name, orig_name, replace_mode, {
        description = description,
        tiles = {wood_img, wood_img, wood_img, wood_img, shelf_img, shelf_img},
        groups = group_table,
        sounds = unilib.sound_table.wood,

        is_ground_content = false,
        paramtype2 = "facedir",

        can_dig = function(pos)

            local meta = minetest.get_meta(pos)
            local inv = meta:get_inventory()
            return inv:is_empty("main")

        end,

        on_construct = function(pos)

            local meta = minetest.get_meta(pos)
            meta:set_string(
                "formspec",
                "size[8,8]" ..
                "list[context;main;0,0;8,3;]" ..
                "list[current_player;main;0,4;8,4;]" ..
                "listring[current_player;main]" ..
                "listring[context;main]"
            )
            meta:set_string("infotext", description)
            local inv = meta:get_inventory()
            inv:set_size("main", 24)

        end,

        on_metadata_inventory_move = function(
            pos, from_list, from_index, to_list, to_index, count, player
        )
            -- N.B. Not in original code
            unilib.log("action", player:get_player_name() ..
                   " moves stuff in utility shelf at " .. minetest.pos_to_string(pos))

        end,

        on_metadata_inventory_put = function(pos, listname, index, stack, player)

            -- N.B. Not in original code
            unilib.log("action", player:get_player_name() ..
                   " moves stuff to utility shelf at " .. minetest.pos_to_string(pos))

        end,

        on_metadata_inventory_take = function(pos, listname, index, stack, player)

            -- N.B. Not in original code
            unilib.log("action", player:get_player_name() ..
                   " takes stuff from utility shelf at " .. minetest.pos_to_string(pos))

        end,
    })
    unilib.register_craft({
        output = full_name,
        recipe = {
            {wood_name, wood_name, wood_name},
            {"group:vessel", "group:book", "group:vessel"},
            {wood_name, wood_name, wood_name},
        }
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

function unilib.register_empty_utility_shelf(data_table)

    -- Adapted from moreblocks:empty_shelf
    -- Creates an empty utility shelf for a tree type already registered in an earlier call to
    --      unilib.register_tree()
    -- Empty shelves don't accept items (so they are purely decorative)
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "aspen", a key in unilib.tree_table
    --      orig_name (str): e.g. "moreblocks:empty_shelf"
    --
    -- data_table compulsory fields:
    --      replace_mode (str): e.g. "defer"
    --      burnlevel (int): value in the range 0-5, see ../lib/system/global.lua. If 0, the item is
    --          not flammable. If 1-5, overrides the value of "burntime"
    --      burntime (int): e.g. 22. If 0, the item is not flammable
    --      description (str): e.g. "Empty Utility Shelf (Aspen Wood)"
    --      group_table (table): Complete group table
    --
    -- Return values:
    --      The full_name of the new node

    local part_name = data_table.part_name
    local orig_name = data_table.orig_name

    local replace_mode = data_table.replace_mode or unilib.default_replace_mode
    local burnlevel = data_table.burnlevel or nil
    local burntime = data_table.burntime or 22
    local description = data_table.description or S("Empty Wooden Utility Shelf")
    local group_table = data_table.group_table or nil

    local full_name = "unilib:furniture_shelf_utility_" .. part_name .. "_empty"
    local bookshelf_name = "unilib:furniture_shelf_bookshelf_" .. part_name
    local sweeper_name = "unilib:item_sweeper"
    local vessels_shelf_name = "unilib:furniture_shelf_vessel_" .. part_name
    local wood_img = "unilib_tree_" .. part_name .. "_wood.png"
    local shelf_img = wood_img .. "^unilib_furniture_shelf_utility_empty_overlay.png"
    local wood_name = "unilib:tree_" .. part_name .. "_wood"

    if group_table == nil then
        group_table = {choppy = 3, flammable = 3, oddly_breakable_by_hand = 2}
    end

    if burnlevel ~= nil and burnlevel ~= 0 then

        burntime = unilib.tree_burn_table.utility_shelf[burnlevel]

    elseif burnlevel == 0 then

        burntime = 0
        group_table.flammable = nil

    end

    unilib.register_node(full_name, orig_name, replace_mode, {
        description = description,
        tiles = {wood_img, wood_img, wood_img, wood_img, shelf_img, shelf_img},
        groups = group_table,
        sounds = unilib.sound_table.wood,

        is_ground_content = false,
        paramtype2 = "facedir",
    })
    -- (Craft recipe from xdecor)
    unilib.register_craft({
        output = full_name,
        recipe = {
            {wood_name, wood_name, wood_name},
            {"", "", ""},
            {wood_name, wood_name, wood_name},
        }
    })
    if unilib.pkg_executed_table["item_book_ordinary"] ~= nil then

        local book_name = "unilib:item_book_ordinary"

        -- (This recipe is in moreblocks)
        unilib.register_craft({
            type = "shapeless",
            output = bookshelf_name,
            recipe = {full_name, book_name, book_name, book_name},
        })

        if unilib.pkg_executed_table["item_sweeper"] ~= nil then

            unilib.register_craft({
                type = "shapeless",
                output = full_name,
                recipe = {sweeper_name, bookshelf_name},
                replacements = {{bookshelf_name, book_name .. " 3"}},
            })

        end

    end
    if unilib.pkg_executed_table["vessel_bottle_glass_empty"] ~= nil then

        local bottle_name = "unilib:vessel_bottle_glass_empty"

        -- (This recipe is not in moreblocks)
        unilib.register_craft({
            type = "shapeless",
            output = vessels_shelf_name,
            recipe = {full_name, bottle_name, bottle_name, bottle_name},
        })

        if unilib.pkg_executed_table["item_sweeper"] ~= nil then

            unilib.register_craft({
                type = "shapeless",
                output = full_name,
                recipe = {sweeper_name, vessels_shelf_name},
                replacements = {{vessels_shelf_name, bottle_name .. " 3"}},
            })

        end

    end
    if burntime ~= 0 then

        unilib.register_craft({
            type = "fuel",
            recipe = full_name,
            burntime = burntime,
        })

    end

    return full_name

end
