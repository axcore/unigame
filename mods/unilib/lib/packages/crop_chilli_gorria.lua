---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cucina_vegana
-- Code:    LGPL3.0
-- Media:   LGPL3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.crop_chilli_gorria = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.cucina_vegana.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.crop_chilli_gorria.init()

    return {
        description = "Gorria chilli",
        optional = "dye_basic",
    }

end

function unilib.pkg.crop_chilli_gorria.exec()

    local fertility_list = {"ordinary_soil"}

    local orig_name_list = {}
    for i = 1, 7 do
        table.insert(orig_name_list, "cucina_vegana:chili_" .. i)
    end

    if not unilib.cucina_vegana_redo_flag then

        -- Adapted from cucina_vegana/chili_default.lua
        unilib.register_crop_mtgame({
            -- From cucina_vegana:chili (creates unilib:crop_chilli_gorria_harvest),
            --      cucina_vegana:seed_chili (creates unilib:crop_chilli_gorria_seed),
            --      cucina_vegana:chili_1 etc (creates unilib:crop_chilli_gorria_grow_1 etc)
            part_name = "chilli_gorria",
            grow_orig_name = orig_name_list,
            harvest_orig_name = "cucina_vegana:chili",
            seed_orig_name = "cucina_vegana:seed_chili",
            steps = 7,

            replace_mode = mode,
            eat = 1,
            fertility_list = fertility_list,
            harvest_description = S("Gorria Chilli"),
            -- N.B. updated the food groups to match "produce_chilli_normal"
            harvest_group_table = {
                flammable = 1, food = 1, food_chili_pepper = 1, food_chilli_pepper = 1,
                food_vegan = 1,
            },
            max_light = unilib.light_max,
            min_light = 13,
            seed_description = S("Gorria Chilli Seed"),
            -- N.B. updated the food groups to match groups above
            seed_group_table = {attached_node = 1, flammable = 4, seed_chili = 1, seed_chilli = 1},
        })

    else

        -- Adapted from cucina_vegana/chili_redo.lua
        unilib.register_crop_fredo({
            -- From cucina_vegana:chili (creates unilib:crop_chilli_gorria_harvest),
            --      cucina_vegana:chili_seed (creates unilib:crop_chilli_gorria_seed),
            --      cucina_vegana:chili_1 etc (creates unilib:crop_chilli_gorria_grow_1 etc)
            part_name = "chilli_gorria",
            grow_orig_name = orig_name_list,
            harvest_orig_name = "cucina_vegana:chili",
            seed_orig_name = "cucina_vegana:chili_seed",
            steps = 7,

            replace_mode = mode,
            eat = 1,
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
                            {items = {"unilib:crop_chilli_gorria_seed"}, rarity = 2},
                        },
                    },
                },
                {
                    drop = {
                        items = {
                            {items = {"unilib:crop_chilli_gorria_harvest 3"}},
                            {items = {"unilib:crop_chilli_gorria_harvest"}, rarity = 2},
                            {items = {"unilib:crop_chilli_gorria_seed 2"}, rarity = 1},
                            {items = {"unilib:crop_chilli_gorria_seed 3"}, rarity = 2},
                            {items = {"unilib:crop_chilli_gorria_seed 4"}, rarity = 3},
                        },
                    },
                },
            },
            harvest_description = S("Gorria Chilli"),
            -- N.B. updated the food groups to match "produce_chilli_normal"
            harvest_group_table = {
                flammable = 1, food = 1, food_chili_pepper = 1, food_chilli_pepper = 1,
                food_vegan = 1,
            },
            min_light = 13,
            seed_description = S("Gorria Chilli Seed"),
            seed_group_table = {
                attached_node = 1, dig_immediate = 1, flammable = 4, seed = 1, seed_chili = 1,
                seed_chilli = 1, snappy = 3,
            },
        })

    end

    if unilib.dye_from_crops_flag and unilib.pkg_executed_table["dye_basic"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            output = "unilib:dye_red 2",
            recipe = {
                {"unilib:crop_chilli_gorria_harvest"},
            },
        })

    end

end
