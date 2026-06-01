---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    quartzmese
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.override_uchu_mesecons = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.quartzmese.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.override_uchu_mesecons.init()

    return {
        description = "Override craft recipes for various items from mesecons",
        mod_depends = "mesecons",
        optional = {
            "mineral_amethyst",
            "mineral_aquamarine",
            "mineral_emerald",
            "mineral_quartz_white",
        },
    }

end

function unilib.pkg.override_uchu_mesecons.exec()

    local c_amethyst = "unilib:mineral_amethyst_crystal"
    local c_aquamarine = "unilib:mineral_aquamarine_crystal"
    local c_conductor = "group:mesecon_conductor_craftable"
    local c_emerald = "unilib:mineral_emerald_gem"
    local c_quartz = "unilib:mineral_quartz_white_crystal"

    -- One craft recipe is removed altogether, with no replacement
    unilib.register_craft({
        output = "mesecons_materials:silicon 0",
        recipe = {
            {"group:sand", "group:sand"},
            {"group:sand", "default:steel_ingot"},
        },
    })

    if unilib.global.pkg_executed_table["mineral_aquamarine"] ~= nil and
            unilib.global.pkg_executed_table["mineral_emerald"] ~= nil then

        -- Override the old recipe...
        unilib.register_craft({
            output = "mesecons_solarpanel:solar_panel_off 0",
            recipe = {
                {"mesecons_materials:silicon", "mesecons_materials:silicon"},
                {"mesecons_materials:silicon", "mesecons_materials:silicon"},
            },
        })
        -- ...before replacing it with a new one
        unilib.register_craft({
            output = "mesecons_solarpanel:solar_panel_off 1",
            recipe = {
                {c_emerald, c_aquamarine},
                {c_aquamarine, c_emerald},
            },
        })

    end

    if unilib.global.pkg_executed_table["mineral_amethyst"] ~= nil then

        unilib.register_craft({
            output = "craft \"mesecons_microcontroller:microcontroller0000\" 0",
            recipe = {
                {"mesecons_materials:silicon", "mesecons_materials:silicon", c_conductor},
                {"mesecons_materials:silicon", "mesecons_materials:silicon", c_conductor},
                {c_conductor, c_conductor, ""},
            },
        })
        unilib.register_craft({
            output = "craft \"mesecons_microcontroller:microcontroller0000\" 2",
            recipe = {
                {c_amethyst, c_amethyst, c_conductor},
                {c_amethyst, c_amethyst, c_conductor},
                {c_conductor, c_conductor, ""},
            },
        })

    end

    if unilib.global.pkg_executed_table["mineral_aquamarine"] ~= nil then

        unilib.register_craft({
            output = "mesecons_fpga:fpga0000 0",
            recipe = {
                {c_conductor, c_conductor},
                {"mesecons_materials:silicon", "mesecons_materials:silicon"},
                {c_conductor, c_conductor},
            },
        })
        unilib.register_craft({
            output = "mesecons_fpga:fpga0000 2",
            recipe = {
                {c_conductor, c_conductor},
                {c_aquamarine, c_aquamarine},
                {c_conductor, c_conductor},
            },
        })

        unilib.register_craft({
            output = "mesecons_fpga:programmer 0",
            recipe = {
                {c_conductor},
                {"mesecons_materials:silicon"},
            },
        })
        unilib.register_craft({
            output = "mesecons_fpga:programmer",
            recipe = {
                {c_conductor},
                {c_aquamarine},
            },
        })

    end

    if unilib.global.pkg_executed_table["mineral_quartz_white"] ~= nil then

        unilib.register_craft({
            output = "mesecons_gates:and_off 0",
            recipe = {
                {"mesecons:mesecon", "", ""},
                {"", "mesecons_materials:silicon", "mesecons:mesecon"},
                {"mesecons:mesecon", "", ""},
            },
        })
        unilib.register_craft({
            output = "mesecons_gates:and_off",
            recipe = {
                {"mesecons:mesecon", "", ""},
                {"", c_quartz, "mesecons:mesecon"},
                {"mesecons:mesecon", "", ""},
            },
        })

        unilib.register_craft({
            output = "mesecons_gates:nand_off 0",
            recipe = {
                {"mesecons:mesecon", "", ""},
                {"", "mesecons_materials:silicon", "mesecons_torch:mesecon_torch_on"},
                {"mesecons:mesecon", "", ""},
            },
        })
        unilib.register_craft({
            output = "mesecons_gates:nand_off",
            recipe = {
                {"mesecons:mesecon", "", ""},
                {"", c_quartz, "mesecons_torch:mesecon_torch_on"},
                {"mesecons:mesecon", "", ""},
            },
        })

        unilib.register_craft({
            output = "mesecons_gates:xor_off 0",
            recipe = {
                {"mesecons:mesecon", "", ""},
                {"", "mesecons_materials:silicon", "mesecons_materials:silicon"},
                {"mesecons:mesecon", "", ""},
            },
        })
        unilib.register_craft({
            output = "mesecons_gates:xor_off",
            recipe = {
                {"mesecons:mesecon", "", ""},
                {"", c_quartz, c_quartz},
                {"mesecons:mesecon", "", ""},
            },
        })

    end

end
