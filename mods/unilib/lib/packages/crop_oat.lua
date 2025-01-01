---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.crop_oat = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.crop_oat.init()

    return {
        description = "Oat",
        notes = "Oat seeds are dropped randomly by ordinary grass",
        optional = {
            "dye_basic",
            "ingredient_flour_oat",
            "ingredient_flour_ordinary",
            "utensil_mortar_pestle",
        },
    }

end

function unilib.pkg.crop_oat.exec()

    local fertility_list = {"ordinary_soil"}

    local orig_name_list = {}
    for i = 1, 8 do
        table.insert(orig_name_list, "farming:oat_" .. i)
    end

    unilib.register_crop_fredo({
        -- From farming:oat (creates unilib:crop_oat_harvest), farming:seed_oat (creates
        --      unilib:crop_oat_seed), farming:oat_1 etc (creates unilib:crop_oat_grow_1 etc)
        part_name = "oat",
        grow_orig_name = orig_name_list,
        harvest_orig_name = "farming:oat",
        seed_orig_name = "farming:seed_oat",
        steps = 8,

        replace_mode = mode,
        fertility_list = fertility_list,
        harvest_description = S("Oat"),
        harvest_group_table = {flammable = 4, food_oats = 1},
        no_early_drop_flag = true,
        paramtype2 = "meshoptions",
        place_param2 = 3,
        seed_description = S("Oat Seed"),
    })
    -- N.B. The "ingredient_flour_oat" package, if loaded, uses an identical recipe to craft oat
    --      flour
    if unilib.global.pkg_executed_table["ingredient_flour_ordinary"] ~= nil and
            unilib.global.pkg_executed_table["utensil_mortar_pestle"] ~= nil and
            unilib.global.pkg_executed_table["ingredient_flour_oat"] == nil then

        unilib.register_craft({
            -- From farming:oat
            output = "unilib:ingredient_flour_ordinary",
            recipe = {
                {"unilib:crop_oat_harvest", "unilib:crop_oat_harvest", "unilib:crop_oat_harvest"},
                {"unilib:crop_oat_harvest", "unilib:utensil_mortar_pestle", ""},
            },
            replacements = {
                {"group:food_mortar_pestle", "unilib:utensil_mortar_pestle"},
            },
        })

    end
    if unilib.setting.dye_from_crops_flag and
            unilib.global.pkg_executed_table["dye_basic"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            output = "unilib:dye_orange 2",
            recipe = {
                {"unilib:crop_oat_harvest"},
            },
        })

    end
    unilib.register_craft({
        -- From farming:oat
        type = "fuel",
        recipe = "unilib:crop_oat_harvest",
        burntime = 1,
    })

end
