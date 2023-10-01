---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cropocalypse
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.crop_garlic_porcelain = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.cropocalypse.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.crop_garlic_porcelain.init()

    return {
        description = "Porcelain garlic",
        optional = "dye_basic",
    }

end

function unilib.pkg.crop_garlic_porcelain.exec()

    local fertility_list = {"desert_soil", "ordinary_soil"}

    local orig_name_list = {}
    for i = 1, 8 do
        table.insert(orig_name_list, "cropocalypse:garlic_" .. i)
    end

    unilib.register_crop_mtgame({
        -- From cropocalypse:garlic (creates unilib:crop_garlic_porcelain_harvest),
        --      cropocalypse:seed_garlic (creates unilib:crop_garlic_porcelain_seed),
        --      cropocalypse:garlic_1 etc (creates unilib:crop_garlic_porcelain_grow_1 etc)
        part_name = "garlic_porcelain",
        grow_orig_name = orig_name_list,
        harvest_orig_name = "cropocalypse:garlic",
        seed_orig_name = "cropocalypse:seed_garlic",
        steps = 8,

        replace_mode = mode,
        eat = 1,
        fertility_list = fertility_list,
        harvest_description = S("Porcelain Garlic"),
        -- N.B. food = 1 not in original code
        harvest_group_table = {flammable = 4, food = 1, food_garlic = 1},
        max_light = unilib.light_max,
        min_light = 13,
        paramtype2 = "meshoptions",
        place_param2 = 3,
        seed_description = S("Porcelain Garlic Seed"),
    })

    if unilib.pkg_executed_table["dye_basic"] ~= nil then

        unilib.register_craft({
            -- From cropocalypse:garlic
            output = "unilib:dye_grey 2",
            recipe = {
                {"unilib:crop_garlic_porcelain_harvest"},
            },
        })

    end

end
