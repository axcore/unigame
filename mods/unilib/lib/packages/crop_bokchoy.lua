---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    better_farming
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.crop_bokchoy = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.better_farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.crop_bokchoy.init()

    return {
        description = "Bokchoy",
        optional = "dye_basic",
    }

end

function unilib.pkg.crop_bokchoy.exec()

    local fertility_list = {"ordinary_soil"}

    local orig_name_list = {}
    for i = 1, 3 do
        table.insert(orig_name_list, "better_farming:bokchoy_" .. i)
    end

    unilib.register_crop_mtgame({
        -- From better_farming:bokchoy (creates unilib:crop_bokchoy_harvest),
        --      better_farming:seed_bokchoy (creates unilib:crop_bokchoy_seed),
        --      better_farming:bokchoy_1 etc (creates unilib:crop_bokchoy_grow_1 etc)
        part_name = "bokchoy",
        grow_orig_name = orig_name_list,
        harvest_orig_name = "better_farming:bokchoy",
        seed_orig_name = "better_farming:seed_bokchoy",
        steps = 3,

        replace_mode = mode,
        eat = 1,
        fertility_list = fertility_list,
        harvest_description = S("Bokchoy"),
        -- N.B. food_bokchoy not in original code
        harvest_group_table = {flammable = 3, food_bokchoy = 1},
        min_light = 7,
        seed_description = S("Bokchoy Seed"),
        seed_group_table = {attached_node = 1, flammable = 2, seed = 1, snappy = 3},
    })
    if unilib.setting.dye_from_crops_flag and
            unilib.global.pkg_executed_table["dye_basic"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            output = "unilib:dye_green 2",
            recipe = {
                {"unilib:crop_bokchoy_harvest"},
            },
        })

    end

    unilib.register_decoration_generic("better_farming_crop_bokchoy", {
        -- From better_farming:bokchoy_3
        deco_type = "simple",
        decoration = "unilib:crop_bokchoy_grow_3",

        noise_params = {
            octaves = 3,
            offset = -0.1,
            persist = 0.7,
            -- N.B. scale was 0.1 in original code
            scale = 0.001,
            seed = 3145,
            spread = {x = 50, y = 50, z = 50},
        },
        param2 = 3,
        sidelen = 16,
    })

end
