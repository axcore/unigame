---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    darkage
-- Code:    WTFPL
-- Media:   WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.shared_darkage = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.unilib.add_mode

local hint_text = S("use the screwdriver to rotate")

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_darkage.register_reinforced_frame(data_table)

    -- Adapted from darkage/building.lua
    -- Register reinforced frame nodes
    --
    -- data_table compulsory fields:
    --      orig_name (str): e.g. "darkage:chalk_powder"
    --      ingredient (str): Matching "orig_name", e.g. "unilib:stone_chalk_white_powder"
    --
    -- data_table optional fields:
    --      replace_mode (str): e.g. "defer"
    --      group_table (table): Normal group table, used in the .groups field of the
    --          minetest.register_node() call. if not specified, the .groups field for "ingredient"
    --          is used
    --      sound_table (table): Normal group table, used in the .sound field of the
    --          minetest.register_node() call. if not specified, the .sound field for "ingredient"
    --          is used
    --      tile_table (table): Normal tile table, used in the .tiles field of the
    --          minetest.register_node() call. If not specified, the .tiles field for "ingredient"
    --          is used

    local orig_name = data_table.orig_name
    local ingredient = data_table.ingredient

    local replace_mode = data_table.replace_mode or unilib.default_replace_mode
    local group_table = data_table.group_table or nil
    local sound_table = data_table.sound_table or nil
    local tile_table = data_table.tile_table or nil

    local orig_mod_name, orig_item_name
    if orig_name ~= nil then
        orig_mod_name, orig_item_name = unilib.split_name(orig_name)
    end

    -- (Use the groups/sounds/tiles from "ingredient", if necessary)
    local def_table = nil
    if minetest.registered_nodes[ingredient] ~= nil then
        def_table = table.copy(minetest.registered_nodes[ingredient])
    elseif minetest.registered_craftitems[ingredient] ~= nil then
        def_table = table.copy(minetest.registered_craftitems[ingredient])
    else
        return
    end

    if group_table == nil then
        group_table = def_table.groups or {}
    end

    if sound_table == nil then
        sound_table = def_table.sounds or unilib.sound_table.node
    end

    if tile_table == nil then
        tile_table = def_table.tiles or {"unilib_unknown.png"}
    end

    -- Reinforced X
    local x_tile_table = {}
    for _, tile in ipairs(tile_table) do
        table.insert(x_tile_table, tile .. "^unilib_reinforce_overlay.png")
    end

    local this_orig_name
    if orig_name ~= nil then
        this_orig_name = orig_mod_name .. ":reinforced_" .. orig_item_name
    end

    unilib.register_node(ingredient .. "_with_frame_reinforced", this_orig_name, replace_mode, {
        -- From <modname>:reinforced_<name>
        description = unilib.brackets(def_table.description, S("Reinforced Frame")),
        tiles = x_tile_table,
        groups = group_table,
        sounds = sound_table,
    })
    unilib.register_craft({
        output = ingredient .. "_with_frame_reinforced",
        recipe = {
            {"group:stick",    ingredient, "group:stick"},
            {ingredient, "group:stick", ingredient},
            {"group:stick",    ingredient, "group:stick"},
        }
    })
    minetest.register_craft({
        output = ingredient,
        recipe = {
            {ingredient .. "_with_frame_reinforced"},
        }
    })

    -- Reinforced slope
    local slope_tile_table = {}
    local slope_overlay_table = {
        "^unilib_reinforce_right_overlay.png",
        "^unilib_reinforce_right_overlay.png",
        "^unilib_reinforce_right_overlay.png",
        "^unilib_reinforce_right_overlay.png",
        "^unilib_reinforce_left_overlay.png",
        "^unilib_reinforce_left_overlay.png",
    }

    for i = 1, 6 do

        -- (There must be at least one tile)
        local tile = tile_table[i] or tile_table[1]
        slope_tile_table[i] = tile .. slope_overlay_table[i]

    end

    if orig_name ~= nil then
        this_orig_name = orig_mod_name .. ":reinforced_" .. orig_item_name .. "_slope"
    end

    unilib.register_node(
        -- From <modname>:reinforced_<name>_slope
        ingredient .. "_with_frame_reinforced_slope",
        this_orig_name,
        replace_mode,
        {
            description = unilib.hint(
                unilib.brackets(def_table.description, S("Reinforced Frame with Slope")), hint_text
            ),
            tiles = slope_tile_table,
            groups = group_table,
            sounds = sound_table,

            paramtype2 = "facedir",
        }
    )
    unilib.register_craft({
        output = ingredient .. "_with_frame_reinforced_slope",
        recipe = {
            {ingredient, ingredient, "group:stick"},
            {ingredient, "group:stick", ingredient},
            {"group:stick", ingredient, ingredient},
        }
    })
    unilib.register_craft({
        output = ingredient .. "_with_frame_reinforced_slope",
        recipe = {
            {"group:stick", ingredient, ingredient},
            {ingredient, "group:stick", ingredient},
            {ingredient, ingredient, "group:stick"},
        }
    })
    unilib.register_craft({
        output = ingredient,
        recipe = {
            {ingredient .. "_with_frame_reinforced_slope"},
        }
    })

    -- Reinforced arrow bar
    local arrow_tile_table = {}
    local arrow_overlay_table = {
        "",
        "",
        "^(unilib_reinforce_arrow_overlay.png^[transformR90)",
        "^(unilib_reinforce_arrow_overlay.png^[transformR270)",
        "^(unilib_reinforce_arrow_overlay.png^[transformR180)",
        "^unilib_reinforce_arrow_overlay.png",
    }

    for i = 1, 6 do

        -- (There must be at least one tile)
        local tile = tile_table[i] or tile_table[1]
        arrow_tile_table[i] = tile .. arrow_overlay_table[i]

    end

    if orig_name ~= nil then
        this_orig_name = orig_mod_name .. ":reinforced_" .. orig_item_name .. "_arrow"
    end

    unilib.register_node(
        -- From <modname>:reinforced_<name>_arrow
        ingredient .. "_with_frame_reinforced_arrow",
        this_orig_name,
        replace_mode,
        {
            description = unilib.hint(
                unilib.brackets(def_table.description, S("Reinforced Frame with Arrow")), hint_text
            ),
            tiles = arrow_tile_table,
            groups = group_table,
            sounds = sound_table,

            paramtype2 = "facedir",
        }
    )
    unilib.register_craft({
        output = ingredient .. "_with_frame_reinforced_arrow",
        recipe = {
            {ingredient, "group:stick", ingredient},
            {"group:stick", ingredient, "group:stick"},
            {"group:stick", ingredient, "group:stick"},
        }
    })
    unilib.register_craft({
        output = ingredient,
        recipe = {
            {ingredient .. "_with_frame_reinforced_arrow"},
        }
    })

    -- Reinforced bars
    local bar_tile_table = {}
    for _, tile in ipairs(tile_table) do
        table.insert(bar_tile_table, tile .. "^unilib_reinforce_bars_overlay.png")
    end

    if orig_name ~= nil then
        this_orig_name = orig_mod_name .. ":reinforced_" .. orig_item_name .. "_bars"
    end

    unilib.register_node(
        -- From <modname>:reinforced_<name>
        ingredient .. "_with_frame_reinforced_bars",
        this_orig_name,
        replace_mode,
        {
            description = unilib.hint(
                unilib.brackets(def_table.description, S("Reinforced Frame with Bars")), hint_text
            ),
            tiles = bar_tile_table,
            groups = group_table,
            sounds = sound_table,
        }
    )
    unilib.register_craft({
        output = ingredient .. "_with_frame_reinforced_bars",
        recipe = {
            {"group:stick",    ingredient, "group:stick"},
            {"group:stick",    ingredient, "group:stick"},
            {"group:stick",    ingredient, "group:stick"},
        }
    })
    minetest.register_craft({
        output = ingredient,
        recipe = {
            {ingredient .. "_with_frame_reinforced_bars"},
        }
    })

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_darkage.init()

    return {
        description = "Shared functions for reinforced frames (from darkage)",
    }

end
