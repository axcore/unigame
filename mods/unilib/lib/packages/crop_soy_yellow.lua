---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cropocalypse
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.crop_soy_yellow = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.cropocalypse.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.crop_soy_yellow.init()

    return {
        description = "Yellow soy",
        optional = "dye_basic",
    }

end

function unilib.pkg.crop_soy_yellow.exec()

    local fertility_list = {"desert_soil", "ordinary_soil"}

    local orig_name_list = {}
    for i = 1, 8 do
        table.insert(orig_name_list, "cropocalypse:soybean_" .. i)
    end

    unilib.register_crop_mtgame({
        -- From cropocalypse:soybean (creates unilib:crop_soy_yellow_harvest),
        --      cropocalypse:seed_soybean (creates unilib:crop_soy_yellow_seed),
        --      cropocalypse:soybean_1 etc (creates unilib:crop_soy_yellow_grow_1 etc)
        part_name = "soy_yellow",
        grow_orig_name = orig_name_list,
        harvest_orig_name = "cropocalypse:soybean",
        seed_orig_name = "cropocalypse:seed_soybean",
        steps = 8,

        replace_mode = mode,
        eat = 1,
        fertility_list = fertility_list,
        harvest_description = S("Yellow Soy"),
        -- N.B. food = 1, food_soy = 1 not in original code
        harvest_group_table = {flammable = 4, food = 1, food_soy = 1, food_soybean = 1},
        max_light = unilib.light_max,
        min_light = 13,
        seed_description = S("Yellow Soy Seed"),
    })

    if unilib.pkg_executed_table["dye_basic"] ~= nil then

        -- N.B. Green dye in original code
        unilib.register_craft({
            -- From cropocalypse:soybean
            output = "unilib:dye_yellow 2",
            recipe = {
                {"unilib:crop_soy_yellow_harvest"},
            },
        })

    end

end
