---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cropocalypse
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.crop_mushroom_morel_common = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.cropocalypse.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.crop_mushroom_morel_common.init()

    return {
        description = "Common morel mushroom (as a crop)",
        optional = "dye_basic",
    }

end

function unilib.pkg.crop_mushroom_morel_common.exec()

    local fertility_list = {"desert_soil", "ordinary_soil"}

    local orig_name_list = {}
    for i = 1, 8 do
        table.insert(orig_name_list, "cropocalypse:morel_mushroom_" .. i)
    end

    unilib.register_crop_mtgame({
        -- From cropocalypse:morel_mushroom (creates unilib:crop_mushroom_morel_common_harvest),
        --      cropocalypse:seed_morel_mushroom (creates unilib:crop_mushroom_morel_common_seed),
        --      cropocalypse:morel_mushroom_1 etc (creates
        --      unilib:crop_mushroom_morel_common_grow_1 etc)
        part_name = "mushroom_morel_common",
        grow_orig_name = orig_name_list,
        harvest_orig_name = "cropocalypse:morel_mushroom",
        seed_orig_name = "cropocalypse:seed_morel_mushroom",
        steps = 8,

        replace_mode = mode,
        eat = 1,
        fertility_list = fertility_list,
        harvest_description = S("Common Morel Mushroom"),
        -- N.B. food = 1 not in original code
        harvest_group_table = {flammable = 4, food = 1, food_morel_mushroom = 1},
        max_light = unilib.constant.light_max,
        min_light = 0,
        paramtype2 = "meshoptions",
        place_param2 = 3,
        seed_description = S("Common Morel Mushroom Spore"),
    })
    if unilib.setting.dye_from_crops_flag and
            unilib.global.pkg_executed_table["dye_basic"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            -- N.B. For mushroom crops, output is only 1 instead of the usual 2
            output = "unilib:dye_grey",
            recipe = {
                {"unilib:crop_mushroom_morel_common_harvest"},
            },
        })

    end

end
