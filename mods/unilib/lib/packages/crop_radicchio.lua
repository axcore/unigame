---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cucina_vegana
-- Code:    LGPL3.0
-- Media:   LGPL3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.crop_radicchio = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.cucina_vegana.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.crop_radicchio.init()

    return {
        description = "Radicchio (lettuce)",
        optional = "dye_basic",
    }

end

function unilib.pkg.crop_radicchio.exec()

    local fertility_list = {"ordinary_soil"}

    local orig_name_list = {}
    for i = 1, 5 do
        table.insert(orig_name_list, "cucina_vegana:lettuce_" .. i)
    end

    if not unilib.cucina_vegana_redo_flag then

        -- Adapted from cucina_vegana/lettuce_default.lua
        unilib.register_crop_mtgame({
            -- From cucina_vegana:lettuce (creates unilib:crop_radicchio_harvest),
            --      cucina_vegana:seed_lettuce (creates unilib:crop_radicchio_seed),
            --      cucina_vegana:lettuce_1 etc (creates unilib:crop_radicchio_grow_1 etc)
            part_name = "radicchio",
            grow_orig_name = orig_name_list,
            harvest_orig_name = "cucina_vegana:lettuce",
            seed_orig_name = "cucina_vegana:seed_lettuce",
            steps = 5,

            replace_mode = mode,
            eat = 2,
            fertility_list = fertility_list,
            harvest_description = S("Radicchio"),
            -- N.B. food_radicchio group not in original code
            harvest_group_table = {
                eatable = 1, flammable = 1, food = 1, food_lettuce = 1, food_radicchio = 1,
                food_vegan = 1,
            },
            max_light = unilib.light_max,
            min_light = 12,
            seed_description = S("Radicchio Seed"),
            seed_group_table = {attached_node = 1, flammable = 4, seed_lettuce = 1},
        })

    else

        -- Adapted from cucina_vegana/lettuce_redo.lua
        unilib.register_crop_fredo({
            -- From cucina_vegana:lettuce (creates unilib:crop_radicchio_harvest),
            --      cucina_vegana:lettuce_seed (creates unilib:crop_radicchio_seed),
            --      cucina_vegana:lettuce_1 etc (creates unilib:crop_radicchio_grow_1 etc)
            part_name = "radicchio",
            grow_orig_name = orig_name_list,
            harvest_orig_name = "cucina_vegana:lettuce",
            seed_orig_name = "cucina_vegana:lettuce_seed",
            steps = 5,

            replace_mode = mode,
            eat = 2,
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
                            {items = {"unilib:crop_radicchio_seed"}, rarity = 2},
                        },
                    },
                },
                {
                    drop = {
                        items = {
                            {items = {"unilib:crop_radicchio_harvest"}, rarity = 1},
                            {items = {"unilib:crop_radicchio_harvest"}, rarity = 3},
                            {items = {"unilib:crop_radicchio_seed"}, rarity = 1},
                            {items = {"unilib:crop_radicchio_seed"}, rarity = 1},
                            {items = {"unilib:crop_radicchio_seed"}, rarity = 3},
                        },
                    },
                },
            },
            harvest_description = S("Radicchio"),
            harvest_group_table = {
                eatable = 1, flammable = 1, food = 1, food_lettuce = 1, food_radicchio = 1,
                food_vegan = 1,
            },
            min_light = 12,
            seed_description = S("Radicchio Seed"),
            seed_group_table = {
                attached_node = 1, dig_immediate = 1, flammable = 4, seed = 1, seed_lettuce = 1,
                snappy = 3,
            },
        })

    end

    if unilib.dye_from_crops_flag and unilib.pkg_executed_table["dye_basic"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            output = "unilib:dye_green 2",
            recipe = {
                {"unilib:crop_radicchio_harvest"},
            },
        })

    end
    unilib.register_craft({
        -- From cucina_vegana:lettuce
        type = "fuel",
        recipe = "unilib:crop_radicchio_harvest",
        burntime = 2,
    })

end
