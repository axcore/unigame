---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cucina_vegana
-- Code:    LGPL3.0
-- Media:   LGPL3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.crop_peanut = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.cucina_vegana.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.crop_peanut.init()

    return {
        description = "Peanut (crop)",
        notes = "Unusually for this crop, peanuts are created by cooking peanut seeds, not by" ..
                " harvesting the plant",
        optional = "dye_basic",
    }

end

function unilib.pkg.crop_peanut.exec()

    local fertility_list = {"ordinary_soil"}

    local orig_name_list = {}
    for i = 1, 7 do
        table.insert(orig_name_list, "cucina_vegana:peanut_" .. i)
    end

    if not unilib.setting.cucina_vegana_redo_flag then

        -- Adapted from cucina_vegana/peanut_default.lua
        unilib.register_crop_mtgame({
            -- From cucina_vegana:peanut (creates unilib:crop_peanut_harvest),
            --      cucina_vegana:seed_peanut (creates unilib:crop_peanut_seed),
            --      cucina_vegana:peanut_1 etc (creates unilib:crop_peanut_grow_1 etc)
            part_name = "peanut",
            grow_orig_name = orig_name_list,
            harvest_orig_name = "cucina_vegana:peanut",
            seed_orig_name = "cucina_vegana:seed_peanut",
            steps = 7,

            replace_mode = mode,
            eat = 4,
            fertility_list = fertility_list,
            harvest_description = S("Peanuts"),
            harvest_group_table = {
                eatable = 1, flammable = 1, food = 1, food_peanut = 1, food_vegan = 1,
            },
            max_light = unilib.constant.light_max,
            min_light = 12,
            seed_description = S("Peanut Seed"),
            seed_group_table = {attached_node = 1, flammable = 4, seed_peanut = 1},
        })

    else

        -- Adapted from cucina_vegana/peanut_redo.lua
        unilib.register_crop_fredo({
            -- From cucina_vegana:peanut (creates unilib:crop_peanut_harvest),
            --      cucina_vegana:peanut_seed (creates unilib:crop_peanut_seed),
            --      cucina_vegana:peanut_1 etc (creates unilib:crop_peanut_grow_1 etc)
            part_name = "peanut",
            grow_orig_name = orig_name_list,
            harvest_orig_name = "cucina_vegana:peanut",
            seed_orig_name = "cucina_vegana:peanut_seed",
            steps = 7,

            replace_mode = mode,
            eat = 4,
            fertility_list = fertility_list,
            grow_group_table = {
                attached_node = 1, dig_immediate = 1, flammable = 4, not_in_creative_inventory = 1,
                plant = 1, snappy = 3,
            },
            grow_list = {
                {},
                {},
                {},
                {},
                {},
                {
                    drop = {
                        items = {
                            {items = {"unilib:crop_peanut_seed"}, rarity = 2},
                        },
                    },
                },
                {
                    drop = {
                        items = {
                            {items = {"unilib:crop_peanut_seed 2"}, rarity = 1},
                            {items = {"unilib:crop_peanut_seed 3"}, rarity = 2},
                            {items = {"unilib:crop_peanut_seed 4"}, rarity = 3},
                        },
                    },
                },
            },
            harvest_description = S("Peanut"),
            harvest_group_table = {
                eatable = 1, flammable = 1, food = 1, food_peanut = 1, food_vegan = 1,
            },
            min_light = 12,
            seed_description = S("Peanut Seed"),
            seed_group_table = {
                attached_node = 1, dig_immediate = 1, flammable = 4, seed = 1, seed_peanut = 1,
                snappy = 3,
            },
        })

    end

    if unilib.setting.dye_from_crops_flag and
            unilib.global.pkg_executed_table["dye_basic"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            output = "unilib:dye_brown 2",
            recipe = {
                {"unilib:crop_peanut_harvest"},
            },
        })

    end
    -- N.B. In farming_redo mode, the crop drops only seeds, not peanuts
    -- "unilib:crop_peanut_harvest" is provided by this recipe
    unilib.register_craft({
        -- From cucina_vegana:peanut
        type = "cooking",
        output = "unilib:crop_peanut_harvest",
        recipe = "group:seed_peanut",
        cooktime = 5,
    })
    unilib.register_craft({
        -- From cucina_vegana:peanut
        type = "fuel",
        recipe = "unilib:crop_peanut_harvest",
        burntime = 5,
    })

end
