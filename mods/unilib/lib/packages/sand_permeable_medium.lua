---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    pedology
-- Code:    WTFPL
-- Media:   WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.sand_permeable_medium = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.pedology.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.sand_permeable_medium.init()

    return {
        description = "Medium permeable sand",
        depends = "shared_pedology",
    }

end

function unilib.pkg.sand_permeable_medium.exec()

    unilib.pkg.shared_pedology.register_permeable_set({
        -- From pedology:sand_medium_0, pedology:lump_sand_medium_0, etc. Creates
        --      unilib:sand_permeable_medium_0, unilib:sand_permeable_medium_lump_0 etc
        part_name = "sand_permeable_medium",
        orig_part_name = "sand_medium",
        node_description = S("Medium Permeable Sand"),
        lump_description = S("Medium Permeable Sand Pile"),
        melt_list = {990, 1100},

        replace_mode = mode,
        additional_table = {crumbly = 3, sand = 1, sun_dry = 1},
        drop_count = 2,
        lump_max_wet = 0,
        node_max_wet = 1,
        ooze_chance = 1.111111,
        ooze_interval = 5,
        overall_max_wet = 1,
        sound_table = {footstep = {name = "unilib_silt_permeable_footstep", gain = 0.35}},
    })

end
