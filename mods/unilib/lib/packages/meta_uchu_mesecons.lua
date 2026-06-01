---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    stonemese
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.meta_uchu_mesecons = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.stonemese.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.meta_uchu_mesecons.init()

    return {
        description = "Extra craft recipes for various items from mesecons",
        mod_depends = "mesecons",
        optional = {"container_chest_ordinary", "item_stick_ordinary", "metal_steel"},
    }

end

function unilib.pkg.meta_uchu_mesecons.exec()

    local c_chest = "unilib:container_chest_ordinary"
    local c_conductor = "group:mesecon_conductor_craftable"
    local c_steel = "unilib:metal_steel_ingot"
    local c_stick = "unilib:item_stick_ordinary"

    unilib.register_craft({
        output = "mesecons_random:removestone 4",
        recipe = {
            {"", "group:cobble", ""},
            {"group:cobble", c_conductor, "group:cobble"},
            {"", "group:cobble", ""},
        },
    })

    if unilib.global.pkg_executed_table["metal_steel"] ~= nil then

        unilib.register_craft({
            output = "mesecons_random:ghoststone 4",
            recipe = {
                {c_steel, "group:cobble", c_steel},
                {"group:cobble", c_conductor, "group:cobble"},
                {c_steel, "group:cobble", c_steel},
            },
        })

    end

    unilib.register_craft({
        output = "mesecons_button:button_off 2",
        recipe = {
            {c_conductor, "group:smoothstone"},
        },
    })

    unilib.register_craft({
        output = "mesecons_pressureplates:pressure_plate_stone_off",
        recipe = {
            {"group:cobble", "group:cobble"},
        },
    })

    unilib.register_craft({
        output = "mesecons_movestones:movestone 2",
        recipe = {
            {"group:smoothstone", "group:smoothstone", "group:smoothstone"},
            {c_conductor, c_conductor, c_conductor},
            {"group:smoothstone", "group:smoothstone", "group:smoothstone"},
        },
    })

    if unilib.global.pkg_executed_table["item_stick_ordinary"] ~= nil then

        unilib.register_craft({
            output = "mesecons_walllever:wall_lever_off 2",
            recipe = {
                {c_conductor},
                {"group:smoothstone"},
                {c_stick},
            },
        })

    end

    if unilib.global.pkg_executed_table["metal_steel"] ~= nil then

        unilib.register_craft({
            output = "mesecons_switch:mesecon_switch_off 2",
            recipe = {
                {c_steel, "group:cobble", c_steel},
                {c_conductor, "", c_conductor},
            }
        })

    end

    unilib.register_craft({
        output = "mesecons_delayer:delayer_off_1",
        recipe = {
            {"mesecons_torch:mesecon_torch_on", c_conductor, "mesecons_torch:mesecon_torch_on"},
            {"group:cobble", "group:cobble", "group:cobble"},
        },
    })

    if unilib.global.pkg_executed_table["metal_steel"] ~= nil then

        unilib.register_craft({
            output = "mesecons_pistons:piston_normal_off 2",
            recipe = {
                {"group:wood", "group:wood", "group:wood"},
                {"group:cobble", c_steel, "group:cobble"},
                {"group:cobble", c_conductor, "group:cobble"},
            },
        })

    end

    unilib.register_craft({
        output = "pipeworks:deployer_off",
        recipe = {
            {"group:wood", c_chest, "group:wood"},
            {"group:smoothstone", "mesecons:piston", "group:smoothstone"},
            {"group:smoothstone", "mesecons:mesecon", "group:smoothstone"},
        },
    })

end
