---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cropocalypse
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.crop_cocoa_trinitario = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.cropocalypse.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.crop_cocoa_trinitario.init()

    return {
        description = "Trinitario cocoa",
        optional = "dye_basic",
    }

end

function unilib.pkg.crop_cocoa_trinitario.exec()

    local fertility_list = {"desert_soil", "ordinary_soil"}

    local orig_name_list = {}
    for i = 1, 8 do
        table.insert(orig_name_list, "cropocalypse:cocao_" .. i)
    end

    unilib.register_crop_mtgame({
        -- From cropocalypse:cocao (creates unilib:crop_cocoa_trinitario_harvest),
        --      cropocalypse:seed_cocao (creates unilib:crop_cocoa_trinitario_seed),
        --      cropocalypse:cocao_1 etc (creates unilib:crop_cocoa_trinitario_grow_1 etc)
        part_name = "cocoa_trinitario",
        grow_orig_name = orig_name_list,
        harvest_orig_name = "cropocalypse:cocao",
        seed_orig_name = "cropocalypse:seed_cocao",
        steps = 8,

        replace_mode = mode,
        eat = 1,
        fertility_list = fertility_list,
        harvest_description = S("Trinitario Cocoa"),
        -- N.B. food = 1 not in original code
        harvest_group_table = {flammable = 4, food = 1, food_cocoa = 1},
        max_light = unilib.light_max,
        min_light = 13,
        seed_description = S("Trinitario Cocoa Seed"),
    })

    for i = 4, 5 do

        unilib.override_item("unilib:crop_cocoa_trinitario_grow_" .. i, {
            visual_scale = 2.0,
        })

    end

    for i = 6, 8 do

        unilib.override_item("unilib:crop_cocoa_trinitario_grow_" .. i, {
            visual_scale = 3.0,
        })

    end

    if unilib.pkg_executed_table["dye_basic"] ~= nil then

        unilib.register_craft({
            -- From cropocalypse:cocao
            output = "unilib:dye_brown 2",
            recipe = {
                {"unilib:crop_cocoa_trinitario_harvest"},
            },
        })

    end

end
