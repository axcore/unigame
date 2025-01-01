---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    pedology
-- Code:    WTFPL
-- Media:   WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.gravel_permeable_coarse = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.pedology.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.gravel_permeable_coarse.init()

    return {
        description = "Coarse permeable gravel",
        depends = "shared_pedology",
    }

end

function unilib.pkg.gravel_permeable_coarse.exec()

    unilib.pkg.shared_pedology.register_permeable_set({
        -- From pedology:gravel_coarse_0, pedology:lump_gravel_coarse_0, etc. Creates
        --      unilib:gravel_permeable_coarse_0, unilib:gravel_permeable_coarse_lump_0 etc
        part_name = "gravel_permeable_coarse",
        orig_part_name = "gravel_coarse",
        node_description = S("Coarse Permeable Gravel"),
        lump_description = S("Coarse Permeable Gravel Pebbles"),
        melt_list = {500, 750, 1000},

        replace_mode = mode,
        additional_table = {crumbly = 1, sun_dry = 1},
        drop_count = 1,
        lump_max_wet = 0,
        node_max_wet = 2,
        ooze_chance = 1,
        ooze_interval = 1,
        overall_max_wet = 2,
        sound_table = {footstep = {name = "unilib_gravel_permeable_footstep", gain = 1}},
    })

end
