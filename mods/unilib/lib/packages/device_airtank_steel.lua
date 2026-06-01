---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    airtanks
-- Code:    MIT
-- Media:   MIT/CC0/CC BY 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.device_airtank_steel = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.airtanks.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.device_airtank_steel.init()

    return {
        description = "Steel air tanks",
        -- N.B. "device_compressor_air" is used by code in "shared_airtanks" to refill empty tanks
        depends = {"device_compressor_air", "metal_steel", "shared_airtanks"},
    }

end

function unilib.pkg.device_airtank_steel.exec()

    local ingredient = "unilib:metal_steel_ingot"
    local part_name = "steel"
    local rgb = "#d6d6d6"
    local uses = 20

    for capacity, description in ipairs({
        S("Steel Air Tank"),
        S("Double-Capacity Steel Air Tank"),
        S("Triple-Capacity Steel Air Tank"),
    }) do

        if capacity <= unilib.setting.airtanks_capacity_max then

            unilib.pkg.shared_airtanks.register_tank({
                -- From airtanks:steel_tank (etc), airtanks:empty_steel_tank (etc). Creates
                --      unilib:device_airtank_steel_single, unilib:device_airtank_steel_single_empty
                --      (etc)
                part_name = part_name,
                description = description,
                ingredient = ingredient,

                replace_mode = mode,
                capacity = capacity,
                rgb = rgb,
                use_count = uses * capacity,
            })

        end

    end

end
