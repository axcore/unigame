---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- register_support_item.lua
--      Support functions (items)
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

-- Table of minetest_game nodes that are mapped on to Minetest standard aliases
-- Used by unilib.register.replace_item(), so that the unilib node can be mapped on to that alias
--      instead
-- Does not include v6 mapgen aliases, since unilib is not compatible with v6 anyway
local standard_alias_table = {
    -- Essential aliases
    ["default:stone"] = "mapgen_stone",
    ["default:water_source"] = "mapgen_water_source",
    ["default:river_water_source"] = "mapgen_river_water_source",
    -- Optional aliases
    ["default:lava_source"] = "mapgen_lava_source",
    ["default:cobble"] = "mapgen_cobble",
}

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function is_registered(orig_name)

    -- Original to unilib
    -- Called to check whether a node/craftitem/recipe from another mod has actually been
    --      registered, before the code below tries to unregister/hide it

    if core.registered_nodes[orig_name] ~= nil or
            core.registered_craftitems[orig_name] ~= nil or
            core.registered_tools[orig_name] ~= nil then
        return true
    else
        return false
    end

end

local function unregister_stairs_carvings(orig_name)

    -- Original to unilib
    -- Called by the unilib.register.hide_item() and unilib.register.replace_item() functions above
    --      (only)
    -- Note that original wall nodes are unregistered by code in ../lib/shared/walls/walls_api.lua

    local item_name = unilib.utils.get_item_name(orig_name)
    local unreg_list = {}

    if core.get_modpath("stairs") then

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

    if core.get_modpath("stairsplus") and
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

    if core.get_modpath("moreblocks") and
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

    if core.get_modpath("columnia") and is_registered("columnia:column_mid_" .. item_name) then

        table.insert(unreg_list, "columnia:column_mid_" .. item_name)
        table.insert(unreg_list, "columnia:column_top_" .. item_name)
        table.insert(unreg_list, "columnia:column_bottom_" .. item_name)
        table.insert(unreg_list, "columnia:column_crosslink_" .. item_name)
        table.insert(unreg_list, "columnia:column_link_" .. item_name)
        table.insert(unreg_list, "columnia:column_linkdown_" .. item_name)

    end

    if core.get_modpath("facade") and is_registered("facade:" .. item_name .. "_bannerstone") then

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
            core.unregister_item(stair_name)
        end

    end

end

---------------------------------------------------------------------------------------------------
-- Support functions (items)
---------------------------------------------------------------------------------------------------

function unilib.register._hide_item(full_name, orig_name_list)

    -- Original to unilib
    -- Deal with items from an original mod, for which the replace_mode is "hide"
    --
    -- Certain items might cause a crash when they are unregistered (for example,
    --      flowers:mushroom_brown from minetest_game)
    -- In that case, the calling package might specify "hide", overriding the replace_mode for the
    --      original mod
    --
    -- Unlike in unilib.register.replace_item() below, we don't unregister the item. Instead, we
    --      mark it as hidden (in unilib's registry), and give it the "not_in_creative_inventory"
    --      group so the player can't see it
    -- Unlike in unilib.register.replace_item() below, we don't call core.register_alias_force() to
    --      map the old item onto the new one, as that tends to cause a crash

    for _, orig_name in ipairs(orig_name_list) do

        if is_registered(orig_name) then

            local group_table = {}

            if core.registered_nodes[orig_name] ~= nil then
                group_table = table.copy(core.registered_nodes[orig_name]["groups"])
            elseif core.registered_craftitems[orig_name] ~= nil then
                group_table = table.copy(core.registered_craftitems[orig_name]["groups"])
            elseif core.registered_tools[orig_name] ~= nil then
                group_table = table.copy(core.registered_tools[orig_name]["groups"])
            end

            group_table.not_in_creative_inventory = 1

            unilib.override_item(orig_name, {groups = group_table})
            -- Update the unilib registry, so hidden items can be displayed by chat commands
            unilib.global.hidden_item_table[orig_name] = full_name

            -- Even though the node is merely hidden, any variations created by stairs/carvings mods
            --      can still be unregistered
            unregister_stairs_carvings(orig_name)

            -- Unregister any craft recipes, for which the output is "orig_name"
            -- N.B. The table's field is nil if no craft recipes have been registered
            local t = core.get_craft_recipe(orig_name)
            if t.items ~= nil then
                core.clear_craft({output = orig_name})
            end

        end

    end

end

function unilib.register._replace_item(full_name, orig_name_list)

    -- Original to unilib
    -- Deal with items from an original mod, for which the replace_mode is "replace"
    -- Unregister the item with Minetest

    for _, orig_name in ipairs(orig_name_list) do

        if is_registered(orig_name) then

            core.unregister_item(orig_name)

            -- Unregister any variants created by stairs/carvings mods
            unregister_stairs_carvings(orig_name)

            -- Map the old item onto the new one, so that other mods can use the new (unilib) item
            --      in their craft recipes
            if core.registered_aliases[orig_name] == nil then

                core.register_alias(orig_name, full_name)

            else

                -- Special handling: "orig_name" has already been mapped onto something
                -- For example, minetest_game/keys maps "default:key" on to "keys:key"; but the
                --      "item_key_ordinary" package tries to map both of them on to
                --      "unilib:item_key_ordinary", causing a Minetest warning
                -- In that case, this code resolves the situation without generating any warnings
                core.register_alias_force(core.registered_aliases[orig_name], full_name)
                core.register_alias_force(orig_name, full_name)

            end

            -- Apply any standard Minetest aliases
            if standard_alias_table[orig_name] ~= nil then
                core.register_alias_force(standard_alias_table[orig_name], full_name)
            end

            -- Unregister any craft recipes, for which the output is "orig_name"
            -- N.B. The table's field is nil if no craft recipes have been registered
            local t = core.get_craft_recipe(orig_name)
            if t.items ~= nil then
                core.clear_craft({output = orig_name})
            end

        end

    end

end
