---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- stone_adjust.lua
--      Hardness adjustment functions
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

-- (Table used by smooth and cobble variants)
local smooth_cracky_table = {3, 2, 1, 1, 1}
-- (Table used by block and brick variants)
local block_cracky_table = {2, 2, 1, 1, 1}

---------------------------------------------------------------------------------------------------
-- Hardness adjustment functions
---------------------------------------------------------------------------------------------------

function unilib.stone._get_adjusted_cracky(part_name, smooth_cracky, block_cracky)

    -- Called by some stone packages, for which the stone's in-game and real-world hardness values
    --      are different
    -- If they are indeed different, adjusts the value of the .cracky node group for smoothstones
    --      and blocks
    --
    -- Args:
    --      part_name (str): e.g. "ordinary" for unilib:stone_ordinary, unilib:stone_ordinary_block,
    --          etc
    --      smooth_cracky (int or nil): The value of the .cracky node group for the smoothstone
    --          variant. This original value is returned unless the stone's .hardness and
    --          .hardness_real are different, in which case a standard value is returned. If the
    --          value is not required, the argument's value can be nil (and nil is returned)
    --      block_cracky (int or nil): The value of the .cracky node group for the block variant.
    --          This original value is returned unless the stone's .hardness and .hardness_real are
    --          different, in which case a standard value is returned. If the value is not required,
    --          the argument's value can be nil (and nil is returned)
    --
    -- Return values:
    --      The adjusted values of smooth_cracky and block_cracky

    local mini_table = unilib.global.stone_table[part_name]

    if not unilib.setting.real_stone_hardness_flag then

        return smooth_cracky, block_cracky

    else

        if smooth_cracky ~= nil then
            smooth_cracky = smooth_cracky_table[mini_table.hardness_real]
        end

        if block_cracky ~= nil then
            block_cracky = block_cracky_table[mini_table.hardness_real]
        end

        return smooth_cracky, block_cracky

    end

end

function unilib.stone._get_actual_hardness(part_name)

    local mini_table = unilib.global.stone_table[part_name]
    local hardness = mini_table.hardness
    if unilib.setting.real_stone_hardness_flag and mini_table.hardness_real ~= hardness then
        hardness = mini_table.hardness_real
    end

    return hardness

end
