---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    pedology
-- Code:    WTFPL
-- Media:   WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.liquid_water_fresh = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.pedology.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.liquid_water_fresh.init()

    return {
        description = "Fresh water",
        depends = "shared_pedology",
    }

end

function unilib.pkg.liquid_water_fresh.exec()

    -- (Creates unilib:bucket_steel_with_water_fresh, etc)
    unilib.register_liquid({
        -- Original to unilib
        part_name = "water_fresh",
        source_name = "unilib:liquid_water_fresh_source",
        flowing_name = "unilib:liquid_water_fresh_flowing",

        burntime = 0,
        craftable_flag = true,
        description = S("Fresh Water"),
        force_renew_flag = false,
        potable_flag = true,
        water_flag = true,
    })

    unilib.pkg.shared_pedology.register_liquid({
        -- From pedology:water_fresh_source, pedology:water_fresh_flowing. Creates
        --      unilib:liquid_water_fresh_source, unilib:liquid_water_fresh_flowing
        part_name = "water_fresh",
        source_orig_name = "pedology:water_fresh_source",
        flowing_orig_name = "pedology:water_fresh_flowing",

        replace_mode = mode,
        additional_table = {water = 1},
        damage_per_second = 0,
        drowning = 2,
        flowing_description = S("Flowing Fresh Water"),
        post_effect_color_table = {r = 100, b = 200, g = 100, a = 60},
        source_description = S("Fresh Water Source"),
        viscosity = 1,
    })

end
