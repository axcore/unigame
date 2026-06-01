---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    stonetechnic
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.meta_uchu_technic = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.stonetechnic.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.meta_uchu_technic.init()

    return {
        description = "Extra craft recipes for various items from technic",
        mod_depends = "technic",
        optional = {
            "brick_ordinary",
            "dye_basic",
            "machine_furnace_ordinary",
            "metal_chromiumt",
            "metal_iron_wrought",
            "mineral_diamond",
            "stone_desert",
            "stone_granite_salmon",
            "stone_marble_carrara",
        },
    }

end

function unilib.pkg.meta_uchu_technic.exec()

    local c_brick = "unilib:brick_ordinary_block"
    local c_chromium = "unilib:metal_chromium_ingot"
    local c_desert_stone = "unilib:stone_desert"
    local c_diamond = "unilib:mineral_diamond_gem"
    local c_furnace = "unilib:machine_furnace_ordinary"
    local c_granite = "unilib:stone_granite_salmon"
    local c_marble = "unilib:stone_marble_carrara"
    local c_steel = "unilib:metal_steel_ingot"
    local c_white_dye = "unilib:dye_white"

    if core.get_modpath("mesecons") then

        unilib.register_craft({
            output = "technic:lv_compressor",
            recipe = {
                {"group:smoothstone", "technic:motor", "group:smoothstone"},
                {"mesecons:piston", "technic:machine_casing", "mesecons:piston"},
                {"technic:fine_silver_wire", "technic:lv_cable", "technic:fine_silver_wire"},
            },
        })

    end

    unilib.register_craft({
        output = "technic:electric_furnace",
        recipe = {
            {"group:cobble", "group:cobble", "group:cobble"},
            {"group:cobble", "technic:machine_casing", "group:cobble"},
            {"group:cobble", "technic:lv_cable", "group:cobble"},
        },
    })

    if unilib.global.pkg_executed_table["machine_furnace_ordinary"] ~= nil then

        unilib.register_craft({
            output = "technic:lv_generator",
            recipe = {
                {"group:smoothstone", c_furnace, "group:smoothstone"},
                {"group:smoothstone", "technic:machine_casing", "group:smoothstone"},
                {"group:smoothstone", "technic:lv_cable", "group:smoothstone"},
            },
        })

    end

    if unilib.global.pkg_executed_table["mineral_diamond"] ~= nil and
            unilib.global.pkg_executed_table["stone_granite_salmon"] ~= nil then

        unilib.register_craft({
            output = "technic:geothermal",
            recipe = {
                {c_granite, c_diamond, c_granite},
                {"technic:fine_copper_wire", "technic:machine_casing", "technic:fine_copper_wire"},
                {c_granite, "technic:lv_cable", c_granite},
            },
        })

        if unilib.global.pkg_executed_table["stone_desert"] ~= nil then

            unilib.register_craft({
                output = "technic:lv_grinder",
                recipe = {
                    {c_desert_stone, c_diamond, c_desert_stone},
                    {c_desert_stone, "technic:machine_casing", c_desert_stone},
                    {c_granite, "technic:lv_cable", c_granite},
                },
            })

        end

    end

    if unilib.global.pkg_executed_table["metal_chromium"] ~= nil and
            unilib.global.pkg_executed_table["mineral_diamond"] ~= nil then

        unilib.register_craft({
            output = "technic:music_player",
            recipe = {
                {c_chromium, c_diamond, c_chromium},
                {c_diamond, "technic:machine_casing", c_diamond},
                {"group:mossycobble", "technic:lv_cable", "group:mossycobble"},
            }
        })

        if unilib.global.pkg_executed_table["stone_marble_carrara"] ~= nil then

            unilib.register_craft({
                output = "technic:water_mill",
                recipe = {
                    {c_marble, c_diamond, c_marble},
                    {"group:wood", "technic:machine_casing", "group:wood"},
                    {c_marble, "technic:lv_cable", c_marble},
                },
            })

        end

    end

    if unilib.global.pkg_executed_table["dye_basic"] ~= nil then

        unilib.register_craft({
            output = "technic:insulator_clip",
            recipe = {
                {"", c_white_dye, ""},
                {"", "technic:raw_latex", ""},
                {"technic:raw_latex", "group:smoothstone", "technic:raw_latex"},
            },
        })

    end

    unilib.register_craft({
        output = "technic:concrete 5",
        recipe = {
            {"group:smoothstone", "technic:rebar", "group:smoothstone"},
            {"technic:rebar", "group:smoothstone", "technic:rebar"},
            {"group:smoothstone", "technic:rebar", "group:smoothstone"},
        },
    })

    unilib.register_craft({
        output = "technic:concrete_post 12",
        recipe = {
            {"group:smoothstone", "technic:rebar", "group:smoothstone"},
            {"group:smoothstone", "technic:rebar", "group:smoothstone"},
            {"group:smoothstone", "technic:rebar", "group:smoothstone"},
        },
    })

    if unilib.global.pkg_executed_table["brick_ordinary"] ~= nil and
            unilib.global.pkg_executed_table["metal_iron_wrought"] ~= nil and
            unilib.global.pkg_executed_table["stone_granite_salmon"] ~= nil then

        unilib.register_craft({
            output = "technic:water_powered_grinder",
            recipe = {
                {c_granite, c_granite, c_granite},
                {c_granite, c_steel, c_granite},
                {c_brick, c_steel, c_brick},
            },
        })

    end

end
