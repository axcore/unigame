---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cucina_vegana
-- Code:    LGPL3.0
-- Media:   LGPL3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.crop_garlic_silverskin = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.cucina_vegana.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.crop_garlic_silverskin.init()

    return {
        description = "Silverskin garlic",
        optional = "dye_basic",
    }

end

function unilib.pkg.crop_garlic_silverskin.exec()

    local fertility_list = {"ordinary_soil"}

    local orig_name_list = {}
    for i = 1, 6 do
        table.insert(orig_name_list, "cucina_vegana:garlic_" .. i)
    end

    if not unilib.cucina_vegana_redo_flag then

        -- Adapted from cucina_vegana/garlic_default.lua
        unilib.register_crop_mtgame({
            -- From cucina_vegana:garlic (creates unilib:crop_garlic_silverskin_harvest),
            --      cucina_vegana:seed_garlic (creates unilib:crop_garlic_silverskin_seed),
            --      cucina_vegana:garlic_1 etc (creates unilib:crop_garlic_silverskin_grow_1 etc)
            part_name = "garlic_silverskin",
            grow_orig_name = orig_name_list,
            harvest_orig_name = "cucina_vegana:garlic",
            seed_orig_name = "cucina_vegana:seed_garlic",
            steps = 6,

            replace_mode = mode,
            fertility_list = fertility_list,
            harvest_description = S("Silverskin Garlic"),
            harvest_group_table = {flammable = 1, food = 1, food_garlic = 1, food_vegan = 1},
            max_light = unilib.light_max,
            min_light = 12,
            seed_description = S("Silverskin Garlic Seed"),
            seed_group_table = {attached_node = 1, flammable = 4, seed_garlic = 1},
        })

    else

        -- Adapted from cucina_vegana/garlic_redo.lua
        unilib.register_crop_fredo({
            -- From cucina_vegana:garlic (creates unilib:crop_garlic_silverskin_harvest),
            --      cucina_vegana:garlic_seed (creates unilib:crop_garlic_silverskin_seed),
            --      cucina_vegana:garlic_1 etc (creates unilib:crop_garlic_silverskin_grow_1 etc)
            part_name = "garlic_silverskin",
            grow_orig_name = orig_name_list,
            harvest_orig_name = "cucina_vegana:garlic",
            seed_orig_name = "cucina_vegana:garlic_seed",
            steps = 6,

            replace_mode = mode,
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
                {
                    drop = {
                        items = {
                            {items = {"unilib:crop_garlic_silverskin_seed"}, rarity = 2},
                        },
                    },
                },
                {
                    drop = {
                        items = {
                            {items = {"unilib:crop_garlic_silverskin_harvest 3"}, rarity = 1},
                            {items = {"unilib:crop_garlic_silverskin_harvest 4"}, rarity = 3},
                            {items = {"unilib:crop_garlic_silverskin_seed 3"}, rarity = 1},
                            {items = {"unilib:crop_garlic_silverskin_seed 4"}, rarity = 3},
                        },
                    },
                },
            },
            harvest_description = S("Silverskin Garlic"),
            harvest_group_table = {flammable = 1, food = 1, food_garlic = 1, food_vegan = 1},
            min_light = 12,
            seed_description = S("Silverskin Garlic Seed"),
            seed_group_table = {
                attached_node = 1, dig_immediate = 1, flammable = 4, seed = 1, seed_garlic = 1,
                snappy = 3,
            },
        })

    end

    if unilib.dye_from_crops_flag and unilib.pkg_executed_table["dye_basic"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            output = "unilib:dye_magenta 2",
            recipe = {
                {"unilib:crop_garlic_silverskin_harvest"},
            },
        })

    end

end
