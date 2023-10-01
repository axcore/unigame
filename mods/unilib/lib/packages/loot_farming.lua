---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.loot_farming = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.loot_farming.init()

    return {
        description = "Dungeon loot from the \"farming\" mod",
        -- Registers farming stuff as dungeon loot, if available
        mod_optional = "dungeon_loot",
        -- (Don't declare optional packages; it's up to the remix to decide which of these packages
        --      should be executed)
--      optional = {"crop_cotton", "crop_wheat", "item_string_ordinary"},
    }

end

function unilib.pkg.loot_farming.post()

    -- Register farming stuff as dungeon loot, if available
    if minetest.global_exists("dungeon_loot") then

        -- Adapted from bucket/init.lua

        local loot_table = {}

        if unilib.pkg_executed_table["crop_cotton"] ~= nil then

            table.insert(loot_table, {
                name = "unilib:crop_cotton_seed",
                chance = 0.4,
                count = {1, 4},
                types = {"normal"},
            })

        end

        if unilib.pkg_executed_table["crop_wheat"] ~= nil then

            table.insert(loot_table, {
                name = "unilib:crop_wheat_harvest",
                chance = 0.5,
                count = {2, 5},
            })

        end

        if unilib.pkg_executed_table["item_string_ordinary"] ~= nil then

            table.insert(loot_table, {
                name = "unilib:item_string_ordinary",
                chance = 0.5,
                count = {1, 8},
            })

        end

        if #loot_table > 0 then
            dungeon_loot.register(loot_table)
        end

    end

end
