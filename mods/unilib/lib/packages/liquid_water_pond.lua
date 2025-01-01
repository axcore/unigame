---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    pedology
-- Code:    WTFPL
-- Media:   WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.liquid_water_pond = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.pedology.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.liquid_water_pond.init()

    return {
        description = "Pond water",
        depends = "shared_pedology",
    }

end

function unilib.pkg.liquid_water_pond.exec()

    -- (Creates unilib:bucket_steel_with_water_pond, etc)
    unilib.register_liquid({
        -- Original to unilib
        part_name = "water_pond",
        source_name = "unilib:liquid_water_pond_source",
        flowing_name = "unilib:liquid_water_pond_flowing",

        burntime = 0,
        craftable_flag = true,
        description = S("Pond Water"),
        force_renew_flag = false,
        water_flag = true,
    })

    unilib.pkg.shared_pedology.register_liquid({
        -- From pedology:water_pond_source, pedology:water_pond_flowing. Creates
        --      unilib:liquid_water_pond_source, unilib:liquid_water_pond_flowing
        part_name = "water_pond",
        source_orig_name = "pedology:water_pond_source",
        flowing_orig_name = "pedology:water_pond_flowing",

        replace_mode = mode,
        additional_table = {water = 1},
        damage_per_second = 0,
        drowning = 3,
        flowing_description = S("Flowing Pond Water"),
        rgb_table = {r = 85, g = 85, g = 60, a = 128},
        source_description = S("Pond Water Source"),
        viscosity = 4,
    })

end
