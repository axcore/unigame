---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    pedology
-- Code:    WTFPL
-- Media:   WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.gravel_permeable_fine = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.pedology.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.gravel_permeable_fine.init()

    return {
        description = "Fine permeable gravel",
        depends = "shared_pedology",
    }

end

function unilib.pkg.gravel_permeable_fine.exec()

    unilib.pkg.shared_pedology.register_permeable_set({
        -- From pedology:gravel_fine_0, pedology:lump_gravel_fine_0, etc. Creates
        --      unilib:gravel_permeable_fine_0, unilib:gravel_permeable_fine_lump_0 etc
        part_name = "gravel_permeable_fine",
        orig_part_name = "gravel_fine",
        node_description = S("Fine Permeable Gravel"),
        lump_description = S("Fine Permeable Gravel Pebbles"),
        melt_list = {670, 770},

        replace_mode = mode,
        additional_table = {crumbly = 2, sun_dry = 1},
        drop_count = 9,
        lump_max_wet = 0,
        node_max_wet = 1,
        ooze_chance = 1,
        ooze_interval = 2,
        overall_max_wet = 1,
        sound_table = {footstep = {name = "unilib_gravel_permeable_footstep", gain = 1}},
    })

end
