---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    pedology
-- Code:    WTFPL
-- Media:   WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.dirt_peat_permeable_sapric = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.pedology.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.dirt_peat_permeable_sapric.init()

    return {
        description = "Permeable sapric peat",
    }

end

function unilib.pkg.dirt_peat_permeable_sapric.exec()

    unilib.pkg.shared_pedology.register_permeable_set({
        -- From pedology:turf_sapric_0, pedology:lump_turf_sapric_0, etc. Creates
        --      unilib:dirt_peat_permeable_sapric_0, unilib:dirt_peat_permeable_sapric_lump_0 etc
        part_name = "dirt_peat_permeable_sapric",
        orig_part_name = "turf_sapric",
        node_description = S("Permeable Sapric Peat"),
        lump_description = S("Permeable Sapric Peat Cutting"),
        melt_list = {1200, 1300, 1400},

        replace_mode = mode,
        additional_table = {[0] = {crumbly = 3, flammable = 1}, {crumbly = 3}, {crumbly = 3}},
        drop_count = 2,
        lump_max_wet = 2,
        node_max_wet = 2,
        ooze_chance = 1.2,
        ooze_interval = 240,
        overall_max_wet = 2,
        sound_table = {footstep = {name = "unilib_dirt_peat_permeable_footstep", gain = 0.2}},
    })
    unilib.register_craft({
        -- From pedology:turf_sapric_0
        type = "fuel",
        recipe = "unilib:dirt_peat_permeable_sapric_0",
        burntime = 300,
    })
    unilib.register_craft({
        -- From pedology:lump_turf_sapric_0
        type = "fuel",
        recipe = "unilib:dirt_peat_permeable_sapric_lump_0",
        burntime = 30,
    })

end
