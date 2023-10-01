---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    vessels
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.loot_vessels = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.vessels.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.loot_vessels.init()

    return {
        description = "Dungeon loot from the \"vessels\" mod",
        -- Register glass fragments as dungeon loot, if available
        mod_optional = "dungeon_loot",
        -- (Don't declare optional packages; it's up to the remix to decide which of these packages
        --      should be executed)
--      optional = "glass_ordinary",
    }

end

function unilib.pkg.loot_vessels.post()

    -- Register glass stuff as dungeon loot, if available
    if minetest.global_exists("dungeon_loot") then

        -- Adapted from bucket/init.lua

        local loot_table = {}

        if unilib.pkg_executed_table["glass_ordinary"] ~= nil then

            table.insert(loot_table, {
                name = "unilib:glass_ordinary_fragments",
                chance = 0.35,
                count = {1, 4},
            })

        end

        if #loot_table > 0 then
            dungeon_loot.register(loot_table)
        end

    end

end
