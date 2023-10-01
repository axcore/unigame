---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    pedology
-- Code:    WTFPL
-- Media:   WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.dirt_peat_permeable_hemic = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.pedology.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.dirt_peat_permeable_hemic.init()

    return {
        description = "Permeable hemic peat",
    }

end

function unilib.pkg.dirt_peat_permeable_hemic.exec()

    unilib.pkg.shared_pedology.register_permeable_set({
        -- From pedology:turf_hemic_0, pedology:lump_turf_hemic_0, etc. Creates
        --      unilib:dirt_peat_permeable_hemic_0, unilib:dirt_peat_permeable_hemic_lump_0 etc
        part_name = "dirt_peat_permeable_hemic",
        orig_part_name = "turf_hemic",
        node_description = S("Permeable Hemic Peat"),
        lump_description = S("Permeable Hemic Peat Cutting"),
        melt_list = {1100, 1200, 1300},

        replace_mode = mode,
        additional_table = {[0] = {crumbly = 3, flammable = 1}, {crumbly = 3}, {crumbly = 3}},
        drop_count = 3,
        lump_max_wet = 2,
        node_max_wet = 2,
        ooze_chance = 1.225,
        ooze_interval = 180,
        overall_max_wet = 2,
        sound_table = {footstep = {name = "unilib_dirt_peat_permeable_footstep", gain = 0.24}},
    })
    unilib.register_craft({
        -- From pedology:turf_hemic_0
        type = "fuel",
        recipe = "unilib:dirt_peat_permeable_hemic_0",
        burntime = 200,
    })
    unilib.register_craft({
        -- From pedology:lump_turf_hemic_0
        type = "fuel",
        recipe = "unilib:dirt_peat_permeable_hemic_lump_0",
        burntime = 20,
    })

end
