---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    pedology
-- Code:    WTFPL
-- Media:   WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.dirt_silt_permeable_coarse = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.pedology.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.dirt_silt_permeable_coarse.init()

    return {
        description = "Coarse permeable silt",
        depends = "shared_pedology",
    }

end

function unilib.pkg.dirt_silt_permeable_coarse.exec()

    unilib.pkg.shared_pedology.register_permeable_set({
        -- From pedology:silt_coarse_0, pedology:lump_silt_coarse_0, etc. Creates
        --      unilib:dirt_silt_permeable_coarse_0, unilib:dirt_silt_permeable_coarse_lump_0 etc
        part_name = "dirt_silt_permeable_coarse",
        orig_part_name = "silt_coarse",
        node_description = S("Coarse Permeable Silt"),
        lump_description = S("Coarse Permeable Silt Lump"),
        melt_list = {2000, 2200, 2400, 2800},

        replace_mode = mode,
        additional_table = {crumbly = 3, sun_dry = 1},
        drop_count = 2,
        lump_max_wet = 3,
        node_max_wet = 3,
        ooze_chance = 1.25,
        ooze_interval = 20,
        overall_max_wet = 3,
        sound_table = {footstep = {name = "unilib_dirt_silt_permeable_footstep", gain = 0.4}},
    })

end
