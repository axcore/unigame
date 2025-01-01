---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    pedology
-- Code:    WTFPL
-- Media:   WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.dirt_peat_permeable_fibric = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.pedology.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.dirt_peat_permeable_fibric.init()

    return {
        description = "Permeable fibric peat",
    }

end

function unilib.pkg.dirt_peat_permeable_fibric.exec()

    unilib.pkg.shared_pedology.register_permeable_set({
        -- From pedology:turf_fibric_0, pedology:lump_turf_fibric_0, etc. Creates
        --      unilib:dirt_peat_permeable_fibric_0, unilib:dirt_peat_permeable_fibric_lump_0 etc
        part_name = "dirt_peat_permeable_fibric",
        orig_part_name = "turf_fibric",
        node_description = S("Permeable Fibric Peat"),
        lump_description = S("Permeable Fibric Peat Cutting"),
        melt_list = {1000, 1100, 1200},

        replace_mode = mode,
        additional_table = {[0] = {crumbly = 3, flammable = 1}, {crumbly = 3}, {crumbly = 3}},
        drop_count = 4,
        lump_max_wet = 2,
        node_max_wet = 2,
        ooze_chance = 1.25,
        ooze_interval = 120,
        overall_max_wet = 2,
        sound_table = {footstep = {name = "unilib_dirt_peat_permeable_footstep", gain = 0.28}},
    })
    unilib.register_craft({
        -- From pedology:turf_fibric_0
        type = "fuel",
        recipe = "unilib:dirt_peat_permeable_fibric_0",
        burntime = 100,
    })
    unilib.register_craft({
        -- From pedology:lump_turf_fibric_0
        type = "fuel",
        recipe = "unilib:dirt_peat_permeable_fibric_lump_0",
        burntime = 10,
    })

end
