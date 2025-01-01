---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    better_farming
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.crop_pepper_rocoto = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.better_farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.crop_pepper_rocoto.init()

    return {
        description = "Rocoto pepper",
        optional = "dye_basic",
    }

end

function unilib.pkg.crop_pepper_rocoto.exec()

    local fertility_list = {"ordinary_soil"}

    local orig_name_list = {}
    for i = 1, 5 do
        table.insert(orig_name_list, "better_farming:pepper_" .. i)
    end

    unilib.register_crop_mtgame({
        -- From better_farming:pepper (creates unilib:crop_pepper_rocoto_harvest),
        --      better_farming:seed_pepper (creates unilib:crop_pepper_rocoto_seed),
        --      better_farming:pepper_1 etc (creates unilib:crop_pepper_rocoto_grow_1 etc)
        part_name = "pepper_rocoto",
        grow_orig_name = orig_name_list,
        harvest_orig_name = "better_farming:pepper",
        seed_orig_name = "better_farming:seed_pepper",
        steps = 5,

        replace_mode = mode,
        eat = 2,
        fertility_list = fertility_list,
        harvest_description = S("Rocoto Pepper"),
        -- N.B. food_pepper not in original code
        harvest_group_table = {flammable = 4, food_pepper = 1},
        min_light = 7,
        seed_description = S("Rocoto Pepper Seed"),
        seed_group_table = {attached_node = 1, flammable = 2, seed = 1, snappy = 3},
    })
    if unilib.setting.dye_from_crops_flag and
            unilib.global.pkg_executed_table["dye_basic"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            output = "unilib:dye_red 2",
            recipe = {
                {"unilib:crop_pepper_rocoto_harvest"},
            },
        })

    end

    unilib.register_juice({
        ingredient = "unilib:crop_pepper_rocoto_harvest",
        juice_description = S("Pepper"),
        juice_type = "pepper",
        rgb = "#e53200",

        orig_flag = false,
    })

    unilib.register_decoration_generic("better_farming_crop_pepper_rocoto", {
        -- From better_farming:pepper_5
        deco_type = "simple",
        decoration = "unilib:crop_pepper_rocoto_grow_5",

        noise_params = {
            octaves = 3,
            offset = -0.1,
            persist = 0.7,
            -- N.B. scale was 0.1 in original code
            scale = 0.001,
            seed = 1985,
            spread = {x = 50, y = 50, z = 50},
        },
        param2 = 3,
        sidelen = 16,
    })

end
