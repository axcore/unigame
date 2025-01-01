---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- bushes_base.lua
--      Base API functions for bushes
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Base API functions for bushes
---------------------------------------------------------------------------------------------------

function unilib.bushes._register_stem(data_table)

    -- Adapted from default:bush_stem
    -- Creates a bush stem node, for bushes written in the style of minetest_game's acacia bush
    --      (note that bushes in other styles might not call this function)
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "acacia"
    --      orig_name (str): e.g. "default:acacia_bush_stem"
    --
    -- data_table optional fields:
    --      replace_mode (str): e.g. "defer"
    --      common_group (int): e.g. 2; used to set the "choppy" and "flammable" groups
    --      description (str): e.g. "Acacia Bush Stem"
    --      sci_name (str): e.g. "Rhododendron ferrugineum". The string may contain just the genus
    --          if the species isn't identifiable, or can be omitted entirely when necessary (as is
    --          the case for the acacia bush)
    --      select_table (table): Table used in the .selection_box field in the core.register_node()
    --          call
    --
    -- Return values:
    --      The full_name of the new node

    local part_name = data_table.part_name
    local orig_name = data_table.orig_name

    local replace_mode = data_table.replace_mode or unilib.default_replace_mode
    local common_group = data_table.common_group or 2
    local description = data_table.description or S("Stem")
    local sci_name = data_table.sci_name or nil
    local select_table = data_table.select_table or {-7 / 16, -0.5, -7 / 16, 7 / 16, 0.5, 7 / 16}

    local full_name = "unilib:bush_" .. part_name .. "_stem"
    local img = "unilib_bush_" .. part_name .. "_stem.png"

    unilib.register_node(full_name, orig_name, replace_mode, {
        description = unilib.utils.annotate(description, sci_name),
        tiles = {img},
        -- N.B. bushstem = 1 is the equivalent of tree = 1 for tree trunks (we can't use bush = 1
        --      as an equivalent, because it's already in use)
        groups = {
            bushstem = 1, choppy = common_group, flammable = common_group,
            oddly_breakable_by_hand = 1,
        },
        sounds = unilib.global.sound_table.wood,

        drawtype = "plantlike",
        inventory_image = img,
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = select_table,
        },
        sunlight_propagates = true,
        visual_scale = 1.41,
        wield_image = img,
    })

    return full_name

end

function unilib.bushes._register_leaves(data_table)

    -- Adapted from default:bush_leaves
    -- Creates a bush leaves node, for bushes written in the style of minetest_game's acacia bush
    --      (note that bushes in other styles might not call this function)
    -- Should normally be followed by a call to unilib.register_leafdecay() in
    --      ../lib/shared/flora/flora_leafdecay.lua
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "acacia"
    --      orig_name (str): e.g. "default:acacia_bush_leaves"
    --
    -- data_table optional fields:
    --      replace_mode (str): e.g. "defer"
    --      description (str): e.g. "Acacia Bush Leaves"
    --      sci_name (str): e.g. "Rhododendron ferrugineum". The string may contain just the genus
    --          if the species isn't identifiable, or can be omitted entirely when necessary (as is
    --          the case for the acacia bush)
    --      img_list (list or nil): Textures(s) for the .tiles field
    --
    -- Return values:
    --      The full_name of the new node

    local part_name = data_table.part_name
    local orig_name = data_table.orig_name

    local replace_mode = data_table.replace_mode or unilib.default_replace_mode
    local description = data_table.description or S("Leaves")
    local img_list = data_table.img_list or {"unilib_unknown.png"}
    local sci_name = data_table.sci_name or nil

    local full_name = "unilib:bush_" .. part_name .. "_leaves"
    local inv_img = unilib.flora.filter_leaves_img(img_list[1])

    unilib.register_node(full_name, orig_name, replace_mode, {
        description = unilib.utils.annotate(description, sci_name),
        tiles = img_list,
        groups = {flammable = 2, leaves = 1, snappy = 3},
        sounds = unilib.global.sound_table.leaves,

        drawtype = "allfaces_optional",
        drop = {
            max_items = 1,
            items = {
                {items = {"unilib:bush_" .. part_name .. "_sapling"}, rarity = 5},
                {items = {"unilib:bush_" .. part_name .. "_leaves"}},
            },
        },
        inventory_image = inv_img,
        paramtype = "light",
        wield_img = inv_img,

        -- (In functions_tree.lua)
        after_place_node = unilib.flora.after_place_leaves,
    })

    return full_name

end

function unilib.bushes._register_sapling(data_table)

    -- Adapted from default:bush_sapling
    -- Creates a bush sapling node, for bushes written in the style of minetest_game's acacia bush
    --      (note that bushes in other styles might not call this function)
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "acacia"
    --      orig_name (str): e.g. "default:acacia_bush_leaves"
    --
    -- data_table optional fields:
    --      replace_mode (str): e.g. "defer"
    --      can_grow_func (func): Function called by the sapling's .on_timer() callback, instead of
    --          calling unilib.flora.can_grow_sapling() as normal, in order to determine whether the
    --          sapling can grow in current conditions. If specified, the function should return
    --          true to grow the sapling, or false to try again later
    --      common_group (int): e.g. 2; used to set the "flammable" group
    --      description (str): e.g. "Acacia Bush Leaves"
    --      grow_func (func): Function called by unilib.bushes.grow_sapling(), instead of executing
    --          its normal code. When executed, it replaces the sapling with a bush. Used for
    --          special handling of sapling growth, overriding code for schematics
    --      grow_fail_func (func): Function called by the sapling's .on_timer() callback, when
    --          unilib.flora.can_grow_sapling() (or the function specified by .can_grow_func)
    --          returns a false value. If not specified, the timer is automatically restarted so
    --          unilib can try again later; if specified, the timer is not restarted automatically,
    --          and the specified function is called instead
    --      max_volume (int): Maximum interval of interior volume check, in the call to
    --          unilib.flora.sapling_on_place()
    --      min_light (int): Minimum light required for sapling growth
    --      maxp_table (table):
    --      minp_table (table):
    --          maxp, minp to be checked, relative to sapling pos, in the call to
    --          unilib.flora.sapling_on_place()
    --      offset_list (list): x/y/z adjustments used in the call to core.place_schematic()
    --      schem_list (list):
    --          A list of schematics, one of which is chosen at random when the bush is grown from
    --              a sapling. If using a non-conventional schematic name, then the list can
    --              consist of one item (which is therefore always chosen)
    --          Each item in the list is a mini list, in the form
    --              [schematic_name, x, y, z]
    --          ...where "schematic_name" is a file in ../mts/ (not including its file extension),
    --              and x/y/z are optional values; if specified, they replace the values in the
    --              .offset_list field
    --      sci_name (str): e.g. "Rhododendron ferrugineum". The string may contain just the genus
    --          if the species isn't identifiable, or can be omitted entirely when necessary (as is
    --          the case for the acacia bush)
    --      select_table (table): Table used in the .selection_box field in the
    --          core.register_node() call
    --      under_list (list or nil): If specified, one or more nodes on top of which the sapling
    --          must be "planted" in order for it to grow. If an empty list, the sapling doesn't
    --          grow on anything. If nil, the sapling can grow on any soil. Best practice is to
    --          include both the original node name and its unilib equivalent, e.g.
    --          { "unilib:bush_ordinary_sapling", "default:bush_sapling" }
    --
    -- Return values:
    --      The full_name of the new node

    local part_name = data_table.part_name
    local orig_name = data_table.orig_name

    local replace_mode = data_table.replace_mode or unilib.default_replace_mode
    local can_grow_func = data_table.can_grow_func or nil
    local common_group = data_table.common_group or 2
    local description = data_table.description or S("Bush Sapling")
    local grow_func = data_table.grow_func or nil
    local grow_fail_func = data_table.grow_fail_func or nil
    local max_volume = data_table.max_volume or 2
    local min_light = data_table.min_light or unilib.constant.light_min_grow_sapling
    local maxp_table = data_table.maxp_table or {x = 1, y = 1, z = 1}
    local minp_table = data_table.minp_table or {x = -1, y = 0, z = -1}
    local offset_list = data_table.offset_list or {1, 1, 1}
    local schem_list = data_table.schem_list or nil
    local sci_name = data_table.sci_name or nil
    local select_table = data_table.select_table or {-4 / 16, -0.5, -4 / 16, 4 / 16, 2 / 16, 4 / 16}
    local under_list = data_table.under_list or nil

    local full_name = "unilib:bush_" .. part_name .. "_sapling"
    local img = "unilib_bush_" .. part_name .. "_sapling.png"

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
        groups = {
            attached_node = 1, dig_immediate = 3, flammable = common_group, sapling = 1, snappy = 2,
        },
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

            core.get_node_timer(pos):start(
                math.random(unilib.setting.sapling_grow_min, unilib.setting.sapling_grow_max)
            )

        end,

        on_place = function(itemstack, placer, pointed_thing)

            itemstack = unilib.flora.sapling_on_place(
                itemstack,
                placer,
                pointed_thing,
                full_name,
                -- minp, maxp to be checked, relative to sapling pos
                minp_table,
                maxp_table,
                -- maximum interval of interior volume check
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

                unilib.bushes.grow_sapling(pos, full_name)

            end

        end,
    })

    -- Update global variables
    local data_table = {
        part_name = part_name,
        sapling_type = "bush",

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

    if min_light ~= unilib.constant.light_min_grow_sapling then
        data_table.min_light = min_light
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

function unilib.bushes._register_sapling_lbm(data_table)

    -- Adapted from default/trees.lua
    -- Note that in default, trees have an LBM but bushes don't (for unknown reasons)
    -- Nevertheless, bush packages can call this function, if they need an lbm
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "acacia"

    local part_name = data_table.part_name

    unilib.register_lbm({
        label = "Convert bush sapling to node timer [unilib]",
        name = "unilib:lbm_system_convert_bush_" .. part_name,
        nodenames = {"unilib:tree_" .. part_name .. "_sapling"},

        action = function(pos)

            core.get_node_timer(pos):start(
                math.random(unilib.setting.sapling_grow_min, unilib.setting.sapling_grow_max)
            )

        end
    })

end
