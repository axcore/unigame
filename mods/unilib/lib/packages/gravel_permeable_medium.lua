---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    pedology
-- Code:    WTFPL
-- Media:   WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.gravel_permeable_medium = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.pedology.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.gravel_permeable_medium.init()

    return {
        description = "Medium permeable gravel",
        depends = "shared_pedology",
    }

end

function unilib.pkg.gravel_permeable_medium.exec()

    unilib.pkg.shared_pedology.register_permeable_set({
        -- From pedology:gravel_medium_0, pedology:lump_gravel_medium_0, etc. Creates
        --      unilib:gravel_permeable_medium_0, unilib:gravel_permeable_medium_lump_0 etc
        part_name = "gravel_permeable_medium",
        orig_part_name = "gravel_medium",
        node_description = S("Medium Permeable Gravel"),
        lump_description = S("Medium Permeable Gravel Pebbles"),
        melt_list = {600, 800, 1250},

        replace_mode = mode,
        additional_table = {crumbly = 2, sun_dry = 1},
        drop_count = 3,
        lump_max_wet = 0,
        node_max_wet = 2,
        ooze_chance = 1,
        ooze_interval = 1.5,
        overall_max_wet = 2,
        sound_table = {footstep = {name = "unilib_gravel_permeable_footstep", gain = 1}},
    })

end
