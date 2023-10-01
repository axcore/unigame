---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    pedology
-- Code:    WTFPL
-- Media:   WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.dirt_silt_permeable_fine = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.pedology.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.dirt_silt_permeable_fine.init()

    return {
        description = "Fine permeable silt",
        depends = "shared_pedology",
    }

end

function unilib.pkg.dirt_silt_permeable_fine.exec()

    unilib.pkg.shared_pedology.register_permeable_set({
        -- From pedology:silt_fine_0, pedology:lump_silt_fine_0, etc. Creates
        --      unilib:dirt_silt_permeable_fine_0, unilib:dirt_silt_permeable_fine_lump_0 etc
        part_name = "dirt_silt_permeable_fine",
        orig_part_name = "silt_fine",
        node_description = S("Fine Permeable Silt"),
        lump_description = S("Fine Permeable Silt Lump"),
        melt_list = {2800, 2900, 3000, 3100, 3200, 3300},

        replace_mode = mode,
        additional_table = {crumbly = 3, sun_dry = 1},
        drop_count = 4,
        lump_max_wet = 3,
        node_max_wet = 3,
        ooze_chance = 1.25,
        ooze_interval = 45,
        overall_max_wet = 5,
        sound_table = {footstep = {name = "unilib_dirt_silt_permeable_footstep", gain = 0.3}},
    })

    unilib.pkg.shared_pedology.register_liquid({
        -- From pedology:silt_fine_4_source, pedology:silt_fine_4_flowing. Creates
        --      unilib:dirt_silt_permeable_fine_4, unilib:dirt_silt_permeable_fine_4_flowing
        part_name = "dirt_silt_permeable_fine_4",
        source_orig_name = "pedology:silt_fine_4_source",
        flowing_orig_name = "pedology:silt_fine_4_flowing",

        replace_mode = mode,
        additional_table = {oozing = 1, sucky = 1, wet = 4},
        damage_per_second = 0,
        drowning = 5,
        flowing_description = S("Flowing Muddy Fine Silt"),
        post_effect_color_table = {r = 137, g = 82, b = 0, a = 230},
        sludge_flag = true,
        source_description = S("Muddy Fine Silt Source"),
        viscosity = 6,
    })

    unilib.pkg.shared_pedology.register_liquid({
        -- From pedology:silt_fine_5_source, pedology:silt_fine_5_flowing. Creates
        --      unilib:dirt_silt_permeable_fine_5, unilib:dirt_silt_permeable_fine_5_flowing
        part_name = "dirt_silt_permeable_fine_5",
        source_orig_name = "pedology:silt_fine_5_source",
        flowing_orig_name = "pedology:silt_fine_5_flowing",

        replace_mode = mode,
        additional_table = {oozing = 1, wet = 5},
        damage_per_second = 0,
        drowning = 5,
        flowing_description = S("Flowing Fine Silt Slurry"),
        post_effect_color_table = {r = 179, g = 117, b = 59, a = 166},
        sludge_flag = true,
        source_description = S("Fine Silt Slurry Source"),
        viscosity = 4,
    })

end
