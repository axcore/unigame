---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    pedology
-- Code:    WTFPL
-- Media:   WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.sand_permeable_coarse = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.pedology.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.sand_permeable_coarse.init()

    return {
        description = "Coarse permeable sand",
        depends = "shared_pedology",
    }

end

function unilib.pkg.sand_permeable_coarse.exec()

    unilib.pkg.shared_pedology.register_permeable_set({
        -- From pedology:sand_coarse_0, pedology:lump_sand_coarse_0, etc. Creates
        --  unilib:sand_permeable_coarse_0, unilib:sand_permeable_coarse_lump_0 etc
        part_name = "sand_permeable_coarse",
        orig_part_name = "sand_coarse",
        node_description = S("Coarse Permeable Sand"),
        lump_description = S("Coarse Permeable Sand Pile"),
        melt_list = {900},

        replace_mode = mode,
        additional_table = {crumbly = 3, sand = 1, sun_dry = 1},
        drop_count = 1,
        lump_max_wet = 0,
        node_max_wet = 0,
        ooze_chance = nil,
        ooze_interval = nil,
        overall_max_wet = 0,
        sound_table = {footstep = {name = "unilib_sand_permeable_footstep", gain = 0.3}},
    })

end
