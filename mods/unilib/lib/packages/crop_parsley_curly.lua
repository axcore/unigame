---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cucina_vegana
-- Code:    LGPL3.0
-- Media:   LGPL3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.crop_parsley_curly = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.cucina_vegana.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.crop_parsley_curly.init()

    return {
        description = "Curly leaf parsley",
        optional = "dye_basic",
    }

end

function unilib.pkg.crop_parsley_curly.exec()

    local fertility_list = {"ordinary_soil"}

    local orig_name_list = {}
    for i = 1, 5 do
        table.insert(orig_name_list, "cucina_vegana:parsley_" .. i)
    end

    if not unilib.cucina_vegana_redo_flag then

        -- Adapted from cucina_vegana/parsley_default.lua
        unilib.register_crop_mtgame({
            -- From cucina_vegana:parsley (creates unilib:crop_parsley_curly_harvest),
            --      cucina_vegana:seed_parsley (creates unilib:crop_parsley_curly_seed),
            --      cucina_vegana:parsley_1 etc (creates unilib:crop_parsley_curly_grow_1 etc)
            part_name = "parsley_curly",
            grow_orig_name = orig_name_list,
            harvest_orig_name = "cucina_vegana:parsley",
            seed_orig_name = "cucina_vegana:seed_parsley",
            steps = 5,

            replace_mode = mode,
            eat = 1,
            fertility_list = fertility_list,
            harvest_description = S("Curly Leaf Parsley"),
            harvest_group_table = {
                eatable = 1, flammable = 1, food = 1, food_parsley = 1, food_vegan = 1,
            },
            max_light = unilib.light_max,
            min_light = 11,
            seed_description = S("Curly Leaf Parsley Seed"),
            seed_group_table = {attached_node = 1, flammable = 4},
        })

    else

        -- Adapted from cucina_vegana/parsley_redo.lua
        unilib.register_crop_fredo({
            -- From cucina_vegana:parsley (creates unilib:crop_parsley_curly_harvest),
            --      cucina_vegana:parsley_seed (creates unilib:crop_parsley_curly_seed),
            --      cucina_vegana:parsley_1 etc (creates unilib:crop_parsley_curly_grow_1 etc)
            part_name = "parsley_curly",
            grow_orig_name = orig_name_list,
            harvest_orig_name = "cucina_vegana:parsley",
            seed_orig_name = "cucina_vegana:parsley_seed",
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
                            {items = {"unilib:crop_parsley_curly_harvest"}, rarity = 1},
                            {items = {"unilib:crop_parsley_curly_seed"}, rarity = 2},
                        },
                    },
                },
                {
                    drop = {
                        items = {
                            {items = {"unilib:crop_parsley_curly_harvest"}, rarity = 1},
                            {items = {"unilib:crop_parsley_curly_harvest"}, rarity = 1},
                            {items = {"unilib:crop_parsley_curly_harvest"}, rarity = 3},
                            {items = {"unilib:crop_parsley_curly_seed"}, rarity = 1},
                            {items = {"unilib:crop_parsley_curly_seed"}, rarity = 1},
                            {items = {"unilib:crop_parsley_curly_seed"}, rarity = 3},
                        },
                    },
                },
            },
            harvest_description = S("Curly Leaf Parsley"),
            harvest_group_table = {
                eatable = 1, flammable = 1, food = 1, food_parsley = 1, food_vegan = 1,
            },
            min_light = 11,
            seed_description = S("Curly Leaf Parsley Seed"),
            seed_group_table = {
                attached_node = 1, dig_immediate = 1, flammable = 4, seed = 1, snappy = 3,
            },
        })

    end

    if unilib.dye_from_crops_flag and unilib.pkg_executed_table["dye_basic"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            output = "unilib:dye_green 2",
            recipe = {
                {"unilib:crop_parsley_curly_harvest"},
            },
        })

    end
    unilib.register_craft({
        -- From cucina_vegana:parsley
        type = "fuel",
        recipe = "unilib:crop_parsley_curly_harvest",
        burntime = 1,
    })

end
