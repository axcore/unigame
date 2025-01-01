---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- load_consolidate_general.lua
--      Execute consolidation code before package .post() functions are called
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Setup code
---------------------------------------------------------------------------------------------------

-- After all package .exec() functions have been called, but before .post() functions have been
--      called, we do some consolidation

-- Having defined both liquids and empty buckets, we now set up liquids in buckets, so those items
--      are ready for use by the .post() functions
for bucket_type, _ in pairs(unilib.global.generic_bucket_table) do

    for liquid_type, _ in pairs(unilib.global.generic_liquid_table) do

        unilib.register_liquid_in_bucket({
            bucket_type = bucket_type,
            liquid_type = liquid_type,
        })

    end

end

-- Prune the lists of fishing catches, to remove any items which don't exist (or which don't match
--      a biome/fishing rod that exists)
unilib.global.fishing_fish_list = unilib.utils.prune_fishing_list(unilib.global.fishing_fish_list)
unilib.global.fishing_bonus_list = unilib.utils.prune_fishing_list(unilib.global.fishing_bonus_list)
unilib.global.fishing_junk_list = unilib.utils.prune_fishing_list(unilib.global.fishing_junk_list)
