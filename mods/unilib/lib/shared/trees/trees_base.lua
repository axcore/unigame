---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- trees_base.lua
--      Base API functions for trees
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function get_sapling_growth_time(minp_table, maxp_table)

    -- Called by unilib.register_tree_sapling() (but not by unilib.register_tree_sapling_custom() )
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

    if unilib.setting.sapling_quick_grow_flag or not unilib.setting.sapling_variable_grow_flag then
        return math.random(unilib.setting.sapling_grow_min, unilib.setting.sapling_grow_max)
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
    return math.floor(
        math.random(unilib.setting.sapling_grow_min, unilib.setting.sapling_grow_max) * factor
    )

end

---------------------------------------------------------------------------------------------------
-- Register tree types
---------------------------------------------------------------------------------------------------

function unilib.trees._register_tree(data_table)

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
    --          unilib.global.tree_burn_table
    --      incomplete_flag (bool): If true, the calling package does not define a unique tree that
    --          can be grown from a sapling; for example, the "tree_gold" package defines only an
    --          artificially-created wood node; other packages define nodes that are only used in
    --          certain schematics. Note that some tree packages might not call this function at all
    --          (e.g. "tree_mushroom_mixed")
    --      not_super_flag (bool): If true, this tree is not suitable for use as a super tree
    --      slim_flag (bool): If true, the tree's trunk node is smaller than a full node; if false,
    --          it's the size of a full node

    local part_name = data_table.part_name
    local description = data_table.description

    local burnlevel = data_table.description or nil
    local incomplete_flag = data_table.incomplete_flag or false
    local not_super_flag = data_table.not_super_flag or false
    local slim_flag = data_table.slim_flag or false

    -- Update global variables
    if not_super_flag then
        unilib.global.super_tree_table[part_name] = nil
    elseif unilib.global.super_tree_mode == "everything" then
        unilib.global.super_tree_table[part_name] = true
    end

    unilib.global.tree_table[part_name] = {
        part_name = part_name,

        description = description,
        burnlevel = burnlevel,
        incomplete_flag = incomplete_flag,
        slim_flag = slim_flag,
        super_flag = unilib.global.super_tree_table[part_name] or false,
    }

end

---------------------------------------------------------------------------------------------------
-- Register tree nodes
---------------------------------------------------------------------------------------------------

function unilib.trees._register_trunk(data_table)

    -- Adapted from default:tree
    -- Creates a tree trunk node for a tree type already registered in an earlier call to
    --      unilib.register_tree()
    -- N.B. Tree trunks from default are not registered for millwork carvings (even though the
    --      mymillwork code does that), to be consistent with the lack of stairs
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "aspen", a key in unilib.global.tree_table
    --      orig_name (str): e.g. "default:aspen_tree"
    --
    -- data_table optional fields:
    --      replace_mode (str): e.g. "defer"
    --      burnlevel (int): value in the range 0-5, see ../lib/system/global/global_variables.lua.
    --          If 0, the item is not flammable. If 1-5, overrides the value of "burntime"
    --      burntime (int): e.g. 22. If 0, the item is not flammable
    --      common_group (int): e.g. 3; used to set the "choppy" and "flammable" groups
    --      description (str): e.g. "Aspen Tree Trunk"
    --      group_table (table): Complete group table; overrides "common_group" if that is also
    --          specified
    --      sci_name (str): e.g. "Populus tremula". The string may contain just the genus if the
    --          species isn't identifiable, or can be omitted entirely when necessary
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

        burntime = unilib.global.tree_burn_table.trunk[burnlevel]

    elseif burnlevel == 0 then

        burntime = 0
        group_table.flammable = nil

    end

    unilib.register_node(full_name, orig_name, replace_mode, {
        description = unilib.utils.annotate(description, sci_name),
        tiles = {top_img, top_img, trunk_img},
        groups = group_table,
        sounds = unilib.global.sound_table.wood,

        is_ground_content = false,
        paramtype2 = "facedir",

        on_place = core.rotate_node,
    })
    if burntime ~= 0 then

        unilib.register_craft({
            type = "fuel",
            recipe = full_name,
            burntime = burntime,
        })

    end

    unilib.register_tree_trunk_stripped(data_table)

    return full_name

end

function unilib.trees._register_trunk_stripped(data_table)

    -- Code adapted from stripped_tree/functions.lua
    -- Provides a tree trunk whose bark has been stripped using a tree chisel. Usually called by
    --      unilib.register_tree_trunk(), can be called directly from the package if necessary
    -- "data_table" is in the same format used in calls to unilib.register_tree_trunk(data_table)
    --      (but some fields are ignored)
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "aspen", a key in unilib.global.tree_table
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
    --      node_box (table): Standard node_box/selection_box, specified only for "slim" trunks
    --      sci_name (str): ignored
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
    local node_box = data_table.node_box or nil
--  local sci_name = data_table.sci_name or nil
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

    for _, this_full_name in ipairs(unilib.utils.convert_to_list(orig_name)) do

        local mod_name, item_name = unilib.utils.split_name(this_full_name)
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

    local drawtype, paramtype, selection_box
    if node_box ~= nil then

        drawtype = "nodebox"
        paramtype = "light"
        selection_box = node_box

    end

    unilib.register_node(strip_full_name, strip_orig_name_list, replace_mode, {
        description = unilib.utils.brackets(description, S("Stripped")),
        tiles = {top_img, top_img, trunk_img},
        groups = group_table,
        sounds = unilib.global.sound_table.wood,

        drawtype = drawtype,
        is_ground_content = false,
        node_box = node_box,
        paramtype = paramtype,
        paramtype2 = "facedir",
        selection_box = selection_box,

        on_place = core.rotate_node,
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

function unilib.trees._register_wood(data_table)

    -- Adapted from default:wood
    -- Creates a tree wood node for a tree type already registered in an earlier call to
    --      unilib.register_tree()
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "aspen", a key in unilib.global.tree_table
    --      orig_name (str): e.g. "default:aspen_wood"
    --
    -- data_table optional fields:
    --      replace_mode (str): e.g. "defer"
    --      burnlevel (int): value in the range 0-5, see ../lib/system/global/global_variables.lua.
    --          If 0, the item is not flammable. If 1-5, overrides the value of "burntime"
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
    if not unilib.setting.auto_rotate_wood_flag then
        on_place = core.rotate_node
    else
        place_param2 = 0
    end

    if burnlevel ~= nil and burnlevel ~= 0 then

        burntime = unilib.global.tree_burn_table.wood[burnlevel]

    elseif burnlevel == 0 then

        burntime = 0
        group_table.flammable = nil

    end

    unilib.register_node(full_name, orig_name, replace_mode, {
        description = description,
        tiles = {img},
        groups = group_table,
        sounds = unilib.global.sound_table.wood,

        is_ground_content = false,
        paramtype2 = "facedir",
        place_param2 = place_param2,

        on_place = on_place,
    })

    local output = 4
    if unilib.setting.reduced_wood_flag and
        unilib.global.tree_table[part_name] ~= nil and
        unilib.global.tree_table[part_name]["slim_flag"] then
        output = 2
    end

    unilib.register_craft({
        output = full_name .. " " .. output,
        recipe = {
            {"unilib:tree_" .. part_name .. "_trunk"},
        },
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

function unilib.trees._register_leaves(data_table)

    -- Adapted from default:leaves
    -- Creates a tree leaves node for a tree type already registered in an earlier call to
    --      unilib.register_tree()
    -- Should normally be followed by a call to unilib.register_leafdecay() in
    --      ../lib/shared/flora/flora_leafdecay.lua
    -- Note that, unlike other functions in this file, there is no facility for making leaves
    --      non-flammable
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "aspen", a key in unilib.global.tree_table
    --      orig_name (str): e.g. "default:aspen_leaves"
    --
    -- data_table optional fields:
    --      replace_mode (str): e.g. "defer"
    --      base_img (str): If specified, overrides the standard image that is expected for these
    --          leaves
    --      compacted_img (str): If specified, used as the base image in compacted leaves nodes
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
    local compacted_img = data_table.compacted_img or nil
    local description = data_table.description or S("Tree Leaves")
    local drawtype = data_table.drawtype or unilib.global.leaves_drawtype
    local drop_table = data_table.drop_table or nil
    local group_table = data_table.group_table or nil
    local sapling_rarity = data_table.sapling_rarity or 20
    local sci_name = data_table.sci_name or nil
    local special_list = data_table.special_list or nil        -- e.g. for acacia
    local variant_name = data_table.variant_name or nil
    local visual_scale = data_table.visual_scale or unilib.global.leaves_visual_scale

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

    inv_img = unilib.flora.filter_leaves_img(base_img)

    if drop_table == nil then

        if not unilib.setting.leaves_drop_sticks_flag then

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
        description = unilib.utils.annotate(description, sci_name),
        tiles = {base_img},
        groups = group_table,
        sounds = unilib.global.sound_table.leaves,

        drawtype = drawtype,
        drop = drop_table,
        inventory_image = inv_img,
        is_ground_content = false,
        paramtype = "light",
        special_tiles = special_list,
        visual_scale = visual_scale,
        walkable = unilib.setting.walkable_leaves_flag,
        waving = 1,
        wield_img = inv_img,

        after_place_node = unilib.flora.after_place_leaves,
    })

    unilib.register_tree_leaves_compacted(full_name, replace_mode, compacted_img)

    return full_name

end

function unilib.trees._register_leaves_compacted(ingredient, replace_mode, compacted_img)

    -- Original to unilib
    -- Creates compacted tree leaves, if the Minetest setting permits them
    --
    -- Args:
    --      ingredient (str): e.g. "unilib:tree_aspen_leaves". This function expects that a .png
    --          texture exists based on the top texture for this node, e.g.
    --          "unilib_tree_aspen_leaves_compacted.png" (based on "unilib_tree_aspen_leaves.png")
    --      replace_mode (str): e.g. "defer"
    --      compacted_img (str or nil): The base texture to use. If specified, this function uses
    --          it, instead of constructing the texture name (as described just above)
    --
    -- Return values:
    --      The full_name of the new node, or nil if compacted leaves are not permitted

    if unilib.setting.squeezed_leaves_flag then

        local def_table = core.registered_nodes[ingredient]
        if def_table ~= nil then

            local compacted_name = ingredient .. "_compacted"
            local mode = replace_mode or unilib.default_replace_mode

            local base_img
            if compacted_img ~= nil then

                base_img = compacted_img

            else

                base_img = def_table.tiles[1]
                base_img = base_img:sub(1, -5) .. "_compacted.png"

            end

            unilib.register_node(compacted_name, nil, mode, {
                -- Original to unilib
                description = unilib.utils.brackets(def_table.description, S("Compacted")),
                tiles = {
                    base_img, base_img, base_img .. "^unilib_tree_leaves_compacted_overlay.png",
                },
                groups = {cracky = 3, flammable = 2},
                sounds = unilib.global.sound_table.leaves,

                stack_max = unilib.global.squeezed_stack_max,
            })
            unilib.misc.set_squeezed_recipes(ingredient, compacted_name)
            -- N.B. A single leaves node provides 2-3 seconds of fuel. Multiplying by 9 and
            --      accounting for thermal inefficiency, we get a value of 20 (which is 66% of the
            --      average burntime for a trunk node)
            unilib.register_craft({
                type = "fuel",
                recipe = compacted_name,
                burntime = 20,
            })

            return compacted_name

        end

    end

    return nil

end

function unilib.trees._register_sapling(data_table)

    -- Adapted from default:sapling
    -- Creates a tree sapling node for a tree type already registered in an earlier call to
    --      unilib.register_tree()
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "aspen", a key in unilib.global.tree_table
    --      orig_name (str): e.g. "default:aspen_sapling"
    --
    -- data_table optional fields:
    --      replace_mode (str): e.g. "defer"
    --      burnlevel (int): value in the range 0-5, see ../lib/system/global/global_variables.lua.
    --          If 0, the item is not flammable. If 1-5, overrides the value of "burntime"
    --      burntime (int): e.g. 4. If 0, the item is not flammable
    --      can_grow_func (func): Function called by the sapling's .on_timer() callback, instead of
    --          calling unilib.flora.can_grow_sapling() as normal, in order to determine whether the
    --          sapling can grow in current conditions. If specified, the function should return
    --          true to grow the sapling, or false to try again later
    --      common_group (int): e.g. 3; used to set the "flammable" group
    --      description (str): e.g. "Aspen Tree Sapling"
    --      group_table (table): Complete group table; overrides "common_group" if that is also
    --          specified
    --      grow_func (func): Function called by unilib.trees.grow_sapling(), instead of executing
    --          its normal code. When executed, it replaces the sapling with a tree. Used for
    --          special handling of sapling growth, overriding code for schematics and L-system
    --          trees
    --      grow_fail_func (func): Function called by the sapling's .on_timer() callback, when
    --          unilib.flora.can_grow_sapling() (or the function specified by .can_grow_func)
    --          returns a false value. If not specified, the timer is automatically restarted so
    --          unilib can try again later; if specified, the timer is not restarted automatically,
    --          and the specified function is called instead
    --      ltree_model (table): L-system tree model for trees that need them, overriding code for
    --          schematics
    --      max_volume (int): Maximum interval of interior volume check, in the call to
    --          unilib.flora.sapling_on_place()
    --      min_light (int): Minimum light required for sapling growth
    --      maxp_table (table):
    --      minp_table (table):
    --          maxp, minp to be checked, relative to sapling pos, in the call to
    --          unilib.flora.sapling_on_place()
    --      offset_list (list): x/y/z adjustments used in the call to core.place_schematic()
    --      replace_func (func): When the sapling is replaced by a tree, core.place_schematic()
    --          is called. If specified, this function is called to provide a replacement table used
    --          as an argument in the core.place_schematic() call, for example to replace pink
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
    --      select_table (table): Table used in the .selection_box field in the core.register_node()
    --          call
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
    local can_grow_func = data_table.can_grow_func or nil
    local common_group = data_table.common_group or 2
    local description = data_table.description or S("Tree Sapling")
    local group_table = data_table.group_table or nil
    local grow_func = data_table.grow_func or nil
    local grow_fail_func = data_table.grow_fail_func or nil
    local ltree_model = data_table.ltree_model or nil
    local max_volume = data_table.max_volume or 4
    local min_light = data_table.min_light or unilib.constant.light_min_grow_sapling
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

        burntime = unilib.global.tree_burn_table.sapling[burnlevel]

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
        description = unilib.utils.annotate(
            description, sci_name, unilib.flora.get_sapling_hint(under_list)
        ),
        tiles = {img},
        groups = group_table,
        sounds = unilib.global.sound_table.leaves,

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
            core.get_node_timer(pos):start(
                math.random(unilib.setting.sapling_grow_min, unilib.setting.sapling_grow_max)
            )
            ]]--
            core.get_node_timer(pos):start(get_sapling_growth_time(minp_table, maxp_table))

        end,

        on_place = function(itemstack, placer, pointed_thing)

            itemstack = unilib.flora.sapling_on_place(
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

            if (can_grow_func == nil and not unilib.flora.can_grow_sapling(pos, full_name)) or
                    (can_grow_func ~= nil and not can_grow_func(pos, full_name)) then

                if grow_fail_func ~= nil then

                    -- Special handling; this timer will not automatically restart
                    grow_fail_func(pos, full_name)
                    return

                else

                    -- Normal handling; try again 5 minutes later
                    core.get_node_timer(pos):start(unilib.setting.sapling_grow_min)
                    return

                end

            else

                unilib.trees.grow_sapling(pos, full_name)

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

    -- Update global variables
    local data_table = {
        part_name = part_name,
        sapling_type = "tree",

        min_height = maxp_table.y,
        offset_list = offset_list,
        schem_list = schem_list,
    }

    if can_grow_func ~= nil then
        data_table.can_grow_func = can_grow_func
    end

    if grow_func ~= nil then
        data_table.grow_func = grow_func
    end

    if grow_fail_func ~= nil then
        data_table.grow_fail_func = grow_fail_func
    end

    if ltree_model ~= nil then
        data_table.ltree_model = ltree_model
    end

    if min_light ~= unilib.constant.light_min_grow_sapling then
        data_table.min_light = min_light
    end

    if replace_func ~= nil then
        data_table.replace_func = replace_func
    end

    if under_list ~= nil then
        data_table.under_list = under_list
    end

    unilib.global.sapling_table[full_name] = data_table

    -- Saplings can be placed in flowerpots, if settings permit it
    unilib.register_sapling_in_pot(full_name, orig_name)

    -- All done
    return full_name

end

function unilib.trees._register_sapling_custom(data_table)

    -- A stripped-down version of unilib.register_tree_sapling(), to be used with saplings that
    --      use non-standard sapling code
    -- Assuming that the unilib.register_node() has already been called to create the sapling
    --      "full_name", modify it to add a timer
    -- The specified function is used instead of calling unilib.trees.grow_sapling(), as we
    --      normally would
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "fern", a key in unilib.global.tree_table
    --      grow_func (func): Function called by unilib.trees.grow_sapling(), instead of executing
    --          its normal code. When executed, it replaces the sapling with a tree. Used for
    --          special handling of sapling growth, overriding code for schematics and L-system
    --          trees
    --
    -- data_table optional fields:
    --      can_grow_func (func): Function called by the sapling's .on_timer() callback, instead of
    --          calling unilib.flora.can_grow_sapling() as normal, in order to determine whether the
    --          sapling can grow in current conditions. If specified, the function should return
    --          true to grow the sapling, or false to try again later
    --      grow_fail_func (func): Function called by the sapling's .on_timer() callback, when
    --          unilib.flora.can_grow_sapling() (or the function specified by .can_grow_func)
    --          returns a false value. If not specified, the timer is automatically restarted so
    --          unilib can try again later; if specified, the timer is not restarted automatically,
    --          and the specified function is called instead
    --
    --      Otherwise, any property of unilib.global.sapling_table(), excluding .part_name,
    --          .sapling_type, .can_grow_func, .grow_func and .grow_fail_func

    local part_name = data_table.part_name
    local grow_func = data_table.grow_func

    local can_grow_func = data_table.can_grow_func or nil
    local grow_fail_func = data_table.grow_fail_func or nil

    local full_name = "unilib:tree_" .. part_name .. "_sapling"

    unilib.override_item(full_name, {

        on_construct = function(pos)

            core.get_node_timer(pos):start(
                math.random(unilib.setting.sapling_grow_min, unilib.setting.sapling_grow_max)
            )

        end,

        on_timer = function(pos)

            if (can_grow_func == nil and not unilib.flora.can_grow_sapling(pos, full_name)) or
                    (can_grow_func ~= nil and not can_grow_func(pos, full_name)) then

                if grow_fail_func ~= nil then

                    -- Special handling; this timer will not automatically restart
                    grow_fail_func(pos, full_name)
                    return

                else

                    -- Normal handling; try again 5 minutes later
                    core.get_node_timer(pos):start(unilib.setting.sapling_grow_min)
                    return

                end

            else

                grow_func(pos, full_name)

            end

        end,
    })

    -- Update global variables
    data_table.sapling_type = "tree"
    unilib.global.sapling_table[full_name] = data_table

end

function unilib.trees._register_panel(data_table)

    -- Adapted from moreblocks:all_faces_tree
    -- Creates a tree panel node for a tree type already registered in an earlier call to
    --      unilib.register_tree()
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "aspen", a key in unilib.global.tree_table
    --      orig_name (str): e.g. "moreblocks:all_faces_aspen_tree"
    --
    -- data_table optional fields:
    --      replace_mode (str): e.g. "defer"
    --      burnlevel (int): value in the range 0-5, see ../lib/system/global/global_variables.lua.
    --          If 0, the item is not flammable. If 1-5, overrides the value of "burntime"
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

        burntime = unilib.global.tree_burn_table.panel[burnlevel]

    elseif burnlevel == 0 then

        burntime = 0
        group_table.flammable = nil

    end

    unilib.register_node(full_name, orig_name, replace_mode, {
        description = description,
        tiles = {"unilib_tree_" .. part_name .. "_trunk_top.png"},
        groups = group_table,
        sounds = unilib.global.sound_table.wood,

        -- N.B. is_ground_content = false not in original code; added to match trunks/wood
        is_ground_content = false,
    })
    unilib.register_craft({
        output = full_name .. " 8",
        recipe = {
            {trunk_name, trunk_name, trunk_name},
            {trunk_name, "", trunk_name},
            {trunk_name, trunk_name, trunk_name},
        },
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
-- Register stairs/carvings for trees and super trees
---------------------------------------------------------------------------------------------------

function unilib.trees._register_wood_cuttings(part_name)

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
    --      part_name (str): e.g. "aspen", a key in unilib.global.tree_table

    local full_name = "unilib:tree_" .. part_name .. "_wood"

    if unilib.global.super_tree_table[part_name] ~= nil then

        -- Super trees have stairs and carvings
        unilib.register_stairs(full_name, {
            group_type = "wood",
            super_flag = true,
        })
        unilib.register_carvings(full_name, {
            column_flag = true,
            millwork_flag = true,
        })

    elseif unilib.setting.add_stairs_basic_flag then

        -- All trees, not just super trees, have basic stairs (if basic stairs are enabled in
        --      general)
        unilib.register_stairs(full_name, {
            basic_flag = true,
            group_type = "wood",
        })

    end

end

function unilib.trees._register_panel_cuttings(part_name)

    local full_name = "unilib:tree_" .. part_name .. "_panel"

    if unilib.global.super_tree_table[part_name] ~= nil then

        unilib.register_stairs(full_name)

    elseif unilib.setting.add_stairs_basic_flag then

        unilib.register_stairs(full_name, {
            basic_flag = true,
        })

    end

end
