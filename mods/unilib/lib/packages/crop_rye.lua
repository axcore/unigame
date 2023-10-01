---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.crop_rye = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.crop_rye.init()

    return {
        description = "Rye",
        notes = "Rye seeds are dropped randomly by dry grass",
        optional = {"dye_basic", "ingredient_flour_ordinary", "utensil_mortar_pestle"},
    }

end

function unilib.pkg.crop_rye.exec()

    local fertility_list = {"arid_soil"}

    local orig_name_list = {}
    for i = 1, 8 do
        table.insert(orig_name_list, "farming:rye_" .. i)
    end

    unilib.register_crop_fredo({
        -- From farming:rye (creates unilib:crop_rye_harvest), farming:seed_rye (creates
        --      unilib:crop_rye_seed), farming:rye_1 etc (creates unilib:crop_rye_grow_1 etc)
        part_name = "rye",
        grow_orig_name = orig_name_list,
        harvest_orig_name = "farming:rye",
        seed_orig_name = "farming:seed_rye",
        steps = 8,

        replace_mode = mode,
        fertility_list = fertility_list,
        harvest_description = S("Rye"),
        harvest_group_table = {flammable = 4, food_rye = 1},
        no_early_drop_flag = true,
        paramtype2 = "meshoptions",
        place_param2 = 3,
        seed_description = S("Rye Seed"),
    })
    if unilib.pkg_executed_table["ingredient_flour_ordinary"] ~= nil and
            unilib.pkg_executed_table["utensil_mortar_pestle"] ~= nil then

        unilib.register_craft({
            -- From farming:rye
            output = "unilib:ingredient_flour_ordinary",
            recipe = {
                {"unilib:crop_rye_harvest", "unilib:crop_rye_harvest", "unilib:crop_rye_harvest"},
                {"unilib:crop_rye_harvest", "unilib:utensil_mortar_pestle", ""}
            },
            replacements = {
                {"group:food_mortar_pestle", "unilib:utensil_mortar_pestle"},
            },
        })

    end
    if unilib.dye_from_crops_flag and unilib.pkg_executed_table["dye_basic"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            output = "unilib:dye_yellow 2",
            recipe = {
                {"unilib:crop_rye_harvest"},
            },
        })

    end
    unilib.register_craft({
        -- From farming:rye
        type = "fuel",
        recipe = "unilib:crop_rye_harvest",
        burntime = 1,
    })

end
