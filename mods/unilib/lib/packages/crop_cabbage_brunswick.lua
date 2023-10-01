---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    better_farming
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.crop_cabbage_brunswick = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.better_farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.crop_cabbage_brunswick.init()

    return {
        description = "Brunswick cabbage",
        optional = "dye_basic",
    }

end

function unilib.pkg.crop_cabbage_brunswick.exec()

    local fertility_list = {"ordinary_soil"}

    local orig_name_list = {}
    for i = 1, 6 do
        table.insert(orig_name_list, "better_farming:cabbage_" .. i)
    end

    unilib.register_crop_mtgame({
        -- From better_farming:cabbage (creates unilib:crop_cabbage_brunswick_harvest),
        --      better_farming:seed_cabbage (creates unilib:crop_cabbage_brunswick_seed),
        --      better_farming:cabbage_1 etc (creates unilib:crop_cabbage_brunswick_grow_1 etc)
        part_name = "cabbage_brunswick",
        grow_orig_name = orig_name_list,
        harvest_orig_name = "better_farming:cabbage",
        seed_orig_name = "better_farming:seed_cabbage",
        steps = 6,

        replace_mode = mode,
        eat = 2,
        fertility_list = fertility_list,
        harvest_description = S("Brunswick Cabbage"),
        -- N.B. food_cabbage not in original code
        harvest_group_table = {flammable = 4, food_cabbage = 1},
        min_light = 7,
        seed_description = S("Brunswick Cabbage Seed"),
        seed_group_table = {attached_node = 1, flammable = 2, seed = 1, snappy = 3},
    })
    if unilib.dye_from_crops_flag and unilib.pkg_executed_table["dye_basic"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            output = "unilib:dye_green_dark 2",
            recipe = {
                {"unilib:crop_cabbage_brunswick_harvest"},
            },
        })

    end

    unilib.register_decoration("better_farming_crop_cabbage_brunswick", {
        -- From better_farming:cabbage_6
        deco_type = "simple",
        decoration = "unilib:crop_cabbage_brunswick_grow_6",

        noise_params = {
            octaves = 3,
            offset = -0.1,
            persist = 0.7,
            -- N.B. scale was 0.1 in original code
            scale = 0.001,
            seed = 5503,
            spread = {x = 50, y = 50, z = 50},
        },
        param2 = 3,
        sidelen = 16,
    })

end
