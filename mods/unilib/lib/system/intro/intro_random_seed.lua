---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- intro_random_seed.lua
--      Set up random seeds
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Re-initialise the pseudo-random generator
---------------------------------------------------------------------------------------------------

math.randomseed(os.time())

---------------------------------------------------------------------------------------------------
-- Set random seed offset
---------------------------------------------------------------------------------------------------

-- For its decorations and ores, unilib uses pre-determined seeds by default. The Minetest settings
--      below, if enabled, apply random-ish seeds instead
-- A seed offset is a random number between -32768 and 32767). This number is generated when a
--      world is created, and then added to the seed of every decoration and ore, producing a
--      "random" seed that is computationlly very cheap
-- There are two ways to produce the seed offset; one is completely random, and the other is derived
--      from the mapgen seed
-- If you use a seed offset derived from the mapgen seed, then it will be the same for every world
--      using that mapgen seed (in other words, decorations and ores will always be found in the
--      same place). Otherwise, decorations and ores will always be randomly distributed

-- On the first run, set the seed offset
if unilib.utils.get_mod_attribute("storage_random_seed_offset") == "" then

    if unilib.setting.random_seed_offset_flag then

        -- An almost random seed
        unilib.utils.set_mod_attribute("storage_random_seed_offset", unilib.utils.get_random_seed())

    elseif unilib.setting.mapgen_seed_offset_flag then

        -- A "random" seed derived from the mapgen seed. The 32768 value is comparable to the range
        --      of values generated by a call to unilib.utils.get_random_seed()
        unilib.utils.set_mod_attribute(
            "storage_random_seed_offset",
            math.floor(core.get_mapgen_setting("seed") % 32768)
        )

    else

        -- No seed offset required
        unilib.utils.set_mod_attribute("storage_random_seed_offset", 0)

    end

end
