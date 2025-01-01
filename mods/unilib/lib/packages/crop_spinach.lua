---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    better_farming
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.crop_spinach = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.better_farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.crop_spinach.init()

    return {
        description = "Spinach",
        optional = "dye_basic",
    }

end

function unilib.pkg.crop_spinach.exec()

    local fertility_list = {"ordinary_soil"}

    local orig_name_list = {}
    for i = 1, 4 do
        table.insert(orig_name_list, "better_farming:spinach_" .. i)
    end

    unilib.register_crop_mtgame({
        -- From better_farming:spinach (creates unilib:crop_spinach_harvest),
        --      better_farming:seed_spinach (creates unilib:crop_spinach_seed),
        --      better_farming:spinach_1 etc (creates unilib:crop_spinach_grow_1 etc)
        part_name = "spinach",
        grow_orig_name = orig_name_list,
        harvest_orig_name = "better_farming:spinach",
        seed_orig_name = "better_farming:seed_spinach",
        steps = 4,

        replace_mode = mode,
        eat = 1,
        fertility_list = fertility_list,
        harvest_description = S("Spinach"),
        harvest_group_table = {flammable = 3, food_spinach = 1},
        min_light = 7,
        seed_description = S("Spinach Seed"),
        seed_group_table = {attached_node = 1, flammable = 2, seed = 1, snappy = 3},
    })
    if unilib.setting.dye_from_crops_flag and
            unilib.global.pkg_executed_table["dye_basic"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            output = "unilib:dye_green_dark 2",
            recipe = {
                {"unilib:crop_spinach_harvest"},
            },
        })

    end

    unilib.register_juice({
        ingredient = "unilib:crop_spinach_harvest",
        juice_description = S("Spinach"),
        juice_type = "spinach",
        rgb = "#324a17",

        orig_flag = false,
    })

    unilib.register_decoration_generic("better_farming_crop_spinach", {
        -- From better_farming:spinach_4
        deco_type = "simple",
        decoration = "unilib:crop_spinach_grow_4",

        noise_params = {
            octaves = 3,
            offset = -0.1,
            persist = 0.7,
            -- N.B. scale was 0.1 in original code
            scale = 0.001,
            seed = 11548,
            spread = {x = 50, y = 50, z = 50},
        },
        param2 = 3,
        sidelen = 16,
    })

end
