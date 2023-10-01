---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- bushes.lua
--      Set up shared functions for bushes
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Register bush nodes
---------------------------------------------------------------------------------------------------

function unilib.register_bush_stem(data_table)

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
    --      select_table (table): Table used in the .selection_box field in the
    --          minetest.register_node() call
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
        description = unilib.annotate(description, sci_name),
        tiles = {img},
        groups = {choppy = common_group, flammable = common_group, oddly_breakable_by_hand = 1},
        sounds = unilib.sound_table.wood,

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

function unilib.register_bush_leaves(data_table)

    -- Adapted from default:bush_leaves
    -- Creates a bush leaves node, for bushes written in the style of minetest_game's acacia bush
    --      (note that bushes in other styles might not call this function)
    -- Should normally be followed by a call to unilib.register_leafdecay() in
    --      ../lib/shared/flora.lua
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
    local inv_img = unilib.filter_leaves_img(img_list[1])

    unilib.register_node(full_name, orig_name, replace_mode, {
        description = unilib.annotate(description, sci_name),
        tiles = img_list,
        groups = {flammable = 2, leaves = 1, snappy = 3},
        sounds = unilib.sound_table.leaves,

        drawtype = "allfaces_optional",
        drop = {
            max_items = 1,
            items = {
                {items = {"unilib:bush_" .. part_name .. "_sapling"}, rarity = 5},
                {items = {"unilib:bush_" .. part_name .. "_leaves"}}
            }
        },
        inventory_image = inv_img,
        paramtype = "light",
        wield_img = inv_img,

        -- (In functions_tree.lua)
        after_place_node = unilib.after_place_leaves,
    })

    return full_name

end

function unilib.register_bush_sapling(data_table)

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
    --      common_group (int): e.g. 2; used to set the "flammable" group
    --      description (str): e.g. "Acacia Bush Leaves"
    --      grow_func (func): Function called by unilib.grow_tree_sapling(), instead of executing
    --          its normal code. Used for special handling of sapling growth
    --      max_volume (int): Maximum interval of interior volume check, in the call to
    --          unilib.sapling_on_place()
    --      min_light (int): Minimum light required for sapling growth
    --      maxp_table (table):
    --      minp_table (table):
    --          maxp, minp to be checked, relative to sapling pos, in the call to
    --          unilib.sapling_on_place()
    --      offset_list (list): x/y/z adjustments used in the call to minetest.place_schematic()
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
    --          minetest.register_node() call
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
    local common_group = data_table.common_group or 2
    local description = data_table.description or S("Bush Sapling")
    local grow_func = data_table.grow_func or nil
    local max_volume = data_table.max_volume or 2
    local min_light = data_table.min_light or unilib.light_min_grow_sapling
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
        description = unilib.annotate(description, sci_name),
        tiles = {img},
        groups = {
            attached_node = 1, dig_immediate = 3, flammable = common_group, sapling = 1, snappy = 2,
        },
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

            minetest.get_node_timer(pos):start(
                math.random(unilib.sapling_grow_min, unilib.sapling_grow_max)
            )

        end,

        on_place = function(itemstack, placer, pointed_thing)

            itemstack = unilib.sapling_on_place(
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

            if not unilib.can_grow_sapling(pos, full_name) then

                -- Try again 5 minutes later
                minetest.get_node_timer(pos):start(unilib.sapling_grow_min)
                return

            else

                unilib.grow_bush_sapling(pos, full_name)

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

    if grow_func ~= nil then
        data_table.grow_func = grow_func
    end

    if min_light ~= unilib.light_min_grow_sapling then
        data_table.min_light = min_light
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

function unilib.register_bush_sapling_lbm(data_table)

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

            minetest.get_node_timer(pos):start(
                math.random(unilib.sapling_grow_min, unilib.sapling_grow_max)
            )

        end
    })

end

---------------------------------------------------------------------------------------------------
-- Grow bush saplings
---------------------------------------------------------------------------------------------------

function unilib.grow_bush_sapling(pos, full_name)

    -- Adapted from default/trees.lua
    -- Can be called by anything. Called periodically from the on_timer() function of each bush
    --      sapling
    -- Converts a sapling into a bush

    -- Retrieve data for this sapling
    local data_table = unilib.sapling_table[full_name]
    if data_table == nil then
        return false
    end

    -- Some bushes provide special handling for growing the sapling
    if data_table.grow_func ~= nil then
        return data_table.grow_func(pos, full_name)
    end

    -- (Compulsory)
    local part_name = data_table.part_name
    -- (Optional)
    local offset_list = data_table.offset_list or {1, 1, 1}
    local schem_list = data_table.schem_list

    unilib.log(
        "action",
        "The " .. part_name .. " bush sapling grows into a bush at " .. minetest.pos_to_string(pos)
    )

    -- From default: bushes do not need "from sapling" schematic variants because only the stem node
    --      is force-placed in the schematic
    if schem_list == nil then

        -- Use a schematic whose name is in a standard format
        minetest.place_schematic(
            {x = pos.x - offset_list[1], y = pos.y - offset_list[2], z = pos.z - offset_list[3]},
            unilib.path_mod .. "/mts/unilib_bush_" .. part_name .. ".mts",
            "0",
            nil,
            false
        )

    else

        -- Use one of the specified schematics at random
        local mini_list = schem_list[math.random(#schem_list)]

        minetest.place_schematic(
            {x = pos.x - mini_list[2], y = pos.y - mini_list[3], z = pos.z - mini_list[4]},
            unilib.path_mod .. "/mts/" .. mini_list[1] .. ".mts",
            "0",
            nil,
            false
        )

    end

end
