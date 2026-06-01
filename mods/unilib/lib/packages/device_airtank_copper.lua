---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    airtanks
-- Code:    MIT
-- Media:   MIT/CC0/CC BY 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.device_airtank_copper = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.airtanks.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.device_airtank_copper.init()

    return {
        description = "Copper air tanks",
        -- N.B. "device_compressor_air" is used by code in "shared_airtanks" to refill empty tanks
        depends = {"device_compressor_air", "metal_copper", "shared_airtanks"},
    }

end

function unilib.pkg.device_airtank_copper.exec()

    local ingredient = "unilib:metal_copper_ingot"
    local part_name = "copper"
    local rgb = "#cd8e54"
    local uses = 10

    for capacity, description in ipairs({
        S("Copper Air Tank"),
        S("Double-Capacity Copper Air Tank"),
        S("Triple-Capacity Copper Air Tank"),
    }) do

        if capacity <= unilib.setting.airtanks_capacity_max then

            unilib.pkg.shared_airtanks.register_tank({
                -- From airtanks:copper_tank (etc), airtanks:empty_copper_tank (etc). Creates
                --      unilib:device_airtank_copper_single,
                --      unilib:device_airtank_copper_single_empty (etc)
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
