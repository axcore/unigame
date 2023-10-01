---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- storage.lua
--      Initialises mod attributes (mod storage)
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Set random seed offset
---------------------------------------------------------------------------------------------------

-- On the first run, create a random seed offset. When decoration/ore distributions specify a seed,
--      the offset is added to that seed. Thus different worlds have different distributions, but
--      identical distributions apply throughout a world (even across multiple sessions)
if unilib.get_mod_attribute("storage_random_seed_offset") == "" then

    if not unilib.random_seed_offset_flag then
        unilib.set_mod_attribute("storage_random_seed_offset", 0)
    else
        unilib.set_mod_attribute("storage_random_seed_offset", unilib.get_random_seed())
    end

end
