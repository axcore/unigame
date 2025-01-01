---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- dirt_update.lua
--      Dirt update functions
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Dirt update functions
---------------------------------------------------------------------------------------------------

function unilib.dirt._update_turf_seeder_items()

    -- Called by code in ../lib/system/load/load_finalisation.lua
    -- Updates the table of turf seeder items, unilib.global.turf_seeder_table, replacing items
    --      represented as groups (e.g. "group:dry_grass") with actual node names
    --      (e.g. "unilib:grass_dry_1")

    local new_table = {}

    for seeder_name, data_table in pairs(unilib.global.turf_seeder_table) do

        if string.sub(seeder_name, 1, 6) ~= "group:" then

            new_table[seeder_name] = data_table

        else

            local group = string.sub(seeder_name, 7)
            for full_name, def_table in pairs(core.registered_nodes) do

                if core.get_item_group(full_name, group) ~= 0 then

                    new_table[full_name] = {}
                    for k, v in pairs(data_table) do
                        new_table[full_name][k] = v
                    end

                end

            end

        end

    end

    unilib.global.turf_seeder_table = new_table

end
