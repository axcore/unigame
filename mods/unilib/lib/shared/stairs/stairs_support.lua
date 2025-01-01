---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- stairs_support.lua
--      Stair support functions
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

-- Tables used by node rotation code from moreblocks
local wall_right_dirmap = {9, 18, 7, 12}
local wall_left_dirmap = {11, 16, 5, 14}
local ceil_dirmap = {20, 23, 22, 21}

---------------------------------------------------------------------------------------------------
-- Local functions (imported from minetest_game/stairs and moreblocks, and then optimised)
---------------------------------------------------------------------------------------------------

local function warn_if_exists(adj_full_name)

    -- Adapted from stairs/init.lua

    if core.registered_nodes[adj_full_name] then

        unilib.utils.show_warning(
            "../lib/shared/stairs/stairs_support.lua, warn_if_exists(): Overwriting stairs node",
            adj_full_name
        )

    end

end

local function rotate_and_place(itemstack, placer, pointed_thing)

    -- Adapted from stairs/init.lua

    local p0 = pointed_thing.under
    local p1 = pointed_thing.above
    local param2 = 0

    if placer then

        local placer_pos = placer:get_pos()
        if placer_pos then

            local diff = vector.subtract(p1, placer_pos)
            param2 = core.dir_to_facedir(diff)
            -- The player places a node on the side face of the node he is standing on
            if p0.y == p1.y and
                    math.abs(diff.x) <= 0.5 and
                    math.abs(diff.z) <= 0.5 and
                    diff.y < 0 then

                -- Reverse node direction
                param2 = (param2 + 2) % 4

            end

        end

        local finepos = core.pointed_thing_to_face_pos(placer, pointed_thing)
        local fpos = finepos.y % 1

        if p0.y - 1 == p1.y or
                (fpos > 0 and fpos < 0.5) or
                (fpos < -0.5 and fpos > -0.999999999) then

            param2 = param2 + 20
            if param2 == 21 then
                param2 = 23
            elseif param2 == 23 then
                param2 = 21
            end

        end

    end

    return core.item_place(itemstack, placer, pointed_thing, param2)

end

local function rotate_and_place_advanced(itemstack, placer, pointed_thing)

    -- Adapted from moreblocks/stairsplus/common.lua
    --
    -- Notes from moreblocks:
    -- Extends the standad rotate_node placement so that it takes into account the side (top/bottom
    --      or left/right) of the face being pointed at
    -- As with the standard rotate_node, sneak can be used to force the perpendicular placement
    --      (wall placement on floor/ceiling, floor/ceiling placement on walls)
    -- Additionally, the aux / sprint / special key can be used to place the node as if from the
    --      opposite side
    --
    -- When placing a node next to one of the same category (e.g. slab to slab or stair to stair),
    --      the default placement (regardless of sneak) is to copy the under node's param2, flipping
    --      if placed above or below it. The aux key disables this behaviour

    local sneak = placer and placer:get_player_control().sneak
    local aux = placer and placer:get_player_control().aux1

    -- Stair categories for what we are placing, and what we are placing against (e.g. "simple",
    --      "slope", "panel" or an empty strings for non-stair nodes)
    local place_cat = unilib.stairs.extract_category(itemstack:get_name())
    local under = pointed_thing.under
    local under_node = core.get_node(under)
    local under_cat = unilib.stairs.extract_category(under_node.name)
    local same_cat = place_cat == under_cat

    -- Standard (floor) facedir, also used for sneak placement against the lower half of the wall
    local p2 = placer and core.dir_to_facedir(placer:get_look_dir()) or 0

    -- Check which face and which quadrant we are interested in
    -- This is used both to check if we're handling parallel placement in the same-category case,
    --      and in general for sneak placement
    local face_pos = core.pointed_thing_to_face_pos(placer, pointed_thing)
    local face_off = vector.subtract(face_pos, under)

    -- We cannot trust face_off to tell us the correct direction if the under node has a
    --      non-standard shape, so use the distance between under and above
    local wallmounted = core.dir_to_wallmounted(vector.subtract(pointed_thing.above, under))

    if same_cat and not aux then

        p2 = under_node.param2
        -- Flip if placing above or below an upright or upside-down node
        -- Notes from moreblocks:
        -- TODO should we also flip when placing next to a side-mounted node?
        if wallmounted < 2 then

            if p2 < 4 then

                p2 = (p2 + 2) % 4
                p2 = ceil_dirmap[p2 + 1]

            elseif p2 > 19 then

                p2 = ceil_dirmap[p2 - 19] - 20
                p2 = (p2 + 2) % 4

            end

        end

    else

        -- For same-cat placement, aux is used to disable param2 copying
        if same_cat then
            aux = not aux
        end

        local remap = nil

        -- Standard placement against the wall
        local use_wallmap = (wallmounted > 1 and not sneak) or (wallmounted < 2 and sneak)

        -- Standard placement against the ceiling, or sneak placement against the upper half of the
        --      wall
        local use_ceilmap = wallmounted == 1 and not sneak
        use_ceilmap = use_ceilmap or (wallmounted > 1 and sneak and face_off.y > 0)

        if use_wallmap then

            local left = (p2 == 0 and face_off.x < 0) or

                (p2 == 1 and face_off.z > 0) or
                (p2 == 2 and face_off.x > 0) or
                (p2 == 3 and face_off.z < 0)

            if aux then
                left = not left
            end

            remap = left and wall_left_dirmap or wall_right_dirmap

        elseif use_ceilmap then

            remap = ceil_dirmap

        end

        if aux then
            p2 = (p2 + 2) % 4
        end

        if remap then
            p2 = remap[p2 + 1]
        end

    end

    return core.item_place(itemstack, placer, pointed_thing, p2)

end

local function rotate_and_place_arch(itemstack, placer, pointed_thing)

    -- Adapted from pkarcs/pkarcs/init.lua

    -- N.B. p1 / p0 are inverted, compared to rotate_and_place()
    local p1 = pointed_thing.under
    local p0 = pointed_thing.above
    local param2 = 0

    if placer then

        local placer_pos = placer:get_pos()
        if placer_pos then
            param2 = core.dir_to_facedir(vector.subtract(p1, placer_pos))
        end

        local finepos = core.pointed_thing_to_face_pos(placer, pointed_thing)
        local fpos = finepos.y % 1

        if p0.y - 1 == p1.y or
                (fpos > 0 and fpos < 0.5) or
                (fpos < -0.5 and fpos > -0.999999999) then

            param2 = param2 + 20
            if param2 == 21 then
                param2 = 23
            elseif param2 == 23 then
                param2 = 21
            end

        end

        -- "num_rot" is number of possible "rotations" (4 = up down left right)
        local num_rot = 4
        local rot = param2 % num_rot
        local wall = math.floor(param2 / num_rot)
        if rot >= 3 then
            rot = 0
        else
            rot = rot + 1
        end

        param2 = (wall * num_rot) + rot

    end

    return core.item_place(itemstack, placer, pointed_thing, param2)

end

local function register_node_stair_variant(full_name, def_table)

    -- Original to unilib
    -- A simplified version of unilib.register_node(), called only by code in this file
    -- We don't update unilib.global.node_convert_table (which does not contain stair nodes), nor do
    --      we register aliases in a standard way
    -- We also don't replace stair nodes from an original mod here; that is handled by the call to
    --      unilib.register_node() for the main node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): Usual definition table for the node

    -- (At the moment this function is a simple wrapper, but that might change later)
    core.register_node(full_name, def_table)

end

---------------------------------------------------------------------------------------------------
-- Stair support functions
---------------------------------------------------------------------------------------------------

function unilib.stairs._prepare_stair(
    full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc, show_flag,
    draw_data_table, optional_table
)
    -- Adapted from stairs/init.lua
    --
    -- Args:
    --      full_name (str): "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --      data_table (table): The table described in unilib.register_stairs()
    --      adj_part_name (str): e.g. "_stair_simple"
    --      adj_full_name (str): e.g. "unilib:stone_ordinary_stair_simple"
    --      adj_desc (str): e.g. "Ordinary Stone (Simple Stair")
    --      show_flag (bool): Set to true if the stair is to be shown in the creative inventory,
    --          false (or nil) if it is to be hidden
    --      draw_data_table (table): Table describing the shape of the stair, in one of two formats
    --          (described below)
    --      optional_table (table): Table of optional key-value pairs, unique to this stair type.
    --          Recognised keys are:
    --              .arch_flag (bool): Set to true for arches, in which special rotate-and-place
    --                  code is needed, ignoring other rotate-and-place settings
    --              .crossbrace_flag (bool): Set to true if the "crossbrace_connectable" group
    --                  should be set, false (or nil) if not
    --              .no_advanced_rotation_flag (bool): Set to true if the stair should not be
    --                  rotated when placed, as it usually would be, false (or nil) if not. Set to
    --                  true in stair types from the plantlife modpack
    --              .slab_flag (bool): Set to true for slabs, false (or nil) for everything else
    --              .slab_img_flag (bool): Set to true for slabs and other suitable stair types for
    --                  which a special list of textures can be used (when available), false (or
    --                  nil) for everything else

    if optional_table == nil then
        optional_table = {}
    end

    -- (Some original nodes provide a special list of textures for slabs and related stairs)
    local source_img_list = {}
    if optional_table.slab_img_flag and data_table.slab_img_list ~= nil then
        source_img_list = data_table.slab_img_list
    else
        source_img_list = def_table.tiles
    end

    local stair_img_list = {}
    if not optional_table.slab_flag then

        -- For non-slabs, set backface culling and world-aligned textures
        for i, img in ipairs(source_img_list) do

            if type(img) == "string" then

                stair_img_list[i] = {
                    name = img,
                    backface_culling = true,
                }

                if not data_table.img_rotate_flag then
                    stair_img_list[i].align_style = "world"
                end

            else

                stair_img_list[i] = table.copy(img)
                if stair_img_list[i].backface_culling == nil then
                    stair_img_list[i].backface_culling = true
                end

                if not data_table.img_rotate_flag and stair_img_list[i].align_style == nil then
                    stair_img_list[i].align_style = "world"
                end

            end

        end

    else

        -- For slabs, set world-aligned textures (but not backface culling)
        for i, img in ipairs(source_img_list) do

            if type(img) == "string" then

                stair_img_list[i] = {
                    name = img,
                }

                if not data_table.img_rotate_flag then
                    stair_img_list[i].align_style = "world"
                end

            else

                stair_img_list[i] = table.copy(img)
                if not data_table.img_rotate_flag and img.align_style == nil then
                    stair_img_list[i].align_style = "world"
                end

            end

        end

    end

    -- Update the original node's groups field
    local adj_group_table = table.copy(def_table.groups)

    adj_group_table.stair = 1
    -- e.g. "stair_slab = 1"
    adj_group_table[string.sub(adj_part_name, 2)] = 1
    -- e.g. "wood_stair_slab = 1"
    if data_table.group_type ~= nil then
        adj_group_table[data_table.group_type .. adj_part_name] = 1
    end

    if not show_flag then
        adj_group_table.not_in_creative_inventory = 1
    else
        adj_group_table.not_in_creative_inventory = nil
    end

    -- (Crossbrace-connecting pillars from castle/castle_masonry)
    if optional_table.crossbrace_flag then
        adj_group_table.crossbrace = 1
    end

    -- Basic check
    warn_if_exists(adj_full_name)

    -- Prepare to register the node (the function is a simplified version of
    --      unilib.register_node() )
    -- Note that the definition table is based on the one in the stairs mod, not the stairsplus or
    --      moreblocks mods (which are slightly different). All unilib stairs use a definition in
    --      this style
    local adj_def_table = {}
    if optional_table.arch_flag then

        adj_def_table = {
            description = adj_desc,
            tiles = stair_img_list,
            groups = adj_group_table,
            sounds = def_table.sounds,

            is_ground_content = false,
            light_source = def_table.light_source,
            paramtype = "light",
            paramtype2 = "facedir",
            sunlight_propagates = def_table.sunlight_propagates,
            use_texture_alpha = def_table.use_texture_alpha,

            on_place = function(itemstack, placer, pointed_thing)

                if pointed_thing.type ~= "node" then
                    return itemstack
                else
                    return rotate_and_place_arch(itemstack, placer, pointed_thing)
                end

            end,
        }

    elseif optional_table.slab_flag then

        adj_def_table = {
            description = adj_desc,
            tiles = stair_img_list,
            groups = adj_group_table,
            sounds = def_table.sounds,

            drawtype = "nodebox",
            is_ground_content = false,
            light_source = def_table.light_source,
            node_box = {
                type = "fixed",
                fixed = draw_data_table,
            },
            paramtype = "light",
            paramtype2 = "facedir",
            sunlight_propagates = def_table.sunlight_propagates,
            use_texture_alpha = def_table.use_texture_alpha,

            on_place = function(itemstack, placer, pointed_thing)

                local under = core.get_node(pointed_thing.under)
                local wield_item = itemstack:get_name()
                local player_name = placer and placer:get_player_name() or ""

                if under and (
                    under.name:find("_stair_slab") or       -- unilib stair nodes
                    under.name:find("stairs:slab") or
                    under.name:find("stairsplus:slab") or
                    under.name:find("moreblocks:slab")
                ) then
                    -- Place slab using under node orientation
                    local dir = core.dir_to_facedir(
                        vector.subtract(pointed_thing.above, pointed_thing.under),
                        true
                    )

                    local p2 = under.param2

                    if p2 >= 20 and dir == 8 then

                        -- Placing a slab on an upside down slab should make it right-side up
                        p2 = p2 - 20

                    elseif p2 <= 3 and dir == 4 then

                        -- Same for the opposite case: slab below normal slab
                        p2 = p2 + 20

                    end

                    -- Else attempt to place node with proper param2
                    core.item_place_node(ItemStack(wield_item), placer, pointed_thing, p2)
                    if not unilib.utils.is_creative(player_name) then
                        itemstack:take_item()
                    end

                    return itemstack

                else

                    if not unilib.setting.advanced_stair_rotation_flag or
                            optional_table.no_advanced_rotation_flag then
                        return rotate_and_place(itemstack, placer, pointed_thing)
                    else
                        return rotate_and_place_advanced(itemstack, placer, pointed_thing)
                    end

                end

            end,
        }

    else

        -- Everything except arches and slabs
        adj_def_table = {
            description = adj_desc,
            tiles = stair_img_list,
            groups = adj_group_table,
            sounds = def_table.sounds,

            is_ground_content = false,
            light_source = def_table.light_source,
            paramtype = "light",
            paramtype2 = "facedir",
            sunlight_propagates = def_table.sunlight_propagates,
            use_texture_alpha = def_table.use_texture_alpha,

            on_place = function(itemstack, placer, pointed_thing)

                if pointed_thing.type ~= "node" then
                    return itemstack
                end

                if not unilib.setting.advanced_stair_rotation_flag or
                        optional_table.no_advanced_rotation_flag then
                    return rotate_and_place(itemstack, placer, pointed_thing)
                else
                    return rotate_and_place_advanced(itemstack, placer, pointed_thing)
                end

            end,
        }

    end

    -- Smooth stone drops cobblestone (etc)
    if unilib.setting.convert_stairs_on_drop_flag and data_table.drop_name ~= nil then
        adj_def_table.drop = data_table.drop_name .. adj_part_name
    end

    -- Light from light sources is reduced by volume, up to half the original
    if def_table.light_source ~= nil and def_table.light_source > 0 then

        if not unilib.setting.reduce_stair_light_flag then

            adj_def_table.light_source = def_table.light_source

        else

            adj_def_table.light_source = def_table.light_source * (
                0.5 + (unilib.global.stair_cost_table[adj_part_name] / 16)
            )

        end

    end

    if def_table.sunlight_propagates ~= nil then
        adj_def_table.sunlight_propagates = def_table.sunlight_propogates
    end

    -- Apply the moreblocks fix for glass stairs that are difficult to see (if required)
    if data_table.glass_flag and #adj_def_table.tiles > 1 then
        adj_def_table.tiles = {def_table.tiles[1]}
    end

    if not optional_table.slab_flag then

        -- For non-slab nodes, draw_data_table contains either this:
        --      {
        --          node_box = {
        --              type = "fixed",
        --              fixed = FIXED_TABLE,
        --          },
        --      }
        -- ...or this:
        --      {
        --          mesh = "moreblocks_slope_cut.obj",
        --          collision_box = FIXED_TABLE,
        --          selection_box = FIXED_TABLE,
        --      }
        if draw_data_table["node_box"] ~= nil then

            adj_def_table.drawtype = "nodebox"
            adj_def_table.node_box = draw_data_table.node_box

        else

            adj_def_table.drawtype = "mesh"
            for k, v in pairs(draw_data_table) do
                adj_def_table[k] = v
            end

        end

    end

    -- Register the node
    register_node_stair_variant(adj_full_name, adj_def_table)
    -- Update global variables
    unilib.global.stair_deconvert_table[adj_full_name] = full_name
    if unilib.global.stair_convert_table[full_name] == nil then
        unilib.global.stair_convert_table[full_name] = {adj_full_name}
    else
        table.insert(unilib.global.stair_convert_table[full_name], adj_full_name)
    end

end

function unilib.stairs._create_fuel_recipe(full_name, adj_full_name, factor)

    -- Adapted from stairs/init.lua

    local base_burn_time = core.get_craft_result({
        method = "fuel",
        width = 1,
        items = {full_name}
    }).time

    if base_burn_time > 0 then

        unilib.register_craft({
            type = "fuel",
            recipe = adj_full_name,
            burntime = math.floor(base_burn_time * factor),
        })

    end

end

function unilib.stairs._create_cook_recipe(ingredient_name, cooked_name, stair_name)

    -- Adapted from stairsplus/init.lua

    -- If "cooked_name" is not nil, then it is the smooth stone (or similar node) corresponding to
    --      the cobblestone (or similar node) "ingredient_name"
    -- "stair_name" is added to the end of both names to create a stair node, e.g. "_stair_simple"

    if cooked_name ~= nil then

        unilib.register_craft({
            type = "cooking",
            output = cooked_name .. stair_name,
            recipe = ingredient_name .. stair_name,
        })

    end

end
