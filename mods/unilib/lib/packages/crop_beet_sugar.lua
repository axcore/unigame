---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    agriculture
-- Code:    WTFPL
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.crop_beet_sugar = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.agriculture.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.crop_beet_sugar.init()

    return {
        description = "Sugar beet",
        notes = "Harvested sugar beet can be cooked to provide (ordinary) sugar",
        depends = "ingredient_sugar_normal",
        optional = "dye_basic",
    }

end

function unilib.pkg.crop_beet_sugar.exec()

    local fertility_list = {"ordinary_soil"}

    local orig_name_list = {}
    for i = 1, 5 do
        table.insert(orig_name_list, "agriculture:sugar_beet_" .. i)
    end

    unilib.register_crop_mtgame({
        -- Loosely based on code in agricutlure/agriculture, but using all original textures
        -- From agriculture:sugar_beet (creates unilib:crop_beet_sugar_harvest),
        --      agriculture:seed_sugar_beet (creates unilib:crop_beet_sugar_seed),
        --      agriculture:sugar_beet_1 etc (creates unilib:crop_beet_sugar_grow_1 etc)
        part_name = "beet_sugar",
        grow_orig_name = orig_name_list,
        harvest_orig_name = "agriculture:sugar_beet",
        seed_orig_name = "agriculture:seed_sugar_beet",
        steps = 5,

        replace_mode = mode,
        fertility_list = fertility_list,
        harvest_description = S("Sugar Beet"),
        seed_description = S("Sugar Beet Seed"),
    })
    unilib.register_craft({
        -- From agriculture:sugar_beet
        type = "cooking",
        output = "unilib:ingredient_sugar_normal",
        recipe = "unilib:crop_beet_sugar_harvest",
        cooktime = 15,
    })
    if unilib.dye_from_crops_flag and unilib.pkg_executed_table["dye_basic"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            output = "unilib:dye_brown 2",
            recipe = {
                {"unilib:crop_beet_sugar_harvest"},
            },
        })

    end

end
