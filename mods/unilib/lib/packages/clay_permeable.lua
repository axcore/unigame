---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    pedology
-- Code:    WTFPL
-- Media:   WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.clay_permeable = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.pedology.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.clay_permeable.init()

    return {
        description = "Permeable clay",
        depends = "shared_pedology",
    }

end

function unilib.pkg.clay_permeable.exec()

    unilib.pkg.shared_pedology.register_permeable_set({
        -- From pedology:clay_0, pedology:lump_clay_0, etc. Creates unilib:clay_permeable_0,
        --      unilib:clay_permeable_lump_0 etc
        part_name = "clay_permeable",
        orig_part_name = "clay",
        node_description = S("Permeable Clay"),
        lump_description = S("Permeable Clay Lump"),
        melt_list = {3000, 3100, 3200, 3500, 3550, 3600},

        replace_mode = mode,
        additional_table = {crumbly = 3, sun_dry = 1},
        drop_count = 4,
        lump_max_wet = 3,
        node_max_wet = 3,
        ooze_chance = 1.25,
        ooze_interval = 60,
        overall_max_wet = 5,
        sound_table = {footstep = {name = "unilib_clay_permeable_footstep", gain = 0.5}},
    })

    unilib.pkg.shared_pedology.register_liquid({
        -- From pedology:clay_4_source, pedology:clay_4_flowing. Creates unilib:clay_permeable_4,
        --      unilib:clay_permeable_4_flowing
        part_name = "clay_permeable_4",
        source_orig_name = "pedology:clay_4_source",
        flowing_orig_name = "pedology:clay_4_flowing",

        replace_mode = mode,
        additional_table = {oozing = 1, sucky = 1, wet = 4},
        damage_per_second = 0,
        drowning = 5,
        flowing_description = S("Flowing Muddy Clay"),
        rgb_table = {r = 123, g = 57, b = 6, a = 240},
        sludge_flag = true,
        source_description = S("Muddy Clay Source"),
        viscosity = 6,
    })

    unilib.pkg.shared_pedology.register_liquid({
        -- From pedology:clay_5_source, pedology:clay_5_flowing. Creates unilib:clay_permeable_5,
        --      unilib:clay_permeable_5_flowing
        part_name = "clay_permeable_5",
        source_orig_name = "pedology:clay_5_source",
        flowing_orig_name = "pedology:clay_5_flowing",

        replace_mode = mode,
        additional_table = {oozing = 1, wet = 5},
        damage_per_second = 0,
        drowning = 5,
        flowing_description = S("Flowing Clay Slurry"),
        rgb_table = {r = 123, g = 85, b = 73, a = 176},
        sludge_flag = true,
        source_description = S("Clay Slurry Source"),
        viscosity = 4,
    })

end
