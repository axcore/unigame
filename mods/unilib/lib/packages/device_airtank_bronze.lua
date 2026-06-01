---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    airtanks
-- Code:    MIT
-- Media:   MIT/CC0/CC BY 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.device_airtank_bronze = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.airtanks.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.device_airtank_bronze.init()

    return {
        description = "Bronze air tanks",
        -- N.B. "device_compressor_air" is used by code in "shared_airtanks" to refill empty tanks
        depends = {"device_compressor_air", "metal_bronze", "shared_airtanks"},
    }

end

function unilib.pkg.device_airtank_bronze.exec()

    local ingredient = "unilib:metal_bronze_ingot"
    local part_name = "bronze"
    local rgb = "#c87010"
    local uses = 30

    for capacity, description in ipairs({
        S("Bronze Air Tank"),
        S("Double-Capacity Bronze Air Tank"),
        S("Triple-Capacity Bronze Air Tank"),
    }) do

        if capacity <= unilib.setting.airtanks_capacity_max then

            unilib.pkg.shared_airtanks.register_tank({
                -- From airtanks:bronze_tank (etc), airtanks:empty_bronze_tank (etc). Creates
                --      unilib:device_airtank_bronze_single,
                --      unilib:device_airtank_bronze_single_empty (etc)
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
