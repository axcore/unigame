---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cucina_vegana
-- Code:    LGPL3.0
-- Media:   LGPL3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.crop_soy_red = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.cucina_vegana.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.crop_soy_red.init()

    return {
        description = "Red soy",
        optional = "dye_basic",
    }

end

function unilib.pkg.crop_soy_red.exec()

    local fertility_list = {"ordinary_soil"}

    local orig_name_list = {}
    for i = 1, 8 do
        table.insert(orig_name_list, "cucina_vegana:soy_" .. i)
    end

    if not unilib.cucina_vegana_redo_flag then

        -- Adapted from cucina_vegana/soy_default.lua
        unilib.register_crop_mtgame({
            -- From cucina_vegana:soy (creates unilib:crop_soy_red_harvest),
            --      cucina_vegana:seed_soy (creates unilib:crop_soy_red_seed),
            --      cucina_vegana:soy_1 etc (creates unilib:crop_soy_red_grow_1 etc)
            part_name = "soy_red",
            grow_orig_name = orig_name_list,
            harvest_orig_name = "cucina_vegana:soy",
            seed_orig_name = "cucina_vegana:seed_soy",
            steps = 8,

            replace_mode = mode,
            fertility_list = fertility_list,
            harvest_description = S("Red Soy Beans"),
            -- N.B. food = 1, food_soybean = 1 not in original code
            harvest_group_table = {flammable = 4, food = 1, food_soy = 1, food_soybean = 1},
            max_light = unilib.light_max,
            min_light = 12,
            seed_description = S("Red Soy Seed"),
            seed_group_table = {attached_node = 1, flammable = 4, seed_soy = 1},
        })

    else

        -- Adapted from cucina_vegana/soy_redo.lua
        unilib.register_crop_fredo({
            -- From cucina_vegana:soy (creates unilib:crop_soy_red_harvest),
            --      cucina_vegana:soy_seed (creates unilib:crop_soy_red_seed),
            --      cucina_vegana:soy_1 etc (creates unilib:crop_soy_red_grow_1 etc)
            part_name = "soy_red",
            grow_orig_name = orig_name_list,
            harvest_orig_name = "cucina_vegana:soy",
            seed_orig_name = "cucina_vegana:soy_seed",
            steps = 8,

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
                            {items = {"unilib:crop_soy_red_seed"}, rarity = 1},
                        },
                    },
                },
                {
                    drop = {
                        items = {
                            {items = {"unilib:crop_soy_red_seed"}, rarity = 1},
                            {items = {"unilib:crop_soy_red_harvest"}, rarity = 2},
                        },
                    },
                },
                {
                    drop = {
                        items = {
                            {items = {"unilib:crop_soy_red_harvest"}, rarity = 1},
                            {items = {"unilib:crop_soy_red_harvest"}, rarity = 2},
                            {items = {"unilib:crop_soy_red_seed"}, rarity = 1},
                            {items = {"unilib:crop_soy_red_seed"}, rarity = 2},
                        },
                    },
                },
                {
                    drop = {
                        items = {
                            {items = {"unilib:crop_soy_red_harvest"}, rarity = 1},
                            {items = {"unilib:crop_soy_red_harvest"}, rarity = 2},
                            {items = {"unilib:crop_soy_red_harvest"}, rarity = 3},
                            {items = {"unilib:crop_soy_red_seed"}, rarity = 1},
                            {items = {"unilib:crop_soy_red_seed"}, rarity = 2},
                            {items = {"unilib:crop_soy_red_seed"}, rarity = 3},
                        },
                    },
                },
            },
            harvest_description = S("Red Soy Beans"),
            harvest_group_table = {flammable = 4, food_soy = 1},
            min_light = 12,
            seed_description = S("Red Soy Seed"),
            seed_group_table = {
                attached_node = 1, dig_immediate = 1, flammable = 4, seed = 1, seed_soy = 1,
                snappy = 3,
            },
        })

    end

    if unilib.dye_from_crops_flag and unilib.pkg_executed_table["dye_basic"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            output = "unilib:dye_red 2",
            recipe = {
                {"unilib:crop_soy_red_harvest"},
            },
        })

    end
    unilib.register_craft({
        -- From cucina_vegana:soy
        type = "fuel",
        recipe = "unilib:crop_soy_red_harvest",
        burntime = 1,
    })

end
