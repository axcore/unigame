---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    better_farming
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.crop_strawberry_gariguette = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.better_farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.crop_strawberry_gariguette.init()

    return {
        description = "Gariguette Strawberry",
        optional = "dye_basic",
    }

end

function unilib.pkg.crop_strawberry_gariguette.exec()

    local fertility_list = {"ordinary_soil"}

    local orig_name_list = {}
    for i = 1, 8 do
        table.insert(orig_name_list, "better_farming:strawberry_" .. i)
    end

    unilib.register_crop_mtgame({
        -- From better_farming:strawberry (creates unilib:crop_strawberry_gariguette_harvest),
        --      better_farming:seed_strawberry (creates unilib:crop_strawberry_gariguette_seed),
        --      better_farming:strawberry_1 etc (creates
        --      unilib:crop_strawberry_gariguette_grow_1 etc)
        part_name = "strawberry_gariguette",
        grow_orig_name = orig_name_list,
        harvest_orig_name = "better_farming:strawberry",
        seed_orig_name = "better_farming:seed_strawberry",
        steps = 8,

        replace_mode = mode,
        eat = 3,
        fertility_list = fertility_list,
        harvest_description = S("Gariguette Strawberry"),
        -- N.B. food_strawberry not in original code
        harvest_group_table = {flammable = 4, food_strawberry = 1},
        min_light = 7,
        seed_description = S("Gariguette Strawberry Seed"),
        seed_group_table = {attached_node = 1, flammable = 2, seed = 1, snappy = 3},
    })
    if unilib.setting.dye_from_crops_flag and
            unilib.global.pkg_executed_table["dye_basic"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            output = "unilib:dye_red 2",
            recipe = {
                {"unilib:crop_strawberry_gariguette_harvest"},
            },
        })

    end

    unilib.register_juice({
        ingredient = "unilib:crop_strawberry_gariguette_harvest",
        juice_description = S("Strawberry"),
        juice_type = "strawberry",
        rgb = "#ff3636",

        orig_flag = false,
    })

    unilib.register_decoration_generic("better_farming_crop_strawberry_gariguette", {
        -- From better_farming:strawberry_8
        deco_type = "simple",
        decoration = "unilib:crop_strawberry_gariguette_grow_8",

        noise_params = {
            octaves = 3,
            offset = -0.1,
            persist = 0.7,
            -- N.B. scale was 0.1 in original code
            scale = 0.001,
            seed = 5045,
            spread = {x = 50, y = 50, z = 50},
        },
        param2 = 3,
        sidelen = 16,
    })

end
