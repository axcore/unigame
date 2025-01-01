---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- register_upgrade.lua
--      Node/craftitem/tool upgrade functions
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Node/craftitem/tool upgrade functions
---------------------------------------------------------------------------------------------------

function unilib.register._upgrade_node(full_name, orig_name, def_table)

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
    local orig_name_list = unilib.utils.convert_to_list(orig_name)
    for _, this_orig_name in ipairs(orig_name_list) do

        core.register_alias(this_orig_name, full_name)
        unilib.global.node_convert_table[this_orig_name] = full_name

    end

    -- (The original calling function might need this for its craft recipes)
    return full_name

end

function unilib.register._upgrade_craftitem(full_name, orig_name, def_table)

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
    local orig_name_list = unilib.utils.convert_to_list(orig_name)
    for _, this_orig_name in ipairs(orig_name_list) do

        core.register_alias(this_orig_name, full_name)
        unilib.global.craftitem_convert_table[this_orig_name] = full_name

    end

    -- (The original calling function might need this for its craft recipes)
    return full_name

end
