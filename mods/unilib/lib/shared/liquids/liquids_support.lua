---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- liquids_support.lua
--      Liquids support functions
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Liquids support functions
---------------------------------------------------------------------------------------------------

function unilib.liquids._check_bucket_protection(pos, name, text)

    -- Adapted from bucket/init.lua

    if core.is_protected(pos, name) then

        unilib.utils.log(
            "action",
            (name ~= "" and name or "A mod") .. " tried to " .. text .. " at protected position " ..
                    core.pos_to_string(pos) .. " with a bucket"
        )

        core.record_protection_violation(pos, name)
        return true

    else

        return false

    end

end

function unilib.liquids._get_empty_container(full_name)

    -- Original to unilib
    -- Converts a full bucket (e.g. "unilib:bucket_steel_with_water_ordinary") into an empty bucket
    --      (e.g. "unilib:bucket_steel_empty")
    -- If it's not a unilib bucket (such as one from mobs_animal or petz), just return an empty
    --      steel bucket or an empty bottle, assuming that it was the original ingredient

    if unilib.global.full_bucket_table[full_name] ~= nil then
        return unilib.global.full_bucket_table[full_name]["empty_bucket"]
    elseif string.find(full_name, "bucket") then
        return "unilib:bucket_steel_empty"
    else
        return "unilib:vessel_bottle_glass_empty"
    end

end
