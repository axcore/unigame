---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    gemenergy
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.override_uchu_technic = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.gemenergy.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.override_uchu_technic.init()

    return {
        description = "Override craft recipes for various items from technic",
        mod_depends = "technic",
        optional = {
            "glass_obsidian",
            "metal_brass",
            "metal_copper",
            "metal_gold",
            "metal_mithril",
            "metal_silver",
            "metal_steel_carbon",
            "mineral_diamond",
            "mineral_emerald",
            "mineral_ruby",
            "mineral_sapphire",
        },
    }

end

function unilib.pkg.override_uchu_technic.exec()

    local c_brass = "unilib:metal_brass_ingot"
    local c_carbon_steel = "unilib:metal_steel_carbon_ingot"
    local c_copper = "unilib:metal_copper_ingot"
    local c_diamond_block = "unilib:mineral_diamond_block"
    local c_emerald = "unilib:mineral_emerald_gem"
    local c_glass = "unilib:glass_obsidian"
    local c_gold = "unilib:metal_gold_ingot"
    local c_mithril = "unilib:metal_mithril_ingot"
    local c_ruby = "unilib:mineral_ruby_gem"
    local c_sapphire = "unilib:mineral_sapphire_gem"
    local c_silver = "unilib:metal_silver_ingot"

    if unilib.global.pkg_executed_table["metal_mithril"] ~= nil and
            unilib.global.pkg_executed_table["mineral_sapphire"] ~= nil then

        -- Override the old recipe...
        unilib.register_craft({
            output = "technic:blue_energy_crystal 0",
            recipe = {
                {"moreores:mithril_ingot", "technic:battery", "dye:blue"},
                {"technic:battery", "technic:green_energy_crystal", "technic:battery"},
                {"dye:blue", "technic:battery", "moreores:mithril_ingot"},
            },
        })
        -- ...before replacing it with a new one
        unilib.register_craft({
            output = "technic:blue_energy_crystal",
            recipe = {
                {c_mithril, "technic:battery", c_sapphire},
                {"technic:battery", "technic:green_energy_crystal", "technic:battery"},
                {c_sapphire, "technic:battery", c_mithril},
            },
        })

    end

    if unilib.global.pkg_executed_table["metal_gold"] ~= nil and
            unilib.global.pkg_executed_table["mineral_emerald"] ~= nil then

        unilib.register_craft({
            output = "technic:green_energy_crystal 0",
            recipe = {
                {"default:gold_ingot", "technic:battery", "dye:green"},
                {"technic:battery", "technic:red_energy_crystal", "technic:battery"},
                {"dye:green", "technic:battery", "default:gold_ingot"},
            },
        })
        unilib.register_craft({
            output = "technic:green_energy_crystal",
            recipe = {
                {c_gold, "technic:battery", c_emerald},
                {"technic:battery", "technic:red_energy_crystal", "technic:battery"},
                {c_emerald, "technic:battery", c_gold},
            },
        })

    end

    if unilib.global.pkg_executed_table["metal_silver"] ~= nil and
            unilib.global.pkg_executed_table["mineral_diamond"] ~= nil and
            unilib.global.pkg_executed_table["mineral_ruby"] ~= nil then

        unilib.register_craft({
            output = "technic:red_energy_crystal 0",
            recipe = {
                {"moreores:silver_ingot", "technic:battery", "dye:red"},
                {"technic:battery", "default:diamondblock", "technic:battery"},
                {"dye:red", "technic:battery", "moreores:silver_ingot"},
            },
        })
        unilib.register_craft({
            output = "technic:red_energy_crystal",
            recipe = {
                {c_silver, "technic:battery", c_ruby},
                {"technic:battery", c_diamond_block, "technic:battery"},
                {c_ruby, "technic:battery", c_silver},
            },
        })

    end

    if unilib.global.pkg_executed_table["glass_obsidian"] ~= nil and
            unilib.global.pkg_executed_table["metal_brass"] ~= nil and
            unilib.global.pkg_executed_table["metal_copper"] ~= nil and
            unilib.global.pkg_executed_table["mineral_ruby"] ~= nil then

        unilib.register_craft({
            output = "technic:laser_mk1 0",
            recipe = {
                {"default:diamond", "technic:brass_ingot", "default:obsidian_glass"},
                {"", "technic:brass_ingot", "technic:red_energy_crystal"},
                {"", "", "default:copper_ingot"},
            },
        })
        unilib.register_craft({
            output = "technic:laser_mk1",
            recipe = {
                {c_ruby, c_brass, c_glass},
                {"", c_brass, "technic:red_energy_crystal"},
                {"", "", c_copper},
            },
        })

    end

    if unilib.global.pkg_executed_table["metal_copper"] ~= nil and
            unilib.global.pkg_executed_table["metal_steel_carbon"] ~= nil and
            unilib.global.pkg_executed_table["mineral_emerald"] ~= nil then

        unilib.register_craft({
            output = "technic:laser_mk2 0",
            recipe = {
                {"default:diamond", "technic:carbon_steel_ingot", "technic:laser_mk1"},
                {"", "technic:carbon_steel_ingot", "technic:green_energy_crystal"},
                {"", "", "default:copper_ingot"},
            },
        })
        unilib.register_craft({
            output = "technic:laser_mk2",
            recipe = {
                {c_emerald, c_carbon_steel, "technic:laser_mk1"},
                {"", c_carbon_steel, "technic:green_energy_crystal"},
                {"", "", c_copper},
            },
        })

    end

    if unilib.global.pkg_executed_table["metal_copper"] ~= nil and
            unilib.global.pkg_executed_table["metal_steel_carbon"] ~= nil and
            unilib.global.pkg_executed_table["mineral_sapphire"] ~= nil then

        unilib.register_craft({
            output = "technic:laser_mk3 0",
            recipe = {
                {"default:diamond", "technic:carbon_steel_ingot", "technic:laser_mk2"},
                {"", "technic:carbon_steel_ingot", "technic:blue_energy_crystal"},
                {"", "", "default:copper_ingot"},
            },
        })
        unilib.register_craft({
            output = "technic:laser_mk3",
            recipe = {
                {c_sapphire, c_carbon_steel, "technic:laser_mk2"},
                {"", c_carbon_steel, "technic:blue_energy_crystal"},
                {"", "", c_copper},
            },
        })

    end

end
