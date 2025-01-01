---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cropocalypse
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.crop_carrot_danvers = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.cropocalypse.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.crop_carrot_danvers.init()

    return {
        description = "Danvers carrot",
        optional = "dye_basic",
    }

end

function unilib.pkg.crop_carrot_danvers.exec()

    local fertility_list = {"desert_soil", "ordinary_soil"}

    local orig_name_list = {}
    for i = 1, 8 do
        table.insert(orig_name_list, "cropocalypse:carrot_" .. i)
    end

    unilib.register_crop_mtgame({
        -- From cropocalypse:carrot (creates unilib:crop_carrot_danvers_harvest),
        --      cropocalypse:seed_carrot (creates unilib:crop_carrot_danvers_seed),
        --      cropocalypse:carrot_1 etc (creates unilib:crop_carrot_danvers_grow_1 etc)
        part_name = "carrot_danvers",
        grow_orig_name = orig_name_list,
        harvest_orig_name = "cropocalypse:carrot",
        seed_orig_name = "cropocalypse:seed_carrot",
        steps = 8,

        replace_mode = mode,
        eat = 1,
        fertility_list = fertility_list,
        harvest_description = S("Danvers Carrot"),
        -- N.B. food = 1 not in original code
        harvest_group_table = {flammable = 4, food = 1, food_carrot = 1},
        max_light = unilib.constant.light_max,
        min_light = 13,
        paramtype2 = "meshoptions",
        place_param2 = 3,
        seed_description = S("Danvers Carrot Seed"),
    })

    if unilib.global.pkg_executed_table["dye_basic"] ~= nil then

        unilib.register_craft({
            -- From cropocalypse:carrot
            output = "unilib:dye_orange 2",
            recipe = {
                {"unilib:crop_carrot_danvers_harvest"},
            },
        })

    end

    unilib.register_juice({
        ingredient = "unilib:crop_carrot_danvers_harvest",
        juice_description = S("Carrot"),
        juice_type = "carrot",
        rgb = "#ed9121",

        orig_flag = false,
    })

end
