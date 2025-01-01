---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cucina_vegana
-- Code:    LGPL3.0
-- Media:   LGPL3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.crop_potato_russet = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.cucina_vegana.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.crop_potato_russet.init()

    return {
        description = "Russet potato",
        optional = "dye_basic",
    }

end

function unilib.pkg.crop_potato_russet.exec()

    local fertility_list = {"ordinary_soil"}

    local orig_name_list = {}
    for i = 1, 7 do
        table.insert(orig_name_list, "cucina_vegana:potato_" .. i)
    end

    if not unilib.setting.cucina_vegana_redo_flag then

        -- Adapted from cucina_vegana/potato_default.lua
        unilib.register_crop_mtgame({
            -- From cucina_vegana:potato (creates unilib:crop_potato_russet_harvest),
            --      cucina_vegana:seed_potato (creates unilib:crop_potato_russet_seed),
            --      cucina_vegana:potato_1 etc (creates unilib:crop_potato_russet_grow_1 etc)
            part_name = "potato_russet",
            grow_orig_name = orig_name_list,
            harvest_orig_name = "cucina_vegana:potato",
            seed_orig_name = "cucina_vegana:seed_potato",
            steps = 7,

            replace_mode = mode,
            eat = 5,
            fertility_list = fertility_list,
            harvest_description = S("Russet Potato"),
            harvest_group_table = {
                eatable = 1, flammable = 1, food = 1, food_potato = 1, food_vegan = 1,
            },
            max_light = unilib.constant.light_max,
            min_light = 11,
            seed_description = S("Russet Potato Seed"),
            seed_group_table = {attached_node = 1, flammable = 4, seed_potato = 1},
        })

    else

        -- Adapted from cucina_vegana/potato_redo.lua
        unilib.register_crop_fredo({
            -- From cucina_vegana:potato (creates unilib:crop_potato_russet_harvest),
            --      cucina_vegana:potato_seed (creates unilib:crop_potato_russet_seed),
            --      cucina_vegana:potato_1 etc (creates unilib:crop_potato_russet_grow_1 etc)
            part_name = "potato_russet",
            grow_orig_name = orig_name_list,
            harvest_orig_name = "cucina_vegana:potato",
            seed_orig_name = "cucina_vegana:potato_seed",
            steps = 7,

            replace_mode = mode,
            eat = 5,
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
                            {items = {"unilib:crop_potato_russet_seed"}, rarity = 2},
                        },
                    },
                },
                {
                    drop = {
                        items = {
                            {items = {"unilib:crop_potato_russet_seed"}, rarity = 1},
                            {items = {"unilib:crop_potato_russet_harvest"}, rarity = 2},
                        },
                    },
                },
                {
                    drop = {
                        items = {
                            {items = {"unilib:crop_potato_russet_harvest 4"}},
                            {items = {"unilib:crop_potato_russet_seed 2"}, rarity = 1},
                            {items = {"unilib:crop_potato_russet_seed 3"}, rarity = 2},
                            {items = {"unilib:crop_potato_russet_seed 4"}, rarity = 3},
                        },
                    },
                },
            },
            harvest_description = S("Russet Potato"),
            harvest_group_table = {
                eatable = 1, flammable = 1, food = 1, food_potato = 1, food_vegan = 1,
            },
            min_light = 11,
            seed_description = S("Russet Potato Seed"),
            seed_group_table = {
                attached_node = 1, dig_immediate = 1, flammable = 4, seed = 1, seed_potato = 1,
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
                {"unilib:crop_potato_russet_harvest"},
            },
        })

    end

    unilib.register_juice({
        ingredient = "unilib:crop_potato_russet_harvest",
        juice_description = S("Potato"),
        juice_type = "potato",
        rgb = "#d19d0b",

        orig_flag = false,
    })

end
