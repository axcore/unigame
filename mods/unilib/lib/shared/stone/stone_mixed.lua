---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- stone_mixed.lua
--      Registry functions for mixed stone types
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Registry functions for mixed stone types
---------------------------------------------------------------------------------------------------

function unilib.stone._register_cobble_or_rubble_or_nothing(data_table)

    -- Original to unilib
    -- Called for a stone type, whose .hardness and .hardness_real values are different, and when
    --      unilib is creating a new cobble or rubble node (that doesn't appear in the original
    --      mod's code)
    -- Depending on the the stone's .hardness_real, a cobble node (and its compressed/condensed
    --      forms), or a rubble node (and its compressed/condensed forms), or just the compressed/
    --      condensed forms of smoothstone, should be generated

    -- data_table compulsory fields:
    --      part_name (str): e.g. "siltstone_dark", a key in unilib.global.stone_table
    --      cobble_description (str): e.g. "Dark Siltstone Cobble"
    --      cobble_compressed_description (str): e.g. "Compressed Dark Siltstone Cobble"
    --      cobble_condensed_description (str): e.g. "Condensed Dark Siltstone Cobble"
    --      rubble_description (str): e.g. "Dark Siltstone Rubble"
    --      rubble_compressed_description (str): e.g. "Compressed Dark Siltstone Rubble"
    --      rubble_condensed_description (str): e.g. "Condensed Dark Siltstone Rubble"
    --      smooth_compressed_description (str): e.g. "Compressed Dark Siltstone"
    --      smooth_condensed_description (str): e.g. "Condensed Dark Siltstone"
    --
    -- data_table optional fields:
    --      replace_mode (str): e.g. "defer"
    --      override_drop_flag (bool): If true, the smoothstone node is overriden to drop the
    --          the cobble or rubble node created by this function, if any

    local part_name = data_table.part_name
    local cobble_description = data_table.cobble_description
    local cobble_compressed_description = data_table.cobble_compressed_description
    local cobble_condensed_description = data_table.cobble_condensed_description
    local rubble_description = data_table.rubble_description
    local rubble_compressed_description = data_table.rubble_compressed_description
    local rubble_condensed_description = data_table.rubble_condensed_description
    local smooth_compressed_description = data_table.smooth_compressed_description
    local smooth_condensed_description = data_table.smooth_condensed_description

    local replace_mode = data_table.replace_mode or unilib.default_replace_mode
    local override_drop_flag = data_table.override_drop_flag or false

    local mini_table = unilib.global.stone_table[part_name]

    if mini_table.hardness_real == 1 then

        unilib.register_stone_rubble({
            part_name = part_name,
            orig_name = nil,

            replace_mode = replace_mode,
            description = rubble_description,
            img_list = {"unilib_stone_" .. part_name .. ".png^unilib_stone_rubble_overlay.png"},
        })
        if override_drop_flag then

            unilib.override_item("unilib:stone_" .. part_name, {
                drop = "unilib:stone_" .. part_name .. "_rubble",
            })

        end

        unilib.register_stone_rubble_compressed({
            part_name = part_name,
            orig_name = nil,

            replace_mode = replace_mode,
            description = rubble_compressed_description,
        })

        unilib.register_stone_rubble_condensed({
            part_name = part_name,
            orig_name = nil,

            replace_mode = replace_mode,
            description = rubble_condensed_description,
        })

    elseif mini_table.hardness_real <= 3 then

        unilib.register_stone_cobble({
            part_name = part_name,
            orig_name = nil,

            replace_mode = replace_mode,
            description = cobble_description,
            img_list = {"unilib_stone_" .. part_name .. ".png^unilib_stone_cobble_overlay.png"},
        })
        if override_drop_flag then

            unilib.override_item("unilib:stone_" .. part_name, {
                drop = "unilib:stone_" .. part_name .. "_cobble",
            })

        end

        unilib.register_stone_cobble_compressed({
            part_name = part_name,
            orig_name = nil,

            replace_mode = replace_mode,
            description = cobble_compressed_description,
        })

        unilib.register_stone_cobble_condensed({
            part_name = part_name,
            orig_name = nil,

            replace_mode = replace_mode,
            description = cobble_condensed_description,
        })

    else

        unilib.register_stone_smooth_compressed({
            part_name = part_name,
            orig_name = nil,

            replace_mode = replace_mode,
            description = smooth_compressed_description,
        })

        unilib.register_stone_smooth_condensed({
            part_name = part_name,
            orig_name = nil,

            replace_mode = replace_mode,
            description = smooth_condensed_description,
        })

    end

end
