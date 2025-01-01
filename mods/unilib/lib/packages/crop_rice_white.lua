---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.crop_rice_white = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.crop_rice_white.init()

    return {
        description = "White rice",
        notes = "White rice seeds are dropped randomly by jungle grass",
        optional = "dye_basic",
    }

end

function unilib.pkg.crop_rice_white.exec()

    local fertility_list = {"ordinary_soil"}

    local orig_name_list = {}
    for i = 1, 8 do
        table.insert(orig_name_list, "farming:rice_" .. i)
    end

    unilib.register_crop_fredo({
        -- From farming:rice (creates unilib:crop_rice_white_harvest), farming:seed_rice (creates
        --      unilib:crop_rice_white_seed), farming:rice_1 etc (creates
        --      unilib:crop_rice_white_grow_1 etc)
        part_name = "rice_white",
        grow_orig_name = orig_name_list,
        harvest_orig_name = "farming:rice",
        seed_orig_name = "farming:seed_rice",
        steps = 8,

        replace_mode = mode,
        fertility_list = fertility_list,
        harvest_description = S("White Rice"),
        -- N.B. food = 1 not in original code
        harvest_group_table = {flammable = 4, food = 1, food_rice = 1},
        no_early_drop_flag = true,
        paramtype2 = "meshoptions",
        place_param2 = 3,
        seed_description = S("White Rice Grains"),
    })
    if unilib.setting.dye_from_crops_flag and
            unilib.global.pkg_executed_table["dye_basic"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            output = "unilib:dye_white 2",
            recipe = {
                {"unilib:crop_rice_white_harvest"},
            },
        })

    end
    unilib.register_craft({
        -- From From farming:rice
        type = "fuel",
        recipe = " unilib:crop_rice_white_harvest",
        burntime = 1,
    })

end
