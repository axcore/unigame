---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cucina_vegana
-- Code:    LGPL3.0
-- Media:   LGPL3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.crop_chives = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.cucina_vegana.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.crop_chives.init()

    return {
        description = "Chives",
        optional = "dye_basic",
    }

end

function unilib.pkg.crop_chives.exec()

    local fertility_list = {"ordinary_soil"}

    local orig_name_list = {}
    for i = 1, 5 do
        table.insert(orig_name_list, "cucina_vegana:chives_" .. i)
    end

    if not unilib.setting.cucina_vegana_redo_flag then

        -- Adapted from cucina_vegana/chives_default.lua
        unilib.register_crop_mtgame({
            -- From cucina_vegana:chives (creates unilib:crop_chives_harvest),
            --      cucina_vegana:seed_chives (creates unilib:crop_chives_seed),
            --      cucina_vegana:chives_1 etc (creates unilib:crop_chives_grow_1 etc)
            part_name = "chives",
            grow_orig_name = orig_name_list,
            harvest_orig_name = "cucina_vegana:chives",
            seed_orig_name = "cucina_vegana:seed_chives",
            steps = 5,

            replace_mode = mode,
            eat = 1,
            fertility_list = fertility_list,
            harvest_description = S("Chives"),
            harvest_group_table = {
                eatable = 1, flammable = 1, food = 1, food_chives = 1, food_vegan = 1,
            },
            max_light = unilib.constant.light_max,
            min_light = 10,
            seed_description = S("Chives Seed"),
            seed_group_table = {attached_node = 1, flammable = 4},
        })

    else

        -- Adapted from cucina_vegana/chives_redo.lua
        unilib.register_crop_fredo({
            -- From cucina_vegana:chives (creates unilib:crop_chives_harvest),
            --      cucina_vegana:chives_seed (creates unilib:crop_chives_seed),
            --      cucina_vegana:chives_1 etc (creates unilib:crop_chives_grow_1 etc)
            part_name = "chives",
            grow_orig_name = orig_name_list,
            harvest_orig_name = "cucina_vegana:chives",
            seed_orig_name = "cucina_vegana:chives_seed",
            steps = 5,

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
                {
                    drop = {
                        items = {
                            {items = {"unilib:crop_chives_seed"}, rarity = 2},
                        },
                    },
                },
                {
                    drop = {
                        items = {
                            {items = {"unilib:crop_chives_harvest"}, rarity = 1},
                            {items = {"unilib:crop_chives_harvest"}, rarity = 2},
                            {items = {"unilib:crop_chives_harvest"}, rarity = 3},
                            {items = {"unilib:crop_chives_seed"}, rarity = 1},
                            {items = {"unilib:crop_chives_seed"}, rarity = 1},
                            {items = {"unilib:crop_chives_seed"}, rarity = 3},
                        },
                    },
                },
            },
            harvest_description = S("Chives"),
            harvest_group_table = {
                eatable = 1, flammable = 1, food = 1, food_chives = 1, food_vegan = 1,
            },
            min_light = 10,
            seed_description = S("Chives Seed"),
            seed_group_table = {
                attached_node = 1, dig_immediate = 1, flammable = 4, seed = 1, snappy = 3,
            },
        })

    end

    if unilib.setting.dye_from_crops_flag and
            unilib.global.pkg_executed_table["dye_basic"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            output = "unilib:dye_green 2",
            recipe = {
                {"unilib:crop_chives_harvest"},
            },
        })

    end
    unilib.register_craft({
        -- From cucina_vegana:chives
        type = "fuel",
        recipe = "unilib:crop_chives_harvest",
        burntime = 1,
    })

end
