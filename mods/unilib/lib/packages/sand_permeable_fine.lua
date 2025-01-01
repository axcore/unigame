---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    pedology
-- Code:    WTFPL
-- Media:   WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.sand_permeable_fine = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.pedology.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.sand_permeable_fine.init()

    return {
        description = "Fine permeable sand",
        depends = "shared_pedology",
    }

end

function unilib.pkg.sand_permeable_fine.exec()

    unilib.pkg.shared_pedology.register_permeable_set({
        -- From pedology:sand_fine_0, pedology:lump_sand_fine_0, etc. Creates
        --      unilib:sand_permeable_fine_0, unilib:sand_permeable_fine_lump_0 etc
        part_name = "sand_permeable_fine",
        orig_part_name = "sand_fine",
        node_description = S("Fine Permeable Sand"),
        lump_description = S("Fine Permeable Sand Pile"),
        melt_list = {1100, 1200, 1300},

        replace_mode = mode,
        additional_table = {crumbly = 3, sand = 1, sun_dry = 1},
        drop_count = 2,
        lump_max_wet = 0,
        node_max_wet = 2,
        ooze_chance = 1.111111,
        ooze_interval = 10,
        overall_max_wet = 2,
        sound_table = {footstep = {name = "unilib_sand_permeable_footstep", gain = 0.2}},
    })

end
