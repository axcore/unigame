---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- fishing_base.lua
--      Base API functions for fishing
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Base API functions for fishing
---------------------------------------------------------------------------------------------------

function unilib.fishing._register_fish(data_table)

    -- Adapted from ethereal-ng/fishing.lua
    -- Registers a fish (in global variables) to be caught with a fishing rod
    --
    -- data_table compulsory fields:
    --      full_name (str): e.g. "unilib:ingredient_fish_angler"
    --
    -- Optional arguments:
    --      biome_part_name (str): e.g. "ethereal_grassland", "ocean". If not specified, the item
    --          can be caught in any biome
    --      rod_name (str): e.g. "unilib:item_rod_fishing". If not specified, the item can be caught
    --          with any compatible rod

    local full_name = data_table.full_name

    local biome_part_name = data_table.biome_part_name or nil
    local rod_name = data_table.rod_name or nil

    -- Update the unilib registry
    table.insert(unilib.global.fishing_fish_list, {
        full_name = full_name,
        biome_part_name = biome_part_name,
        rod_name = rod_name,
        tool_wear = nil,
    })

end

function unilib.fishing._register_bonus(data_table)

    -- Adapted from ethereal-ng/fishing.lua
    -- Registers a bonus item (in global variables) to be caught with a fishing rod
    --
    -- data_table compulsory fields:
    --      full_name (str): e.g. "unilib:item_book_ordinary"
    --
    -- Optional arguments:
    --      biome_part_name (str): e.g. "ethereal_grassland", "ocean". If not specified, the item
    --          can be caught in any biome
    --      rod_name (str): e.g. "unilib:item_rod_fishing". If not specified, the item can be caught
    --          with any compatible rod
    --      tool_wear (int): e.g. 12000

    local full_name = data_table.full_name

    local biome_part_name = data_table.biome_part_name or nil
    local rod_name = data_table.rod_name or nil
    local tool_wear = data_table.tool_wear or nil

    -- Update the unilib registry
    table.insert(unilib.global.fishing_bonus_list, {
        full_name = full_name,
        biome_part_name = biome_part_name,
        rod_name = rod_name,
        tool_wear = tool_wear,
    })

end

function unilib.fishing._register_junk(data_table)

    -- Adapted from ethereal-ng/fishing.lua
    -- Registers a junk item (in global variables) to be caught with a fishing rod
    --
    -- data_table compulsory fields:
    --      full_name (str): e.g. "unilib:item_stick_ordinary"
    --
    -- Optional arguments:
    --      biome_part_name (str): e.g. "ethereal_grassland", "ocean". If not specified, the item
    --          can be caught in any biome
    --      rod_name (str): e.g. "unilib:item_rod_fishing". If not specified, the item can be caught
    --          with any compatible rod
    --      tool_wear (int): e.g. 12000

    local full_name = data_table.full_name

    local biome_part_name = data_table.biome_part_name or nil
    local rod_name = data_table.rod_name or nil
    local tool_wear = data_table.tool_wear or nil

    -- Update the unilib registry
    table.insert(unilib.global.fishing_junk_list, {
        full_name = full_name,
        biome_part_name = biome_part_name,
        rod_name = rod_name,
        tool_wear = tool_wear,
    })

end
