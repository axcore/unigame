---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    pedology
-- Code:    WTFPL
-- Media:   WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.dirt_silt_permeable_medium = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.pedology.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.dirt_silt_permeable_medium.init()

    return {
        description = "Medium permeable silt",
        depends = "shared_pedology",
    }

end

function unilib.pkg.dirt_silt_permeable_medium.exec()

    unilib.pkg.shared_pedology.register_permeable_set({
        -- From pedology:silt_medium_0, pedology:lump_silt_medium_0, etc. Creates
        --      unilib:dirt_silt_permeable_medium_0, unilib:dirt_silt_permeable_medium_lump_0 etc
        part_name = "dirt_silt_permeable_medium",
        orig_part_name = "silt_medium",
        node_description = S("Medium Permeable Silt"),
        lump_description = S("Medium Permeable Silt Lump"),
        melt_list = {2600, 2800, 3200, 3800, 4200},

        replace_mode = mode,
        additional_table = {crumbly = 3, sun_dry = 1},
        drop_count = 4,
        lump_max_wet = 3,
        node_max_wet = 3,
        ooze_chance = 1.25,
        ooze_interval = 30,
        overall_max_wet = 4,
        sound_table = {footstep = {name = "unilib_dirt_silt_permeable_footstep", gain = 0.35}},
    })

    unilib.pkg.shared_pedology.register_liquid({
        -- From pedology:silt_medium_4_source, pedology:silt_medium_4_flowing. Creates
        --      unilib:dirt_silt_permeable_medium_4, unilib:dirt_silt_permeable_medium_4_flowing
        part_name = "dirt_silt_permeable_medium_4",
        source_orig_name = "pedology:silt_medium_4_source",
        flowing_orig_name = "pedology:silt_medium_4_flowing",

        replace_mode = mode,
        additional_table = {oozing = 1, wet = 4},
        damage_per_second = 0,
        drowning = 5,
        flowing_description = S("Flowing Muddy Medium Permeable Silt"),
        post_effect_color_table = {r = 165, g = 131, b = 0, a = 220},
        sludge_flag = true,
        source_description = S("Muddy Medium Permeable Silt Source"),
        viscosity = 6,
    })

end
