---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- fishing_catch.lua
--      Functions to select a catch
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Functions to select a catch
---------------------------------------------------------------------------------------------------

function unilib.fishing._select_catch(fishing_type, pos)

    -- Adapted from ethereal-ng/fishing.lua
    -- Selects an item to be caught by the fishing rod, from a list of possible items, filtering by
    --      biome if required. If nothing is selected, returns an empty string
    --
    -- Args:
    --      fishing_type (str): "fish", "bonus" or "junk", matching one of the global variable lists
    --      pos (table): e.g. {x = 1, y = 1, z = 1}
    --
    -- Return values:
    --      On failure, returns nil. On success, returns a mini-table in the form
    --          table.full_name, e.g. "unilib:tool_sword_steel" [compulsory]
    --          table.biome_part_name, e.g. "ethereal_grassland", "ocean" [or nil]
    --          table.rod_name, e.g. "unilib:item_rod_fishing" [or nil]
    --          table.tool_wear, e.g. 12000 [or nil]

    local item
    local fishing_list
    local available_list = {}
    local data = core.get_biome_data(pos)
    local biome = data and core.get_biome_name(data.biome) or ""

    if fishing_type == "fish" then
        fishing_list = unilib.global.fishing_fish_list
    elseif fishing_type == "bonus" then
        fishing_list = unilib.global.fishing_bonus_list
    else
        fishing_list = unilib.global.fishing_junk_list
    end

    for n = 1, #fishing_list do

        mini_table = fishing_list[n]

        if mini_table.biome_part_name == nil or biome:find(mini_table.biome_part_name) then
            table.insert(available_list, mini_table)
        end

    end

    if #available_list > 0 then
        return available_list[math.random(#available_list)]
    else
        return nil
    end

end
