---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- fishing.lua
--      Set up shared functions for fishing
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Register catches
---------------------------------------------------------------------------------------------------

function unilib.register_fishing_fish(data_table)

    -- Adapted from ethereal-ng/fishing.lua
    -- Registers a fish (in global variables) to be caught with a fishing rod
    --
    -- data_table compulsory fields:
    --      full_name (str): e.g. "unilib:ingredient_fish_angler"
    --
    -- Optional arguments:
    --      biome_name (str): e.g. "ethereal_grassland". If not specified, the item can be caught
    --          in any biome
    --      rod_name (str): e.g. "unilib:item_rod_fishing". If not specified, the item can be caught
    --          with any compatible rod

    local full_name = data_table.full_name

    local biome_name = data_table.biome_name or nil
    local rod_name = data_table.rod_name or nil

    -- Update the unilib registry
    table.insert(unilib.fishing_fish_list, {
        full_name = full_name,
        biome_name = biome_name,
        rod_name = rod_name,
    })

end

function unilib.register_fishing_bonus(data_table)

    -- Adapted from ethereal-ng/fishing.lua
    -- Registers a bonus item (in global variables) to be caught with a fishing rod
    --
    -- data_table compulsory fields:
    --      full_name (str): e.g. "unilib:item_book_ordinary"
    --
    -- Optional arguments:
    --      biome_name (str): e.g. "ethereal_grassland". If not specified, the item can be caught
    --          in any biome
    --      rod_name (str): e.g. "unilib:item_rod_fishing". If not specified, the item can be caught
    --          with any compatible rod

    local full_name = data_table.full_name

    local biome_name = data_table.biome_name or nil
    local rod_name = data_table.rod_name or nil

    -- Update the unilib registry
    table.insert(unilib.fishing_bonus_list, {
        full_name = full_name,
        biome_name = biome_name,
        rod_name = rod_name,
    })

end

function unilib.register_fishing_junk(data_table)

    -- Adapted from ethereal-ng/fishing.lua
    -- Registers a junk item (in global variables) to be caught with a fishing rod
    --
    -- data_table compulsory fields:
    --      full_name (str): e.g. "unilib:item_stick_ordinary"
    --
    -- Optional arguments:
    --      biome_name (str): e.g. "ethereal_grassland". If not specified, the item can be caught
    --          in any biome
    --      rod_name (str): e.g. "unilib:item_rod_fishing". If not specified, the item can be caught
    --          with any compatible rod

    local full_name = data_table.full_name

    local biome_name = data_table.biome_name or nil
    local rod_name = data_table.rod_name or nil

    -- Update the unilib registry
    table.insert(unilib.fishing_junk_list, {
        full_name = full_name,
        biome_name = biome_name,
        rod_name = rod_name,
    })

end

---------------------------------------------------------------------------------------------------
-- Select a catch
---------------------------------------------------------------------------------------------------

function unilib.find_caught_item(fishing_type, pos)

    -- Adapted from ethereal-ng/fishing.lua
    -- Selects an item to be caught by the fishing rod, from a list of possible items, filtering by
    --      biome if required. If nothing is selected, returns an empty string
    --
    -- Args:
    --      fishing_type (str): "fish", "bonus" or "junk", matching one of the global variable lists
    --      pos (table): e.g. {x = 1, y = 1, z = 1}

    local item
    local fishing_list
    local item_list = {}
    local data = minetest.get_biome_data(pos)
    local biome = data and minetest.get_biome_name(data.biome) or ""

    if fishing_type == "fish" then
        fishing_list = unilib.fishing_fish_list
    elseif fishing_type == "bonus" then
        fishing_list = unilib.fishing_bonus_list
    else
        fishing_list = unilib.fishing_junk_list
    end

    for n = 1, #fishing_list do

        mini_table = fishing_list[n]

        if mini_table.biome_name == nil or biome:find(mini_table.biome_name) then
            table.insert(item_list, mini_table.full_name)
        end

    end

    if #item_list > 0 then
        return item_list[math.random(#item_list)]
    else
        return ""
    end

end
