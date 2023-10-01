---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    carts
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.loot_carts = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.carts.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.loot_carts.init()

    return {
        description = "Dungeon loot from the \"carts\" mod",
        -- Register ordinary rails as dungeon loot, if available
        mod_optional = "dungeon_loot",
        -- (Don't declare optional packages; it's up to the remix to decide which of these packages
        --      should be executed)
--      optional = "rail_ordinary",
    }

end

function unilib.pkg.loot_carts.post()

    -- Register rails as dungeon loot, if available
    if minetest.global_exists("dungeon_loot") then

        -- Adapted from carts/init.lua

        local loot_table = {}

        if unilib.pkg_executed_table["rail_ordinary"] ~= nil then

            table.insert(loot_table, {
                name = "unilib:rail_ordinary",
                chance = 0.35,
                count = {1, 6},
            })

        end

        if #loot_table > 0 then
            dungeon_loot.register(loot_table)
        end

    end

end
