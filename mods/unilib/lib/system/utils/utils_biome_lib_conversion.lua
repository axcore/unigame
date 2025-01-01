---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- utils_biome_lib_conversion.lua
--      biome_lib conversion utility functions
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.utils._convert_biome_lib(data_table)

    -- Code to convert biome_lib values, typically used in a call to
    --      biome_lib.register_on_generate(), into a probability in the range 0-1
    -- The returned value can be used as the .fill_ratio in a core.register_decoration() call
    --
    -- This algorithm should create decorations with approximately the same frequency as
    --      biome_lib itself does (and if not, the algorithm can be updated without needing to
    --      update the calling packages)
    -- For some example code, see the "bush_branching_yellow" package

    -- Range of 0-100. Larger values make objects more rare
    local rarity = data_table.rarity or 100
    -- Rarity is reduced by fertility, i.e. (rarity - rarity_fertility)
    local rarity_fertility = data_table.rarity_fertility or 0
    -- Range of -1 to +1, with values in the range of about 0 to 0.5 being most useful
    local plantlife_limit = data_table.plantlife_limit or 0.1

    return (1 / (rarity - rarity_fertility)) *
            ((2 - (1 + plantlife_limit)) / 2) *
            unilib.setting.biome_lib_spawn_factor

end

function unilib.utils._convert_biome_lib_humidity(humidity)

    -- Code to convert biome_lib humidity values in the range +1 (0% humidity) to -1 (100% humidity)
    --      into a value in the range 0 (0% humidity) to 100 (100% humidity)
    -- The returned value can be used in a call to unilib.register_decoration_convertable()

    return (2 - (humidity + 1)) * 50

end

function unilib.utils._convert_biome_lib_temp(temp)

    -- Code to convert biome_lib temperature values in the range +1 (maximum coldness) to -1
    --      (maximum heat) into a value in the range 0 (maximum coldness) to 100 (maximum heat)
    -- The returned value can be used in a call to unilib.register_decoration_convertable()

    return (2 - (temp + 1)) * 50

end
