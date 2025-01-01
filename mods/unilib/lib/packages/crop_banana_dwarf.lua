---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cucina_vegana
-- Code:    LGPL3.0
-- Media:   LGPL3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.crop_banana_dwarf = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.cucina_vegana.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.crop_banana_dwarf.init()

    return {
        description = "Dwarf banana (crop)",
        optional = "dye_basic",
    }

end

function unilib.pkg.crop_banana_dwarf.exec()

    local fertility_list = {"ordinary_soil"}

    local orig_name_list = {}
    for i = 1, 8 do
        table.insert(orig_name_list, "cucina_vegana:banana_" .. i)
    end

    if not unilib.setting.cucina_vegana_redo_flag then

        -- Adapted from cucina_vegana/banana_default.lua
        unilib.register_crop_mtgame({
            -- From cucina_vegana:banana (creates unilib:crop_banana_dwarf_harvest),
            --      cucina_vegana:seed_banana (creates unilib:crop_banana_dwarf_seed),
            --      cucina_vegana:banana_1 etc (creates unilib:crop_banana_dwarf_grow_1 etc)
            part_name = "banana_dwarf",
            grow_orig_name = orig_name_list,
            harvest_orig_name = "cucina_vegana:banana",
            seed_orig_name = "cucina_vegana:seed_banana",
            steps = 8,

            replace_mode = mode,
            eat = 4,
            fertility_list = fertility_list,
            harvest_description = S("Dwarf Banana"),
            harvest_group_table = {
                eatable = 1, flammable = 1, food = 1, food_banana = 1, food_vegan = 1,
            },
            max_light = unilib.constant.light_max,
            min_light = 12,
            seed_description = S("Dwarf Banana Seed"),
            seed_group_table = {attached_node = 1, flammable = 4},
        })

    else

        -- Adapted from cucina_vegana/banana_redo.lua
        unilib.register_crop_fredo({
            -- From cucina_vegana:banana (creates unilib:crop_banana_dwarf_harvest),
            --      cucina_vegana:banana_seed (creates unilib:crop_banana_dwarf_seed),
            --      cucina_vegana:banana_1 etc (creates unilib:crop_banana_dwarf_grow_1 etc)
            part_name = "banana_dwarf",
            grow_orig_name = orig_name_list,
            harvest_orig_name = "cucina_vegana:banana",
            seed_orig_name = "cucina_vegana:banana_seed",
            steps = 8,

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
                {
                    drop = {
                        items = {
                            {items = {"unilib:crop_banana_dwarf_seed"}, rarity = 2},
                        },
                    },
                },
                {
                    drop = {
                        items = {
                            {items = {"unilib:crop_banana_dwarf_seed"}, rarity = 1},
                            {items = {"unilib:crop_banana_dwarf_seed"}, rarity = 2},
                            {items = {"unilib:crop_banana_dwarf_harvest"}, rarity = 3},
                        },
                    },
                },
                {
                    drop = {
                        items = {
                            {items = {"unilib:crop_banana_dwarf_harvest"}, rarity = 1},
                            {items = {"unilib:crop_banana_dwarf_harvest"}, rarity = 2},
                            {items = {"unilib:crop_banana_dwarf_harvest"}, rarity = 3},
                            {items = {"unilib:crop_banana_dwarf_seed"}, rarity = 1},
                            {items = {"unilib:crop_banana_dwarf_seed"}, rarity = 1},
                            {items = {"unilib:crop_banana_dwarf_seed"}, rarity = 3},
                        },
                    },
                },
                {
                    drop = {
                        items = {
                            {items = {"unilib:crop_banana_dwarf_harvest"}, rarity = 1},
                            {items = {"unilib:crop_banana_dwarf_harvest"}, rarity = 2},
                            {items = {"unilib:crop_banana_dwarf_seed"}, rarity = 1},
                            {items = {"unilib:crop_banana_dwarf_seed"}, rarity = 1},
                        },
                    },
                },
                {
                    drop = {
                        items = {
                            {items = {"unilib:crop_banana_dwarf_harvest"}, rarity = 1},
                            {items = {"unilib:crop_banana_dwarf_harvest"}, rarity = 2},
                            {items = {"unilib:crop_banana_dwarf_harvest"}, rarity = 3},
                            {items = {"unilib:crop_banana_dwarf_seed"}, rarity = 1},
                            {items = {"unilib:crop_banana_dwarf_seed"}, rarity = 2},
                            {items = {"unilib:crop_banana_dwarf_seed"}, rarity = 3},
                        },
                    },
                },
            },
            harvest_description = S("Dwarf Banana"),
            harvest_group_table = {
                eatable = 1, flammable = 1, food = 1, food_banana = 1, food_vegan = 1,
            },
            min_light = 12,
            seed_description = S("Dwarf Banana Seed"),
            seed_group_table = {
                attached_node = 1, dig_immediate = 1, flammable = 4, seed = 1, snappy = 3,
            },
        })

    end

    if unilib.setting.dye_from_crops_flag and
            unilib.global.pkg_executed_table["dye_basic"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            output = "unilib:dye_yellow 2",
            recipe = {
                {"unilib:crop_banana_dwarf_harvest"},
            },
        })

    end

    unilib.register_juice({
        ingredient = "unilib:crop_banana_dwarf_harvest",
        juice_description = S("Banana"),
        juice_type = "banana",
        rgb = "#eced9f",

        orig_flag = false,
    })

end
