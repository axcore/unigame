---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    anvil
-- Code:    GPL-3.0-only
-- Media:   GPL-3.0-only
---------------------------------------------------------------------------------------------------

unilib.pkg.shared_anvil = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.anvil.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_anvil.init()

    return {
        description = "Marks tools from external mods as unrepairable (from anvils)",
    }

end

function unilib.pkg.shared_anvil.exec()

    local tool_table = {
        -- Table last updated 8 Dec 2022
        -- Tools from technic, https://github.com/minetest-mods/technic
        --      and technic_plus, https://github.com/mt-mods/technic
        "technic:battery", S("This battery is too complex to be repaired"),
        "technic:blue_energy_crystal", S("This crystal is too exotic to be repaired"),
        "technic:chainsaw", S("This chainsaw is too complex to be repaired"),
        "technic:flashlight", S("This flashlight is too complex to be repaired"),
        "technic:green_energy_crystal", S("This crystal is too exotic to be repaired"),
        "technic:laser_mk1", S("This laser is too complex to be repaired"),
        "technic:laser_mk2", S("This laser is too complex to be repaired"),
        "technic:laser_mk3", S("This laser is too complex to be repaired"),
        "technic:lava_can", S("This can is too complex to be repaired"),
        "technic:mining_drill", S("This drill is too complex to be repaired"),
        "technic:mining_drill_mk2", S("This drill is too complex to be repaired"),
        "technic:mining_drill_mk2_1", S("This drill is too complex to be repaired"),
        "technic:mining_drill_mk2_2", S("This drill is too complex to be repaired"),
        "technic:mining_drill_mk2_3", S("This drill is too complex to be repaired"),
        "technic:mining_drill_mk2_4", S("This drill is too complex to be repaired"),
        "technic:mining_drill_mk3", S("This drill is too complex to be repaired"),
        "technic:mining_drill_mk3_1", S("This drill is too complex to be repaired"),
        "technic:mining_drill_mk3_2", S("This drill is too complex to be repaired"),
        "technic:mining_drill_mk3_3", S("This drill is too complex to be repaired"),
        "technic:mining_drill_mk3_4", S("This drill is too complex to be repaired"),
        "technic:mining_drill_mk3_5", S("This drill is too complex to be repaired"),
        "technic:prospector", S("This prospector is too complex to be repaired"),
        "technic:red_energy_crystal", S("This crystal is too exotic to be repaired"),
        "technic:river_water_can", S("This can is too complex to be repaired"),
        "technic:sonic_screwdriver", S("This screwdriver is too complex to be repaired"),
        "technic:treetap", S("This tap is too complex to be repaired"),
        "technic:vacuum", S("This vacuum is too complex to be repaired"),
        "technic:water_can", S("This can is too complex to be repaired"),
        -- Tools from technic addons,
        --      https://content.minetest.net/packages/Mineminer/technic_addons/
        "technic_addons:chainsawmk2", S("This chainsaw is too complex to be repaired"),
        "technic_addons:chainsawmk3", S("This chainsaw is too complex to be repaired"),
        "technic_addons:lava_largecan", S("This can is too complex to be repaired"),
        "technic_addons:lava_mediumcan", S("This can is too complex to be repaired"),
        "technic_addons:river_water_largecan", S("This can is too complex to be repaired"),
        "technic_addons:river_water_mediumcan", S("This can is too complex to be repaired"),
        "technic_addons:vacuummk2", S("This vacuum is too complex to be repaired"),
        "technic_addons:vacuummk3", S("This vacuum is too complex to be repaired"),
        "technic_addons:water_largecan", S("This can is too complex to be repaired"),
        "technic_addons:water_mediumcan", S("This can is too complex to be repaired"),
        -- Tools from techage modpack
        "ta4_jetpack:controller_off", S("This controller is too complex to be repaired"),
        "ta4_jetpack:controller_on", S("This controller is too complex to be repaired"),
        "ta4_jetpack:jetpack_material", S("This jetpack is too complex to be repaired"),
    }

    for k, v in pairs(tool_table) do
        unilib.tools.register_no_repair(k, v)
    end

end
