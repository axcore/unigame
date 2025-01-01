---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    bucket
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.loot_bucket = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.bucket.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.loot_bucket.init()

    return {
        description = "Dungeon loot from the \"bucket\" mod",
        notes = "Registers steel buckets as dungeon loot, if available",
        mod_depends = "dungeon_loot",
        depends = "bucket_steel",
        -- (Don't declare optional packages; it's up to the remix to decide which of these packages
        --      should be executed)
--      optional = {"liquid_lava_ordinary", "liquid_water_ordinary"},
    }

end

function unilib.pkg.loot_bucket.post()

    -- Adapted from bucket/init.lua
    local loot_table = {}

    table.insert(loot_table, {name = "unilib:bucket_steel_empty", chance = 0.55})

    if unilib.global.pkg_executed_table["liquid_lava_ordinary"] ~= nil then

        table.insert(loot_table, {
            name = "unilib:bucket_steel_with_lava_ordinary",
            chance = 0.45,
            y = {-32768, -1},
            types = {"normal"},
        })

    end

    if unilib.global.pkg_executed_table["liquid_water_ordinary"] ~= nil then

        table.insert(loot_table, {
            name = "unilib:bucket_steel_with_water_ordinary",
            chance = 0.45,
            types = {"sandstone", "desert", "ice"},
        })

        table.insert(loot_table, {
            name = "unilib:bucket_steel_with_water_ordinary",
            chance = 0.45,
            y = {0, 32768},
            types = {"normal"},
        })

    end

    dungeon_loot.register(loot_table)

end
