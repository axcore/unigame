---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- load_consolidate.lua
--      Execute consolidation code before package .post() functions are called
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Setup code
---------------------------------------------------------------------------------------------------

-- Call advtrains to create any requested train platforms (adapted from underch/stone.lua)
for part_name, data_table in pairs(unilib.global.stone_table) do

    if data_table.platform_list ~= nil then

        for _, full_name in ipairs(data_table.platform_list) do
            advtrains.register_platform("unilib", full_name)
        end

    end

end
