---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- register.lua
--      Set up shared functions for registering things, replacing Minetest registration calls
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function is_registered(orig_name)

    -- Original to unilib
    -- Called to check whether a node/craftitem/recipe from another mod has actually been
    --      registered, before the code below tries to unregister/hide it

    if minetest.registered_nodes[orig_name] ~= nil or
            minetest.registered_craftitems[orig_name] ~= nil or
            minetest.registered_tools[orig_name] ~= nil then
        return true
    else
        return false
    end

end

local function unregister_stairs_carvings(orig_name)

    -- Original to unilib
    -- Called by the hide_item() and replace_item() functions above (only)
    -- Note that original wall nodes are unregistered by code in ../lib/shared/walls.lua

    local item_name = unilib.get_item_name(orig_name)
    local unreg_list = {}

    if minetest.get_modpath("stairs") then

        -- If the first one is registered, it's safe to assume the others are too
        if is_registered("stairs:stair_" .. item_name) then

            table.insert(unreg_list, "stairs:stair_" .. item_name)
            table.insert(unreg_list, "stairs:stair_inner_" .. item_name)
            table.insert(unreg_list, "stairs:stair_outer_" .. item_name)
            table.insert(unreg_list, "stairs:slab_" .. item_name)

        end

        -- The stairs_redo mod shares the same modpath
        if is_registered("stairs:slope_" .. item_name) then

            table.insert(unreg_list, "stairs:slope_" .. item_name)
            table.insert(unreg_list, "stairs:slope_inner_" .. item_name)
            table.insert(unreg_list, "stairs:slipe_outer_" .. item_name)

        end

    end

    if minetest.get_modpath("stairsplus") and
            is_registered("stairsplus:stair_" .. item_name .. "_inverted") then

        table.insert(unreg_list, "stairsplus:stair_" .. item_name)
        table.insert(unreg_list, "stairsplus:corner_" .. item_name .. "_inner")
        table.insert(unreg_list, "stairsplus:corner_" .. item_name .. "_outer")
        table.insert(unreg_list, "stairsplus:slab_" .. item_name)

        table.insert(unreg_list, "stairsplus:stair_" .. item_name .. "_inverted")
        table.insert(unreg_list, "stairsplus:stair_" .. item_name .. "_half")
        table.insert(unreg_list, "stairsplus:stair_" .. item_name .. "_half_inverted")
        table.insert(unreg_list, "stairsplus:stair_" .. item_name .. "_right_half")
        table.insert(unreg_list, "stairsplus:stair_" .. item_name .. "_right_half_inverted")

        table.insert(unreg_list, "stairsplus:corner_" .. item_name)
        table.insert(unreg_list, "stairsplus:corner_" .. item_name .. "_half")
        table.insert(unreg_list, "stairsplus:corner_" .. item_name .. "_half_inverted")
        table.insert(unreg_list, "stairsplus:corner_" .. item_name .. "_inner_inverted")
        table.insert(unreg_list, "stairsplus:corner_" .. item_name .. "_outer_inverted")

        table.insert(unreg_list, "stairsplus:slab_" .. item_name .. "_inverted")
        table.insert(unreg_list, "stairsplus:slab_" .. item_name .. "_quarter")
        table.insert(unreg_list, "stairsplus:slab_" .. item_name .. "_quarter_inverted")
        table.insert(unreg_list, "stairsplus:slab_" .. item_name .. "_three_quarter")
        table.insert(unreg_list, "stairsplus:slab_" .. item_name .. "_three_quarter_inverted")

        table.insert(unreg_list, "stairsplus:wall_" .. item_name)
        table.insert(unreg_list, "stairsplus:wall_" .. item_name .. "_quarter")
        table.insert(unreg_list, "stairsplus:wall_" .. item_name .. "_three_quarter")

        table.insert(unreg_list, "stairsplus:panel_" .. item_name .. "_bottom")
        table.insert(unreg_list, "stairsplus:panel_" .. item_name .. "_top")
        table.insert(unreg_list, "stairsplus:panel_" .. item_name .. "_vertical")

        table.insert(unreg_list, "stairsplus:micro_" .. item_name .. "_bottom")
        table.insert(unreg_list, "stairsplus:micro_" .. item_name .. "_top")


    end

    if minetest.get_modpath("moreblocks") and
            is_registered("stairsplus:micro_" .. item_name .. "_1") then

        table.insert(unreg_list, "stairsplus:stair_" .. item_name)
        table.insert(unreg_list, "stairsplus:stair_" .. item_name .. "_inner")
        table.insert(unreg_list, "stairsplus:stair_" .. item_name .. "_outer")

        table.insert(unreg_list, "stairsplus:slab_" .. item_name)
        table.insert(unreg_list, "stairsplus:slab_" .. item_name .. "_1")
        table.insert(unreg_list, "stairsplus:slab_" .. item_name .. "_2")
        table.insert(unreg_list, "stairsplus:slab_" .. item_name .. "_quarter")
        table.insert(unreg_list, "stairsplus:slab_" .. item_name .. "_three_quarter")
        table.insert(unreg_list, "stairsplus:slab_" .. item_name .. "_14")
        table.insert(unreg_list, "stairsplus:slab_" .. item_name .. "_15")
        table.insert(unreg_list, "stairsplus:slab_" .. item_name .. "_two_sides")
        table.insert(unreg_list, "stairsplus:slab_" .. item_name .. "_three_sides")
        table.insert(unreg_list, "stairsplus:slab_" .. item_name .. "_three_sides_u")

        table.insert(unreg_list, "stairsplus:stair_" .. item_name .. "_half")
        table.insert(unreg_list, "stairsplus:stair_" .. item_name .. "_right_half")

        table.insert(unreg_list, "stairsplus:panel_" .. item_name)
        table.insert(unreg_list, "stairsplus:panel_" .. item_name .. "_1")
        table.insert(unreg_list, "stairsplus:panel_" .. item_name .. "_2")
        table.insert(unreg_list, "stairsplus:panel_" .. item_name .. "_4")
        table.insert(unreg_list, "stairsplus:panel_" .. item_name .. "_12")
        table.insert(unreg_list, "stairsplus:panel_" .. item_name .. "_14")
        table.insert(unreg_list, "stairsplus:panel_" .. item_name .. "_15")

        table.insert(unreg_list, "stairsplus:micro_" .. item_name)
        table.insert(unreg_list, "stairsplus:micro_" .. item_name .. "_1")
        table.insert(unreg_list, "stairsplus:micro_" .. item_name .. "_2")
        table.insert(unreg_list, "stairsplus:micro_" .. item_name .. "_4")
        table.insert(unreg_list, "stairsplus:micro_" .. item_name .. "_12")
        table.insert(unreg_list, "stairsplus:micro_" .. item_name .. "_14")
        table.insert(unreg_list, "stairsplus:micro_" .. item_name .. "_15")

        table.insert(unreg_list, "stairsplus:slope_" .. item_name)
        table.insert(unreg_list, "stairsplus:slope_" .. item_name .. "_half")
        table.insert(unreg_list, "stairsplus:slope_" .. item_name .. "_half_raised")
        table.insert(unreg_list, "stairsplus:slope_" .. item_name .. "_inner")
        table.insert(unreg_list, "stairsplus:slope_" .. item_name .. "_inner_half")
        table.insert(unreg_list, "stairsplus:slope_" .. item_name .. "_inner_half_raised")
        table.insert(unreg_list, "stairsplus:slope_" .. item_name .. "_inner_cut")
        table.insert(unreg_list, "stairsplus:slope_" .. item_name .. "_inner_cut_half")
        table.insert(unreg_list, "stairsplus:slope_" .. item_name .. "_inner_cut_half_raised")
        table.insert(unreg_list, "stairsplus:slope_" .. item_name .. "_outer")
        table.insert(unreg_list, "stairsplus:slope_" .. item_name .. "_outer_half")
        table.insert(unreg_list, "stairsplus:slope_" .. item_name .. "_outer_half_raised")
        table.insert(unreg_list, "stairsplus:slope_" .. item_name .. "_outer_cut")
        table.insert(unreg_list, "stairsplus:slope_" .. item_name .. "_outer_cut_half_raised")
        table.insert(unreg_list, "stairsplus:slope_" .. item_name .. "_cut")
        table.insert(unreg_list, "stairsplus:slope_" .. item_name .. "_alt")
        table.insert(unreg_list, "stairsplus:slope_" .. item_name .. "_alt_1")
        table.insert(unreg_list, "stairsplus:slope_" .. item_name .. "_alt_2")
        table.insert(unreg_list, "stairsplus:slope_" .. item_name .. "_alt_4")

    end

    if minetest.get_modpath("columnia") and
            is_registered("columnia:column_mid_" .. item_name) then

        table.insert(unreg_list, "columnia:column_mid_" .. item_name)
        table.insert(unreg_list, "columnia:column_top_" .. item_name)
        table.insert(unreg_list, "columnia:column_bottom_" .. item_name)
        table.insert(unreg_list, "columnia:column_crosslink_" .. item_name)
        table.insert(unreg_list, "columnia:column_link_" .. item_name)
        table.insert(unreg_list, "columnia:column_linkdown_" .. item_name)

    end

    if minetest.get_modpath("facade") and
            is_registered("facade:" .. item_name .. "_bannerstone") then

        table.insert(unreg_list, "facade:" .. item_name .. "_bannerstone")
        table.insert(unreg_list, "facade:" .. item_name .. "_bannerstone_corner")
        table.insert(unreg_list, "facade:" .. item_name .. "_centerstone")
        table.insert(unreg_list, "facade:" .. item_name .. "_column")
        table.insert(unreg_list, "facade:" .. item_name .. "_column_corner")
        table.insert(unreg_list, "facade:" .. item_name .. "_corbel")
        table.insert(unreg_list, "facade:" .. item_name .. "_corbel_corner")
        table.insert(unreg_list, "facade:" .. item_name .. "_corbel_corner_inner")
        table.insert(unreg_list, "facade:" .. item_name .. "_carved_stone_a")
        table.insert(unreg_list, "facade:" .. item_name .. "_carved_stone_a_corner")
        table.insert(unreg_list, "facade:" .. item_name .. "_rgspro")
        table.insert(unreg_list, "facade:" .. item_name .. "_rgspro_inner_corner")
        table.insert(unreg_list, "facade:" .. item_name .. "_rgspro_outer_corner")
        table.insert(unreg_list, "facade:" .. item_name .. "_corner_bricks")
        -- (Imported from columnia)
        table.insert(unreg_list, "facade:" .. item_name .. "_columnia_mid")
        table.insert(unreg_list, "facade:" .. item_name .. "_columnia_bottom")
        table.insert(unreg_list, "facade:" .. item_name .. "_columnia_top")
        table.insert(unreg_list, "facade:" .. item_name .. "_columnia_crosslink")
        table.insert(unreg_list, "facade:" .. item_name .. "_columnia_link")
        table.insert(unreg_list, "facade:" .. item_name .. "_columnia_linkdown")

    end

    -- N.B. The mymillwork mod converts a node like "default:stonebrick" into a carving like
    --      "mymillwork:ceiling_default_stone_brick"
    -- As the naming of the carvings is arbitrary, this function does not try to unregister them

    -- Unregister stairs and carvings
    for _, stair_name in ipairs(unreg_list) do

        if is_registered(stair_name) then
            minetest.unregister_item(stair_name)
        end

    end

end

local function hide_item(full_name, orig_name_list)

    -- Original to unilib
    -- Deal with items from an original mod, for which the replace_mode is "hide"
    --
    -- Certain items might cause a crash when they are unregistered (for example,
    --      flowers:mushroom_brown from minetest_game)
    -- In that case, the calling package might specify "hide", overriding the replace_mode for the
    --      original mod
    --
    -- Unlike in replace_item() below, we don't unregister the item. Instead, we mark it as hidden
    --      (in unilib's registry), and give it the "not_in_creative_inventory" group so the
    --      player can't see it
    -- Unlike in replace_item() below, we don't call minetest.register_alias_force() to map the
    --      old item onto the new one, as that tends to cause a crash

    for _, orig_name in ipairs(orig_name_list) do

        if is_registered(orig_name) then

            local group_table = {}

            if minetest.registered_nodes[orig_name] ~= nil then
                group_table = table.copy(minetest.registered_nodes[orig_name]["groups"])
            elseif minetest.registered_craftitems[orig_name] ~= nil then
                group_table = table.copy(minetest.registered_craftitems[orig_name]["groups"])
            elseif minetest.registered_tools[orig_name] ~= nil then
                group_table = table.copy(minetest.registered_tools[orig_name]["groups"])
            end

            group_table.not_in_creative_inventory = 1

            unilib.override_item(orig_name, {groups = group_table})
            -- Update the unilib registry, so hidden items can be displayed by chat commands
            unilib.hidden_item_table[orig_name] = full_name

            -- Even though the node is merely hidden, any variations created by stairs/carvings mods
            --      can still be unregistered
            unregister_stairs_carvings(orig_name)

            -- Unregister any craft recipes, for which the output is "orig_name"
            -- N.B. The table's field is nil if no craft recipes have been registered
            local t = minetest.get_craft_recipe(orig_name)
            if t.items ~= nil then
                minetest.clear_craft({output = orig_name})
            end


        end

    end

end

local function replace_item(full_name, orig_name_list)

    -- Original to unilib
    -- Deal with items from an original mod, for which the replace_mode is "replace"
    -- Unregister the item with Minetest

    for _, orig_name in ipairs(orig_name_list) do

        if is_registered(orig_name) then

            minetest.unregister_item(orig_name)

            -- Unregister any variants created by stairs/carvings mods
            unregister_stairs_carvings(orig_name)

            -- Map the old item onto the new one, so that other mods can use the new (unilib) item
            --      in their craft recipes
            minetest.register_alias(orig_name, full_name)

            -- Unregister any craft recipes, for which the output is "orig_name"
            -- N.B. The table's field is nil if no craft recipes have been registered
            local t = minetest.get_craft_recipe(orig_name)
            if t.items ~= nil then
                minetest.clear_craft({output = orig_name})
            end

        end

    end

end

local function parse_spread(spread)

    -- Called by unilib.register_ore_from_csv() to parse a string in the form
    --      "x = 100, y = 100, z = 100", returning a table in the form {x = n, y = n, z = n}
    -- Everything but the first three numbers are ignored, so the x-y-z order must be preserved,
    --      but the non-numeric characters are irrelevant ("a = 100 b = 100 c = 100" would work just
    --      as well)
    -- If three numbers can be extracted, return nil (not an empty table)

    if spread ~= nil and spread ~= "" then

        for x, y, z in (spread):gmatch("(%d+)%D*(%d+)%D*(%d+)") do
            return {x = x, y = y, z = z}
        end

    end

    return nil

end

local function parse_clust_scarcity(clust_scarcity)

    -- Called by unilib.register_ore_from_csv() to parse a string in the form "n * n * n", but
    --      which might also be a string in the form "n"
    -- Everything but the first three numbers are ignored ("5 times 5 times 5" would work just as
    --      well)
    -- Returns a single number (the result of the multiplication, or the single specified number);
    --      or nil if the argument is not in either of those formats

    if clust_scarcity ~= nil and clust_scarcity ~= "" then

        for a, b, c in (clust_scarcity):gmatch("(%d+)%D*(%d+)%D*(%d+)") do
            return tonumber(a) * tonumber(b) * tonumber(c)
        end

    end

    return tonumber(clust_scarcity)

end

local function parse_flags(flags)

    -- Called by unilib.register_decoration_from_csv() and unilib.register_ore_from_csv() to parse
    --      a whitespace-separated string in the form "place_center_x place_center_z" (etc) into a
    --      comma-separated string in the from "place_center_x, place_center_z"

    if flags ~= nil and flags ~= "" then

        if string.find(flags, ",") then

            -- If unilib's CSV separator is not a comma, then commas may be used in the field
            --      (although that is not recommended)
            return flags

        else

            return table.concat(
                unilib.split_string_by_whitespace(flags, true), ", "
            )

        end

    end

    return nil

end

---------------------------------------------------------------------------------------------------
-- Node/craftitem/tool registration
---------------------------------------------------------------------------------------------------

function unilib.register_node(full_name, orig_name, replace_mode, def_table)

    -- Original to unilib
    -- Packages should call this function to register a node, rather than calling
    --      minetest.register_node() directly
    -- There is one exception: when creating an item that uses multiple nodes (such as a door), this
    --      function should only be called to register the item that appears in the player's
    --      inventory; the supplementary items should be registered with minetest.register_node()
    --      as usual
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      orig_name (nil, str or list): e.g. "default:stone"
    --      replace_mode (str): "add", "defer", "replace" or "hide"
    --      def_table (table): Usual definition table for the node
    --
    -- Return values:
    --      The specified full_name

    -- Standard argument check (in case the package writer has forgotten to add "orig_name" and
    --      "replace_mode")
    if def_table == nil then

        -- If the user has supplied arguments in the format expected by minetest.register_node(),
        --      then we can still register this node
        if type(orig_name) == "table" then

            unilib.show_warning(
                "unilib.register_node(): Invalid arguments, recovering node definition table",
                full_name
            )

            def_table = table.copy(orig_name)
            orig_name = ""
            replace_mode = unilib.default_replace_mode

        else

            unilib.show_error("unilib.register_node(): Invalid arguments, ignoring node", full_name)
            return

        end

    elseif minetest.registered_nodes[full_name] ~= nil then

        unilib.show_warning(
            "unilib.register_node(): Duplicate node registration",
            full_name
        )

    end

    -- "orig_name" can be nil, a string or a list. Convert to a list, and register the relationship
    --      between the old and new nodes
    local orig_name_list = unilib.convert_to_list(orig_name)

    unilib.node_deconvert_table[full_name] = orig_name_list
    for _, this_orig_name in ipairs(orig_name_list) do
        unilib.node_convert_table[this_orig_name] = full_name
    end

    -- Register the node with Minetest
    minetest.register_node(full_name, def_table)

    -- Handle nodes that must be replaced/hidden
    if replace_mode == "hide" then
        hide_item(full_name, orig_name_list)
    elseif replace_mode == "replace" then
        replace_item(full_name, orig_name_list)
    end

    -- Register minetest aliases for each node in a standard way
    for mod_name, item_name in string.gmatch(full_name, "([%w_]+):([%w_]+)") do
        minetest.register_alias(item_name, full_name)
    end

    -- Update global variables
    if unilib.current_pkg ~= nil then
        unilib.node_parent_table[full_name] = unilib.current_pkg
    end

    -- (The original calling function might need this for its craft recipes)
    return full_name

end

function unilib.register_node_stair_variant(full_name, def_table)

    -- Original to unilib
    -- A simplified version of unilib.register_node(), called only by code in
    --      ../lib/shared/stairs.lua
    -- We don't update unilib.node_convert_table (which does not contain stair nodes), nor do we
    --      register aliases in a standard way
    -- We also don't replace stair nodes from an original mod here; that is handled by the call to
    --      unilib.register_node() for the main node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): Usual definition table for the node

    -- (At the moment this function is a simple wrapper, but that might change later)
    minetest.register_node(full_name, def_table)

end

function unilib.register_node_carving_variant(full_name, def_table)

    -- Original to unilib
    -- A simplified version of unilib.register_node(), called only by code in
    --      ../lib/shared/carvings.lua
    -- We don't update unilib.node_convert_table (which does not contain carving nodes), nor do we
    --      register aliases in a standard way
    -- We also don't replace carving nodes from an original mod here; that is handled by the call to
    --      unilib.register_node() for the main node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): Usual definition table for the node

    -- (At the moment this function is a simple wrapper, but that might change later)
    minetest.register_node(full_name, def_table)

end

function unilib.register_craftitem(full_name, orig_name, replace_mode, def_table)

    -- Original to unilib
    -- Packages should call this function to register a craftitem, rather than calling
    --      minetest.register_craftitem() directly
    --
    -- Args:
    --      full_name (str): e.g. "unilib:mineral_coal_lump"
    --      orig_name (nil, str or list): e.g. "default:coal_lump"
    --      replace_mode (str): "add", "defer", "replace" or "hide"
    --      def_table (table): Usual definition table for the craftitem
    --
    -- Return values:
    --      The specified full_name

    -- Standard argument check (in case the package writer has forgotten to add "orig_name" and
    --      "replace_mode")
    if def_table == nil then

        -- If the user has supplied arguments in the format expected by
        --      minetest.register_craftitem(), then we can still register this craftitem
        if type(orig_name) == "table" then

            unilib.show_warning(
                "unilib.register_craftitem(): Invalid arguments, recovering craftitem definition" ..
                        " table",
                full_name
            )

            def_table = table.copy(orig_name)
            orig_name = ""
            replace_mode = unilib.default_replace_mode

        else

            unilib.show_error(
                "unilib.register_craftitem(): Invalid arguments, ignoring craftitem", full_name
            )

            return

        end

    elseif minetest.registered_craftitems[full_name] ~= nil then

        unilib.show_warning(
            "unilib.register_craftitem(): Duplicate craftitem registration",
            full_name
        )

    end

    -- "orig_name" can be nil, a string or a list. Convert to a list, and register the relationship
    --      between the old and new craftitems
    local orig_name_list = unilib.convert_to_list(orig_name)

    unilib.craftitem_deconvert_table[full_name] = orig_name_list
    for _, this_orig_name in ipairs(orig_name_list) do
        unilib.craftitem_convert_table[this_orig_name] = full_name
    end

    -- Register the craftitem with Minetest
    minetest.register_craftitem(full_name, def_table)

    -- Handle craftitems that must be replaced/hidden
    if replace_mode == "hide" then
        hide_item(full_name, orig_name_list)
    elseif replace_mode == "replace" then
        replace_item(full_name, orig_name_list)
    end

    -- Register minetest aliases for each craftitem in a standard way
    for mod_name, item_name in string.gmatch(full_name, "([%w_]+):([%w_]+)") do
        minetest.register_alias(item_name, full_name)
    end

    -- Update global variables
    if unilib.current_pkg ~= nil then
        unilib.craftitem_parent_table[full_name] = unilib.current_pkg
    end

    -- (The original calling function might need this for its craft recipes)
    return full_name

end

function unilib.register_tool(full_name, orig_name, replace_mode, def_table)

    -- Original to unilib
    -- Packages should call this function to register a tool, rather than calling
    --      minetest.register_tool() directly
    --
    -- Args:
    --      full_name (str): e.g. "unilib:tool_pick_steel"
    --      orig_name (nil, str or list): e.g. "default:pick_steel"
    --      replace_mode (str): "add", "defer", "replace" or "hide"
    --      def_table (table): Usual definition table for the tool
    --
    -- Return values:
    --      The specified full_name

    -- Standard argument check (in case the package writer has forgotten to add "orig_name" and
    --      "replace_mode")
    if def_table == nil then

        -- If the user has supplied arguments in the format expected by minetest.register_node(),
        --      then we can still register this node
        if type(orig_name) == "table" then

            unilib.show_warning(
                "unilib.register_tool(): Invalid arguments, recovering tool definition table",
                full_name
            )

            def_table = table.copy(orig_name)
            orig_name = ""
            replace_mode = unilib.default_replace_mode

        else

            unilib.show_error("unilib.register_tool(): Invalid arguments, ignoring tool", full_name)
            return

        end

    elseif minetest.registered_nodes[full_name] ~= nil then

        unilib.show_warning(
            "unilib.register_tool(): Duplicate tool registration",
            full_name
        )

    end

    -- "orig_name" can be nil, a string or a list. Convert to a list, and register the relationship
    --      between the old and new nodes
    local orig_name_list = unilib.convert_to_list(orig_name)

    unilib.tool_deconvert_table[full_name] = orig_name_list
    for _, this_orig_name in ipairs(orig_name_list) do
        unilib.tool_convert_table[this_orig_name] = full_name
    end

    -- Register the tool with Minetest
    minetest.register_tool(full_name, def_table)

    -- Handle tools that must be replaced/hidden
    if replace_mode == "hide" then
        hide_item(full_name, orig_name_list)
    elseif replace_mode == "replace" then
        replace_item(full_name, orig_name_list)
    end

    -- Register minetest aliases for each tool in a standard way
    for mod_name, item_name in string.gmatch(full_name, "([%w_]+):([%w_]+)") do
        minetest.register_alias(item_name, full_name)
    end

    -- Update global variables
    if unilib.current_pkg ~= nil then
        unilib.tool_parent_table[full_name] = unilib.current_pkg
    end

    -- (The original calling function might need this for its craft recipes)
    return full_name

end

function unilib.override_item(full_name, def_table)

    -- A wrapper for minetest.override_item()
    -- If the item to be overriden does not exist (typically because a package was not loaded,
    --      because its replace_mode was "defer"), then Minetest will crash
    -- So we must check the item exists, before overriding it

    if minetest.registered_items[full_name] == nil then
        unilib.show_warning("unilib.override_item(): Cannot override non-existent item", full_name)
    else
        minetest.override_item(full_name, def_table)
    end

end

---------------------------------------------------------------------------------------------------
-- Node/craftitem/tool upgrades
---------------------------------------------------------------------------------------------------

function unilib.upgrade_node(full_name, orig_name, def_table)

    -- Original to unilib
    -- Upgrades an existing unilib node. For example, the technic mod upgrades the steel block from
    --      minetest_game to a wrought iron block, updating the description/textures, but
    --      preserving the original "full_name" (i.e. unilib:metal_steel_block)
    -- A call to this function does the same thing, upgrading one unilib node into another
    --
    -- Args:
    --      full_name (str): e.g. "unilib:metal_steel_block"
    --      orig_name (nil, str or list): Original name(s) of the upgraded node(s), e.g.
    --          "technic:wrought_iron_block"
    --      def_table (table): Partial definition table for the upgraded node; any fields replace
    --          those in the original node definition
    --
    -- Return values:
    --      The specified full_name

    -- Upgrade the node
    unilib.override_item(full_name, def_table)

    -- "orig_name" can be nil, a string or a list. Convert to a list, and register the relationship
    --      between the old and new nodes
    local orig_name_list = unilib.convert_to_list(orig_name)
    for _, this_orig_name in ipairs(orig_name_list) do

        minetest.register_alias(this_orig_name, full_name)
        unilib.node_convert_table[this_orig_name] = full_name

    end

    -- (The original calling function might need this for its craft recipes)
    return full_name

end

function unilib.upgrade_craftitem(full_name, orig_name, def_table)

    -- Original to unilib
    -- Upgrades an existing unilib craftitem. For example, the technic mod upgrades the steel ingot
    --      from minetest_game to a wrought iron ingot, updating the description/textures, but
    --      preserving the original "full_name" (i.e. unilib:metal_steel_ingot)
    -- A call to this function does the same thing, upgrading one unilib craftitem into another
    --
    -- Args:
    --      full_name (str): e.g. "unilib:metal_steel_ingot"
    --      orig_name (nil, str or list): Original name(s) of the upgraded craftitem(s), e.g.
    --          "technic:wrought_iron_ingot"
    --      def_table (table): Partial definition table for the upgraded craftitem; any fields
    --          replace those in the original craftitem definition
    --
    -- Return values:
    --      The specified full_name

    -- Upgrade the craftitem
    unilib.override_item(full_name, def_table)

    -- "orig_name" can be nil, a string or a list. Convert to a list, and register the relationship
    --      between the old and new craftitems
    local orig_name_list = unilib.convert_to_list(orig_name)
    for _, this_orig_name in ipairs(orig_name_list) do

        minetest.register_alias(this_orig_name, full_name)
        unilib.craftitem_convert_table[this_orig_name] = full_name

    end

    -- (The original calling function might need this for its craft recipes)
    return full_name

end

---------------------------------------------------------------------------------------------------
-- Craft recipe registration
---------------------------------------------------------------------------------------------------

function unilib.register_craft(def_table)

    -- Original to unilib
    -- Packages should call this function to register a craft recipe, rather than calling
    --      minetest.register_craft() directly
    -- For common crafting recipes, one of the functions immediately below can be called instead
    --
    -- Args:
    --      def_table (table): Usual definition table for the craft

    -- (At the moment this function is a simple wrapper, but that might change later)
    minetest.register_craft(def_table)

end

function unilib.register_craft_2x2(data_table)

    -- Original to unilib
    -- A convenience function for crafting recipes that use a 2x2 grid with an output of 1 item
    --
    -- data_table compulsory fields:
    --      data_table.output (str): e.g. "unilib:stone_ordinary_brick"
    --      data_table.ingredient (str): e.g. "unilib:stone_ordinary"

    local output = data_table.output
    local ingredient = data_table.ingredient

    minetest.register_craft({
        output = output,
        recipe = {
            {ingredient, ingredient},
            {ingredient, ingredient},
        },
    })

end

function unilib.register_craft_2x2x4(data_table)

    -- Original to unilib
    -- A convenience function for crafting recipes that use a 2x2 grid with an output of 4 items
    --
    -- data_table compulsory fields:
    --      data_table.output (str): e.g. "unilib:stone_ordinary_brick"
    --      data_table.ingredient (str): e.g. "unilib:stone_ordinary"

    local output = data_table.output
    local ingredient = data_table.ingredient

    -- (Inevitably we'll sometimes forget to remove the multiple from the arguments)
    if string.find(output, " 4$") then

        unilib.show_error(
            "unilib.register_craft_2x2x4(): Duplicate multiple in craft recipe",
            output,
            ingredient
        )

    else

        minetest.register_craft({
            output = output .. " 4",
            recipe = {
                {ingredient, ingredient},
                {ingredient, ingredient},
            },
        })

    end

end

function unilib.register_craft_3x3(data_table)

    -- Original to unilib
    -- A convenience function for crafting recipes that use a 3x3 grid with an output of 1 item
    --
    -- data_table compulsory fields:
    --      data_table.output (str): e.g. "unilib:stone_ordinary_brick"
    --      data_table.ingredient (str): e.g. "unilib:stone_ordinary"

    local output = data_table.output
    local ingredient = data_table.ingredient

    minetest.register_craft({
        output = output,
        recipe = {
            {ingredient, ingredient, ingredient},
            {ingredient, ingredient, ingredient},
            {ingredient, ingredient, ingredient},
        },
    })

end

function unilib.register_craft_3x3x9(data_table)

    -- Original to unilib
    -- A convenience function for crafting recipes that use a 3x3 grid with an output of 9 items
    --
    -- data_table compulsory fields:
    --      data_table.output - e.g. "unilib:stone_ordinary_brick"
    --      data_table.ingredient - e.g. "unilib:stone_ordinary"

    local output = data_table.output
    local ingredient = data_table.ingredient

    -- (Inevitably we'll sometimes forget to remove the multiple from the arguments)
    if string.find(output, " 9$") then

        unilib.show_error(
            "unilib.register_craft_3x3x9(): Duplicate multiple in craft recipe",
            output,
            ingredient
        )

    else

        minetest.register_craft({
            output = output .. " 9",
            recipe = {
                {ingredient, ingredient, ingredient},
                {ingredient, ingredient, ingredient},
                {ingredient, ingredient, ingredient},
            },
        })

    end

end

function unilib.register_craft_metadata_copy(ingredient, output)

    -- Adapted from default/functions.lua
    -- In the original mod, used to copy metadata from ordinary books to books with writing
    -- Used for that purpose in unilib (but available to other code, as required)
    --
    -- Args:
    --      ingredient (str): e.g. "unilib:item_book_ordinary"
    --      output (str): e.g. "unilib:item_book_ordinary_written"

    unilib.register_craft({
        type = "shapeless",
        output = output,
        recipe = {ingredient, output}
    })

    minetest.register_on_craft(function(itemstack, player, old_craft_grid, craft_inv)

        if itemstack:get_name() ~= output then
            return
        end

        local original
        local index
        for i = 1, #old_craft_grid do

            if old_craft_grid[i]:get_name() == output then

                original = old_craft_grid[i]
                index = i

            end

        end

        if not original then
            return
        end

        local copymeta = original:get_meta():to_table()
        itemstack:get_meta():from_table(copymeta)
        -- Put the book with metadata back in the craft grid
        craft_inv:set_stack("craft", index, original)

    end)

end

function unilib.register_external_ingredient(full_name, ingredient)

    -- Original to unilib
    -- Some packages have craft recipes that require items from other mods, but we can't say in
    --      advance which mods will supply those items. These typically include meat, milk and eggs
    --      used as ingredients for food items
    -- Ideally, such craft recipes should use "group:food_egg", rather than an actual item name like
    --      "mobs:egg", so that all mods providing eggs can be used as ingredients
    -- Affected packages should call this function, which updates a global variable. The player can
    --      then use the chat command /check_ingredients, once the game has started, to check that
    --      the external ingredients are actually available
    -- (We don't check external ingredients directly, so that the user isn't forced to add all
    --      possible external mods to unilib's mod.conf)
    --
    -- Args:
    --      full_name (str): e.g. "unilib:food_cake_jaffa"
    --      ingredient (str or list): e.g. {"group:food_egg", "group:food_milk"}

    local ingredient_list = unilib.convert_to_list(ingredient)
    unilib.external_ingredient_table[full_name] = ingredient_list

end

function unilib.register_craft_conflicts(pair_list)

    -- Original to unilib
    -- Updates unilib.craft_recipe_conflict_list
    -- "pair_list" consists of one or more mini-lists in the form
    --  { ... {"unilib:item_stick_ordinary 4", "unilib:material_charcoal_artificial_lump 8"} ... }

    for _, mini_list in ipairs(pair_list) do
        table.insert(unilib.craft_recipe_conflict_list, mini_list)
    end

end

function unilib.register_craft_missing_ingredients(pair_list)

    -- Original to unilib
    -- Updates unilib.craft_recipe_conflict_list
    -- "pair_list" consists of one or more mini-lists in the form
    -- { ... {"unilib:item_stick_ordinary 4", "unilib:material_charcoal_artificial_lump 8"} ... }

    for _, mini_list in ipairs(pair_list) do
        table.insert(unilib.craft_recipe_conflict_list, mini_list)
    end

end

---------------------------------------------------------------------------------------------------
-- Entity/ABM/LBM/schematic registration
---------------------------------------------------------------------------------------------------

function unilib.register_entity(entity_name, def_table)

    -- Original to unilib
    -- Packages should call this function to register an entity, rather than calling
    --      minetest.register_entity() directly
    --
    -- Args:
    --      entity_name (str): e.g. "unilib:cart_ordinary"
    --      def_table (table): Usual definition table for the entity

    if minetest.registered_entities[entity_name] ~= nil then

        unilib.show_warning(
            "unilib.register_entity(): Duplicate entity registration",
            entity_name
        )

    end

    -- (At the moment this function is a simple wrapper, but that might change later)
    minetest.register_entity(entity_name, def_table)

end

function unilib.register_abm(def_table)

    -- Original to unilib
    -- Packages should call this function to register an ABM, rather than calling
    --      minetest.register_abm() directly
    --
    -- Args:
    --      def_table (table): Usual definition table for the ABM

    -- (At the moment this function is a simple wrapper, but that might change later)
    minetest.register_abm(def_table)

end

function unilib.register_lbm(def_table)

    -- Original to unilib
    -- Packages should call this function to register an LBM, rather than calling
    --      minetest.register_lbm() directly
    --
    -- Args:
    --      def_table (table): Usual definition table for the LBM

    -- (At the moment this function is a simple wrapper, but that might change later)
    minetest.register_lbm(def_table)

end

function unilib.register_schematic(def_table)

    -- Original to unilib
    -- Packages should call this function to register a schematic, rather than calling
    --      minetest.register_schematic() directly
    --
    -- Args:
    --      def_table (table): Usual definition table for the schematic

    -- (At the moment this function is a simple wrapper, but that might change later)
    minetest.register_schematic(def_table)

end

---------------------------------------------------------------------------------------------------
-- Biome registration
---------------------------------------------------------------------------------------------------

function unilib.register_biome(def_table)

    -- Original to unilib
    -- Register the biome with Minetest and, after some checks, updates global variables
    --
    -- Args:
    --      def_table (table): Usual definition table for the biomes. Note that "def_table" must
    --          include, at the very least, a .name property

    -- If the Minetest setting is specified, force a single biome across the whole world
    if unilib.debug_forced_biome ~= nil and unilib.debug_forced_biome ~= "" then

        if def_table.name ~= unilib.debug_forced_biome then

            return

        else

            def_table.y_max = unilib.y_max
            def_table.y_min = unilib.y_min
            def_table.heat_point = 50
            def_table.humidity_point = 50

        end

    end

    -- Basic checks
    if def_table.name == nil or def_table.name == "" then

        unilib.show_error("unilib.register_biome(): Invalid biome registration (missing name)")
        return

    elseif unilib.biome_table[def_table.name] ~= nil then

        unilib.show_warning("unilib.register_biome(): Duplicate biome registration", def_table.name)

    elseif unilib.debug_check_heights_flag and
            not unilib.check_heights(def_table.y_max, def_table.y_min) then

        unilib.show_warning(
            "unilib.register_biome(): Invalid height values in biome registration",
            def_table.name,
            def_table.y_max,
            def_table.y_min
        )

    end

    -- Register the biome with Minetest
    minetest.register_biome(def_table)

    -- Register a new biome in unilib's biome registry, using default values for any property that
    --      was not specified in the function call
    local data_table = {}

    data_table.biome_name = def_table.name
    data_table.description = def_table.description or def_table.name

    if def_table.y_max == nil then
        data_table.y_max = unilib.y_max
    else
        data_table.y_max = def_table.y_max
    end

    if def_table.y_min == nil then
        data_table.y_min = unilib.y_min
    else
        data_table.y_min = def_table.y_min
    end

    if def_table.heat_point == nil then
        data_table.heat_point = 50
    else
        data_table.heat_point = def_table.heat_point
    end

    if def_table.humidity_point == nil then
        data_table.humidity_point = 50
    else
        data_table.humidity_point = def_table.humidity_point
    end

    if def_table.node_top ~= nil then
        data_table.place_on = def_table.node_top
    else
        data_table.place_on = def_table.node_stone
    end

    unilib.biome_table[def_table.name] = data_table

end

function unilib.register_biome_from_csv(data_table)

    -- Original to unilib
    -- The file biomes.csv in the remix folder defines a list of biomes and their properties
    -- Convert data loaded from the CSV into the format expected by unilib.register_biome(), then
    --      call that function
    --
    -- Args:
    --      data_table (table): Table created by ../lib/system/read_csv.lua, defining the
    --          properties of a single biome. For the table format, see the comments in
    --          ../lib/system/global.lua

    -- If the Minetest setting is specified, force a single biome across the whole world
    if unilib.debug_forced_biome ~= nil and unilib.debug_forced_biome ~= "" then

        if data_table.biome_name ~= unilib.debug_forced_biome then

            return

        else

            data_table.y_max = unilib.y_max
            data_table.y_min = unilib.y_min
            data_table.heat_point = 50
            data_table.humidity_point = 50

        end

    end

    -- Prepare the biome definition
    local def_table = {}

    def_table.name = data_table.biome_name

    if data_table.dust ~= "" then
        def_table.node_dust = data_table.dust
    end

    if data_table.top_str ~= "" then

        local this_list = data_table.top_str:split("%s", false, 1, true)
        def_table.node_top = this_list[1]
        def_table.depth_top = tonumber(this_list[2] or 1)

    end

    if data_table.fill_str ~= "" then

        local this_list = data_table.fill_str:split("%s", false, 1, true)
        def_table.node_filler = this_list[1]
        def_table.depth_filler = tonumber(this_list[2] or 1)

    end

    if data_table.stone ~= "" then
        def_table.node_stone = data_table.stone
    end

    if data_table.water_top_str ~= "" then

        local this_list = data_table.water_top_str:split("%s", false, 1, true)
        def_table.node_water_top = this_list[1]
        def_table.depth_water_top = tonumber(this_list[2] or 1)

    end

    if data_table.water ~= "" then
        def_table.node_water = data_table.water
    end

    if data_table.river ~= "" then
        def_table.node_river_water = data_table.river
    end

    if data_table.riverbed_str ~= "" then

        local this_list = data_table.riverbed_str:split("%s", false, 1, true)
        def_table.node_riverbed = this_list[1]
        def_table.depth_riverbed = tonumber(this_list[2] or 1)

    end

    if data_table.cave_liquid ~= "" then
        def_table.node_cave_liquid = data_table.cave_liquid
    end

    if data_table.dungeon ~= "" then
        def_table.node_dungeon = data_table.dungeon
    end

    if data_table.dungeon_alt ~= "" then
        def_table.node_dungeon_alt = data_table.dungeon_alt
    end

    if data_table.dungeon_stair ~= "" then
        def_table.node_dungeon_stair = data_table.dungeon_stair
    end

    def_table.y_max = tonumber(data_table.y_max) or unilib.y_max
    def_table.y_min = tonumber(data_table.y_min) or unilib.y_min
    def_table.vertical_blend = tonumber(data_table.blend) or 0
    def_table.heat_point = tonumber(data_table.heat) or 50
    def_table.humidity_point = tonumber(data_table.humidity) or 50

    return unilib.register_biome(def_table)

end

---------------------------------------------------------------------------------------------------
-- Decoration registration
---------------------------------------------------------------------------------------------------

function unilib.register_decoration(generic_name, generic_def_table)

    -- Original to unilib
    -- For details about creating decorations, see the explanatory notes in global.lua
    -- This function is called by a package like "tree_aspen", which creates a generic definition
    --      table stored in a global variable
    -- Later, packages like "deco_default_tree_aspen" will call unilib.register_decoration_now()
    --      with a specific definition table. The generic and specific tables are combined in the
    --      eventual call to minetest.register_decoration()
    --
    -- Args:
    --      generic_name (str): Name in the form REMIX-NAME_ITEM-NAME_N; see the notes in global.lua
    --      generic_def_table (table): The generic definition table itself. If specified, the fields
    --          .biomes, .place_on, .spawn_by, .num_spawn_by, .y_max and .y_min are overwritten with
    --          default values

    if unilib.generic_deco_table[generic_name] ~= nil then

        unilib.show_warning(
            "unilib.register_decoration(): Duplicate generic decoration name", generic_name
        )

    end

    -- Set generic values which should not appear in "generic_def_table"
    generic_def_table.biomes = nil       -- Place anywhere
    generic_def_table.place_on = nil     -- Place anywhere
    generic_def_table.spawn_by = nil     -- Spawn next to any node
    generic_def_table.num_spawn_by = -1
    generic_def_table.y_max = unilib.y_max
    generic_def_table.y_min = 1

    -- Apply the random seed offset, if required
    if generic_def_table.noise_params ~= nil and generic_def_table.noise_params.seed ~= nil then

        generic_def_table.noise_params.seed = generic_def_table.noise_params.seed +
                unilib.get_mod_attribute("storage_random_seed_offset")

    end

    -- Store the generic definition table until it can be retrieved by a later call to
    --      unilib.register_decoration_now()
    unilib.generic_deco_table[generic_name] = generic_def_table

end

function unilib.register_decoration_now(generic_name, specific_name, specific_def_table)

    -- Original to unilib
    -- The earlier call to unilib.register_decoration created a generic definition table, with
    --      the name "generic_name"
    -- This call supplies a specific definition table, whose values override the generic table.
    --      The combined table is used in the call to minetest.register_decoration()
    -- Registers the decoration in the specified biome
    --
    -- Args:
    --      generic_name (str): Name in the form REMIX-NAME_ITEM-NAME_N; see the notes in
    --          global.lua. A key in unilib.generic_deco_table
    --      specific_name (str or nil): If specified, the decoration is registered with the .name
    --          "unilib:SPECIFIC_NAME". If not specified, the decoration is registered with the
    --          .name "unilib:GENERIC_NAME". Note that any .name field in "specific_def_table"
    --          will be ignored
    --      specific_def_table (table): A partial definition table containing any number of fields
    --          (including none at all) to be used in the minetest.register_decoration() call. The
    --          specified fields will overwrite one of the generic values for the fields .biomes,
    --          .place_on, .spawn_by, .num_spawn_by, .y_max and .y_min

    -- Basic checks
    if unilib.generic_deco_table[generic_name] == nil then

        unilib.show_error(
            "unilib.register_decoration_now(): Missing generic decoration definition",
            generic_name
        )

        return

    elseif unilib.debug_check_heights_flag and
            not unilib.check_heights(specific_def_table.y_max, specific_def_table.y_min) then

        unilib.show_warning(
            "unilib.register_decoration_now(): Invalid height values in decoration registration",
            generic_name,
            specific_def_table.y_max,
            specific_def_table.y_min
        )

    end

    local deco_name = specific_name
    if deco_name == nil then
        deco_name = generic_name
    end

    if minetest.registered_decorations["unilib:" .. deco_name] ~= nil then

        unilib.show_error(
            "unilib.register_decoration_now(): Decoration already registered",
            deco_name,
            generic_name
        )

        return

    end

    -- The default behaviour is to register the decoration in the specified biome(s)
    local adj_def_table = {}

    for k, v in pairs(unilib.generic_deco_table[generic_name]) do
        adj_def_table[k] = v
    end

    specific_def_table.auto = nil
    for k, v in pairs(specific_def_table) do
        adj_def_table[k] = v
    end

    adj_def_table["name"] = unilib.get_unique_deco_name("unilib:" .. deco_name)

    -- Register the decoration
    minetest.register_decoration(adj_def_table)

end

function unilib.register_decoration_convertable(data_table)

    -- Original to unilib
    -- Minetest offers two types of decorations: single nodes, and schematics. This is a workaround
    --      to add a third type, which places one or many nodes (comprising a single decoration)
    --      using a callback function
    --
    -- Calls to this function create an invisible node which can be placed as a "simple" decoration.
    --      We then create an LBM which replaces the invisible node using the specified callback
    --      function (for example, to grow a bush using code, rather than a schematic). Finally, we
    --      create a generic decoration definition, which the calling code can use in a call to
    --      unilib.register_decoration_now().
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "tree_oak", creates an invisible node called
    --          "unilib:convert_tree_oak" and a generic definition called "convert_tree_oak"
    --      convert_func (func): The specified callback function
    --      replace_mode (str): "add", "defer", "replace" or "hide"
    --
    -- data_table optional fields:
    --      climate_table (table): A selection of key-value pairs adapted from biome_lib. If
    --          specified, the decoration is only placed in suitable positions (otherwise, it is
    --          replaced by air). Table with optional keys in the form:
    --              humidity_min, humidity_max (int): range 0 - 100
    --              light_min, light_max (int): range 0 - unilib.light_max
    --              temp_min, temp_max (int): range 0 - 100
    --      generic_def_table (table): Generic decoration definition, used in the call to
    --          unilib.register_decoration(). The .deco_type and .decoration fields, if specified,
    --          are replace with default values by this function
    --      space_table (table): If specified, the area around the decoration is checked (for
    --          example, so that trees don't try to grow inside each other). Table with optional
    --          keys in the form:
    --              height (int): Checks all nodes between the invisible node and "height" nodes
    --                  above it. Default value: 3, minimum value = 1
    --              width (int): Checks four columns in each corner of the area "height" x "width".
    --                  Default/minimum value: 1 (in which case only nodes directly above the
    --                  invisible node are checked)
    --              medium_name (str): Full node name for the empty space. Default value: "air"
    --              sub_name (str): Full node name for item to be placed if the decoration can't
    --                  be placed; typically a sapling (which will grow into a tree of its own
    --                  accord, if the situation improves). Default value: nil

    local part_name = data_table.part_name
    local convert_func = data_table.convert_func
    local replace_mode = data_table.replace_mode

    local climate_table = data_table.climate_table or nil
    local generic_def_table = data_table.generic_def_table or {}
    local space_table = data_table.space_table or nil

    if space_table ~= nil then

        if space_table.height == nil or space_table.height < 1 then
            space_table.height = 3
        end

        if space_table.width == nil or space_table.height < 0 then
            space_table.width = 1
        end

        if space_table.medium_name == nil then
            space_table.medium_name = "air"
        end

    end

    local invisible_name = "unilib:convert_" .. part_name
    local deco_name = "convert_" .. part_name

    unilib.register_node(invisible_name, nil, replace_mode, {
        -- (no description)
        -- (no tiles)
        groups = {not_in_creative_inventory = 1, unbreakable = 1},
        -- (no sounds)

        drawtype = "airlike",
        drop = "",
        paramtype = "light",
        pointable = false,
        sunlight_propagates = true,
        walkable = false,
    })

    unilib.register_lbm({
        label = "Handle convertable decorations [unilib]",
        name = "unilib:lbm_system_" .. deco_name,
        nodenames = {invisible_name},

        run_at_every_load = true,

        action = function(pos, node)

            if space_table ~= nil then

                -- Check the area around the invisible node to make sure there is enough free
                --      space
                -- N.B. This algorithm is imperfect, due to poorly-understood engine issues, but
                --      it's a lot better than nothing
                if space_table.width > 1 then

                    -- Check 1% of the positions bounded by the specified width and height
                    --      (typically between 5-100 positions to check, depending on the boundaries
                    --      of the area to be used by the decoration)
                    -- In testing, checking random positions gave better results than any organised
                    --      search pattern
                    local gap = math.floor(space_table.width / 2)
                    local x_min = pos.x - gap
                    local x_max = pos.x + gap
                    local y_min = pos.y + 1
                    local y_max = pos.y + space_table.height
                    local z_min = pos.z - gap
                    local z_max = pos.z + gap
                    local target = math.floor(
                        space_table.width * space_table.width * space_table.height * 0.01
                    )

                    for i = 1, target do

                        if minetest.get_node({
                            x = math.random(x_min, x_max),
                            y = math.random(y_min, y_max),
                            z = math.random(z_min, z_max),
                        }).name ~= space_table.medium_name then

                            minetest.remove_node(pos)
                            if space_table.sub_name ~= nil then
                                minetest.set_node(pos, {name = space_table.sub_name})
                            end

                            -- This position is not free
                            return

                        end

                    end

                else

                    -- Just check every node in the column
                    for i = 1, space_table.height do

                        if minetest.get_node({x = pos.x, y = pos.y + i, z = pos.z}).name ~=
                                space_table.medium_name then

                            minetest.remove_node(pos)
                            if space_table.sub_name ~= nil then
                                minetest.set_node(pos, {name = space_table.sub_name})
                            end

                            -- This position is not free
                            return

                        end

                    end

                end

            end

            if climate_table ~= nil then

                local light = minetest.get_node_light({x = pos.x, y = pos.y + 1, z = pos.z})
                local temp = minetest.get_heat(pos)
                local humidity = minetest.get_humidity(pos)

                -- Check the invisible node's position for light, temperature and/or humidity
                if (
                    climate_table.light_min ~= nil and
                            light < climate_table.light_min
                ) or (
                    climate_table.light_max ~= nil and
                            light > climate_table.light_max
                ) then

                    -- This position is not suitable (yet), try again later
                    return

                elseif (
                    climate_table.humidity_min ~= nil and
                            humidity < climate_table.humidity_min
                ) or (
                    climate_table.humidity_max ~= nil and
                            humidity > climate_table.humidity_max
                ) or (
                    climate_table.temp_min ~= nil and
                            temp < climate_table.temp_min
                ) or (
                    climate_table.temp_max ~= nil and
                            temp > climate_table.temp_max
                ) then

                    -- This position is not suitable
                    minetest.remove_node(pos)
                    minetest.set_node(pos, {name = "air"})
                    return

                end

            end

            -- (Called code is usually expecting the position of the node on which the decoration
            --      is placed, not the position of the invisible node)
            minetest.remove_node(pos)
            convert_func({x = pos.x, y = pos.y - 1, z = pos.z}, part_name)

        end,
    })

    if generic_def_table == nil then
        generic_def_table = {}
    end

    generic_def_table.deco_type = "simple"
    generic_def_table.decoration = invisible_name

    unilib.register_decoration(deco_name, generic_def_table)

end

function unilib.register_decoration_from_csv(data_table)

    -- Original to unilib
    -- The file decorations.csv in the remix folder defines a list of decorations and their
    --      properties
    -- Convert data loaded from the CSV into the format expected by unilib.register_decoration(),
    --      then call that function
    --
    -- Args:
    --      data_table (table): Table created by ../lib/system/read_csv.lua, defining the
    --          properties of a single decoration. For the table format, see the comments in
    --          ../lib/system/global.lua

    local def_table = {}

    if data_table.deco_type == "simple" then

        -- If .deco_name is a list of items, use the first one to give the decoration a unique
        --      name
        local deco_name_list = unilib.split_string_by_whitespace(data_table.deco_name, true)

        def_table.name = unilib.get_unique_deco_name(deco_name_list[1])
        def_table.deco_type = "simple"

        if #deco_name_list == 1 then
            def_table.decoration = deco_name_list[1]
        else
            def_table.decoration = deco_name_list
        end

        if def_table.height_max ~= "" then
            def_table.height_max = tonumber(data_table.height_max)
        end

    elseif data_table.deco_type == "schematic" or data_table.deco_type == "schematic_no_rotate" then

        def_table.name = unilib.get_unique_deco_name(data_table.deco_name)
        def_table.deco_type = "schematic"
        def_table.schematic = unilib.path_mod .. "/mts/" .. data_table.deco_name .. ".mts"

        if data_table.flags == "" then
            def_table.flags = "place_center_x, place_center_z"
        else
            def_table.flags = parse_flags(data_table.flags)
        end

        if data_table.deco_type == "schematic" then
            def_table.rotation = "random"
        else
            def_table.rotation = "0"
        end

        if data_table.sidelen == "" then
            def_table.sidelen = 16
        else
            def_table.sidelen = tonumber(data_table.sidelen)
        end

    else

        -- Failsafe, in case some code other than that in read_csv.lua has inserted data into
        --      unilib.deco_setup_list()
        return

    end

    if data_table.biomes ~= "" then
        def_table.biomes = unilib.split_string_by_whitespace(data_table.biomes, true)
    end

    if data_table.fill_ratio ~= "" then
        def_table.fill_ratio = tonumber(data_table.fill_ratio)
    end

    if data_table.num_spawn_by ~= "" then
        def_table.num_spawn_by = tonumber(data_table.num_spawn_by)
    end

    if data_table.place_on ~= "" then
        def_table.place_on = unilib.split_string_by_whitespace(data_table.place_on, true)
    end

    if data_table.spawn_by ~= "" then
        def_table.spawn_by = unilib.split_string_by_whitespace(data_table.spawn_by, true)
    end

    if data_table.y_max ~= "" then
        def_table.y_max = tonumber(data_table.y_max)
    end

    if data_table.y_min ~= "" then
        def_table.y_min = tonumber(data_table.y_min)
    end

    -- Check for valid heights, if required
    if unilib.debug_check_heights_flag and
            not unilib.check_heights(def_table.y_max, def_table.y_min) then

        unilib.show_warning(
            "unilib.register_decoration_from_csv(): Invalid height values in decoration" ..
                    " registration",
            def_table.name,
            def_table.y_max,
            def_table.y_min
        )

    end

    -- Register the decoration
    minetest.register_decoration(def_table)

end

function unilib.register_decoration_simple(def_table)

    -- Original to unilib
    -- Decoration-registration function for any code that wants to register a decoration directly
    -- Instead of calling minetest.register_decoration(), this function is called; it adds a
    --      unique name to the decoration, but otherwise makes no changes
    --
    -- Args:
    --      def_table (table): Usual definition table for a decoration. The .name property, if
    --          specified, is overwritten

    if def_table.deco_type == "simple" then

        if type(def_table.decoration) == "table" then
            def_table.name = unilib.get_unique_deco_name(def_table.decoration[1])
        else
            def_table.name = unilib.get_unique_deco_name(def_table.decoration)
        end

    else

        def_table.name = unilib.get_unique_deco_name(def_table.schematic)

    end

    -- Check for valid heights, if required
    if unilib.debug_check_heights_flag and
            not unilib.check_heights(def_table.y_max, def_table.y_min) then

        unilib.show_warning(
            "unilib.register_decoration_simple(): Invalid height values in decoration" ..
                    " registration",
            def_table.name,
            def_table.y_max,
            def_table.y_min
        )

    end

    -- Register the decoration
    minetest.register_decoration(def_table)

end

---------------------------------------------------------------------------------------------------
-- Ore registration
---------------------------------------------------------------------------------------------------

function unilib.register_ore(def_table)

    -- Original to unilib
    -- Registers an ore distribution in global variables
    -- During ../lib/system/import_pkg.lua's consolidation stage, they are registered with Minetest
    --      in the correct order, via a call to unilib.register_ore_now()
    --
    -- Args:
    --      def_table (table): Usual definition table for the ore distribution. Note that def_table
    --          must include an .ore_type field, whose value is "stratum", "sheet", "vein", "puff",
    --          "blob", or "scatter"

    -- Apply the random seed offset, if required
    if def_table.noise_params ~= nil and def_table.noise_params.seed ~= nil then

        def_table.noise_params.seed = def_table.noise_params.seed +
                unilib.get_mod_attribute("storage_random_seed_offset")

    end

    -- Register the ore distribution
    table.insert(unilib.ore_table[def_table.ore_type .. "_list"], def_table)

end

function unilib.register_ore_now(def_table)

    -- Original to unilib
    -- Registers an ore distribution with Minetest
    --
    -- Args:
    --      def_table (table): Usual definition table for the ore distribution

    -- Check for valid heights, if required
    if unilib.debug_check_heights_flag and
            not unilib.check_heights(def_table.y_max, def_table.y_min) then

        unilib.show_warning(
            "unilib.register_ore_now(): Invalid height values in ore registration",
            def_table.ore,
            def_table.y_max,
            def_table.y_min
        )

        return

    end

    -- Ores with non-existent nodes cause unified_inventory to crash, so we must filter them out
    if not unilib.is_registered_node_or_mtgame_alias(def_table.ore) then

        unilib.show_warning(
            "unilib.register_ore_now(): Unspecified or non-existent node in ore registration",
            def_table.ore
        )

    elseif not unilib.is_registered_node_or_mtgame_alias(def_table.wherein) then

        unilib.show_error(
            "unilib.register_ore_now(): Unspecified or non-existent node(s) in ore registration",
            def_table.wherein
        )

    else

        minetest.register_ore(def_table)

    end

end

function unilib.register_ore_from_csv(data_table)

    -- Original to unilib
    -- The files "ore_scatter.csv", "ore_sheet.csv", "ore_puff.csv", "ore_blob.csv", "ore_vein.csv",
    --      "ore_stratum.csv" in the remix folder define a list of ores and their properties
    -- Convert data loaded from the CSV into the format expected by unilib.register_ore(), then
    --      call that function
    --
    -- Args:
    --      data_table (table): Table created by ../lib/system/read_csv.lua, defining the
    --          properties of a single ore distribution. For the table format, see the comments in
    --          ../lib/system/global.lua

    local def_table = {}

    -- (All ore types)
    def_table.ore_type = data_table.ore_type
    def_table.ore = data_table.ore

    if data_table.ore_param2 ~= "" then
        def_table.ore_param2 = tonumber(data_table.ore_param2)
    end

    if data_table.wherein ~= "" then
        def_table.wherein = unilib.split_string_by_whitespace(data_table.wherein, true)
    end

    def_table.clust_scarcity = parse_clust_scarcity(data_table.clust_scarcity)

    if data_table.clust_num_ores ~= "" then
        def_table.clust_num_ores = tonumber(data_table.clust_num_ores)
    end

    if data_table.clust_size ~= "" then
        def_table.clust_size = tonumber(data_table.clust_size)
    end

    if data_table.y_max ~= "" then
        def_table.y_max = tonumber(data_table.y_max)
    end

    if data_table.y_min ~= "" then
        def_table.y_min = tonumber(data_table.y_min)
    end

    def_table.flags = parse_flags(data_table.flags)

    if data_table.noise_threshold ~= "" then
        def_table.noise_threshold = tonumber(data_table.noise_threshold)
    end

    if data_table.np_offset ~= "" or
            data_table.np_scale ~= "" or
            data_table.np_spread ~= "" or
            data_table.np_seed ~= "" or
            data_table.np_octaves ~= "" or
            data_table.np_persist ~= "" then

        def_table.noise_params = {}

        if data_table.np_offset ~= "" then
            def_table.noise_params.offset = tonumber(data_table.np_offset)
        end

        if data_table.np_scale ~= "" then
            def_table.noise_params.scale = tonumber(data_table.np_scale)
        end

        def_table.noise_params.spread = parse_spread(data_table.np_spread)

        if data_table.np_seed ~= "" then
            def_table.noise_params.seed = tonumber(data_table.np_seed)
        end

        if data_table.np_octaves ~= "" then
            def_table.noise_params.octaves = tonumber(data_table.np_octaves)
        end

        if data_table.np_persist ~= "" then
            def_table.noise_params.persistence = tonumber(data_table.np_persist)
        end

    end

    def_table.biomes = unilib.split_string_by_whitespace(data_table.biomes, true)

    -- Specific ore types
    if data_table.ore_type == "sheet" then

        if data_table.column_height_max ~= "" then
            def_table.column_height_max = tonumber(data_table.column_height_max)
        end

        if data_table.column_height_min ~= "" then
            def_table.column_height_min = tonumber(data_table.column_height_min)
        end

        if data_table.column_midpoint_factor ~= "" then
            def_table.column_midpoint_factor = tonumber(data_table.column_midpoint_factor)
        end

    elseif data_table.ore_type == "puff" then

        if data_table.nppt_offset ~= "" or
                data_table.nppt_scale ~= "" or
                data_table.nppt_spread ~= "" or
                data_table.nppt_seed ~= "" or
                data_table.nppt_octaves ~= "" or
                data_table.nppt_persist ~= "" then

            def_table.np_puff_top = {}

            if data_table.nppt_offset ~= "" then
                def_table.np_puff_top.offset = tonumber(data_table.nppt_offset)
            end

            if data_table.nppt_scale ~= "" then
                def_table.np_puff_top.scale = tonumber(data_table.nppt_scale)
            end

            def_table.np_puff_top.spread = parse_spread(data_table.nppt_spread)

            if data_table.nppt_seed ~= "" then
                def_table.np_puff_top.seed = tonumber(data_table.nppt_seed)
            end

            if data_table.nppt_octaves ~= "" then
                def_table.np_puff_top.octaves = tonumber(data_table.nppt_octaves)
            end

            if data_table.nppt_persist ~= "" then
                def_table.np_puff_top.persistence = tonumber(data_table.nppt_persist)
            end

        end

        if data_table.nppb_offset ~= "" or
                data_table.nppb_scale ~= "" or
                data_table.nppb_spread ~= "" or
                data_table.nppb_seed ~= "" or
                data_table.nppb_octaves ~= "" or
                data_table.nppb_persist ~= "" then

            def_table.np_puff_bottom = {}

            if data_table.nppb_offset ~= "" then
                def_table.np_puff_bottom.offset = tonumber(data_table.nppb_offset)
            end

            if data_table.nppb_scale ~= "" then
                def_table.np_puff_bottom.scale = tonumber(data_table.nppb_scale)
            end

            def_table.np_puff_bottom.spread = parse_spread(data_table.nppb_spread)

            if data_table.nppb_seed ~= "" then
                def_table.np_puff_bottom.seed = tonumber(data_table.nppb_seed)
            end

            if data_table.nppb_octaves ~= "" then
                def_table.np_puff_bottom.octaves = tonumber(data_table.nppb_octaves)
            end

            if data_table.nppb_persist ~= "" then
                def_table.np_puff_bottom.persistence = tonumber(data_table.nppb_persist)
            end

        end

    elseif data_table.ore_type == "vein" then

        if data_table.random_factor ~= "" then
            def_table.random_factor = tonumber(data_table.random_factor)
        end

    elseif data_table.ore_type == "stratum" then

        if data_table.npst_offset ~= "" or
                data_table.npst_scale ~= "" or
                data_table.npst_spread ~= "" or
                data_table.npst_seed ~= "" or
                data_table.npst_octaves ~= "" or
                data_table.npst_persist ~= "" then

            def_table.np_stratum_thickness = {}

            if data_table.npst_offset ~= "" then
                def_table.np_stratum_thickness.offset = tonumber(data_table.npst_offset)
            end

            if data_table.npst_scale ~= "" then
                def_table.np_stratum_thickness.scale = tonumber(data_table.npst_scale)
            end

            def_table.np_stratum_thickness.spread = parse_spread(data_table.npst_spread)

            if data_table.npst_seed ~= "" then
                def_table.np_stratum_thickness.seed = tonumber(data_table.npst_seed)
            end

            if data_table.npst_octaves ~= "" then
                def_table.np_stratum_thickness.octaves = tonumber(data_table.npst_octaves)
            end

            if data_table.npst_persist ~= "" then
                def_table.np_stratum_thickness.persistence = tonumber(data_table.npst_persist)
            end

        end

        if data_table.stratum_thickness ~= "" then
            def_table.stratum_thickness = tonumber(data_table.stratum_thickness)
        end

    end

    -- Check for valid heights, if required
    if unilib.debug_check_heights_flag and
            not unilib.check_heights(def_table.y_max, def_table.y_min) then

        unilib.show_warning(
            "unilib.register_ore_from_csv(): Invalid height values in ore registration",
            def_table.ore,
            def_table.y_max,
            def_table.y_min
        )

    end

    -- Register the ore
    unilib.register_ore(def_table)

end
