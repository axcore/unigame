---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cucina_vegana
-- Code:    LGPL3.0
-- Media:   LGPL3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.crop_rice_brown = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.cucina_vegana.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.crop_rice_brown.init()

    return {
        description = "Brown rice",
        optional = "dye_basic",
    }

end

function unilib.pkg.crop_rice_brown.exec()

    local fertility_list = {"ordinary_soil"}

    local orig_name_list = {}
    for i = 1, 6 do
        table.insert(orig_name_list, "cucina_vegana:rice_" .. i)
    end

    if not unilib.cucina_vegana_redo_flag then

        -- Adapted from cucina_vegana/rice_default.lua
        unilib.register_crop_mtgame({
            -- From cucina_vegana:rice (creates unilib:crop_rice_brown_harvest),
            --      cucina_vegana:seed_rice (creates unilib:crop_rice_brown_seed),
            --      cucina_vegana:rice_1 etc (creates unilib:crop_rice_brown_grow_1 etc)
            part_name = "rice_brown",
            grow_orig_name = orig_name_list,
            harvest_orig_name = "cucina_vegana:rice",
            seed_orig_name = "cucina_vegana:seed_rice",
            steps = 6,

            replace_mode = mode,
            fertility_list = fertility_list,
            harvest_description = S("Brown Rice"),
            harvest_group_table = {flammable = 4, food = 1, food_rice = 1},
            max_light = unilib.light_max,
            min_light = 12,
            -- N.B. Renamed from "seed" to match the "crop_rice_white" packagge
            seed_description = S("Brown Rice Grains"),
            seed_group_table = {attached_node = 1, flammable = 4},
        })

    else

        -- Adapted from cucina_vegana/rice_redo.lua
        unilib.register_crop_fredo({
            -- From cucina_vegana:rice (creates unilib:crop_rice_brown_harvest),
            --      cucina_vegana:rice_seed (creates unilib:crop_rice_brown_seed),
            --      cucina_vegana:rice_1 etc (creates unilib:crop_rice_brown_grow_1 etc)
            part_name = "rice_brown",
            grow_orig_name = orig_name_list,
            harvest_orig_name = "cucina_vegana:rice",
            seed_orig_name = "cucina_vegana:rice_seed",
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
                {
                    drop = {
                        items = {
                            {items = {"unilib:crop_rice_brown_seed"}, rarity = 2},
                        },
                    },
                },
                {
                    drop = {
                        items = {
                            {items = {"unilib:crop_rice_brown_seed"}, rarity = 1},
                            {items = {"unilib:crop_rice_brown_seed"}, rarity = 2},
                            {items = {"unilib:crop_rice_brown_harvest"}, rarity = 3},
                        },
                    },
                },
                {
                    drop = {
                        items = {
                            {items = {"unilib:crop_rice_brown_harvest"}, rarity = 1},
                            {items = {"unilib:crop_rice_brown_harvest"}, rarity = 2},
                            {items = {"unilib:crop_rice_brown_harvest"}, rarity = 3},
                            {items = {"unilib:crop_rice_brown_seed"}, rarity = 1},
                            {items = {"unilib:crop_rice_brown_seed"}, rarity = 1},
                            {items = {"unilib:crop_rice_brown_seed"}, rarity = 3},
                        },
                    },
                },
            },
            harvest_description = S("Brown Rice"),
            harvest_group_table = {flammable = 4, food = 1, food_rice = 1},
            min_light = 12,
            -- N.B. Renamed from "seed" to match the "crop_rice_white" packagge
            seed_description = S("Brown Rice Grains"),
            seed_group_table = {
                attached_node = 1, dig_immediate = 1, flammable = 4, seed = 1, snappy = 3,
            },
        })

    end

    if unilib.dye_from_crops_flag and unilib.pkg_executed_table["dye_basic"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            output = "unilib:dye_brown 2",
            recipe = {
                {"unilib:crop_rice_brown_harvest"},
            },
        })

    end
    unilib.register_craft({
        -- From cucina_vegana:rice
        type = "fuel",
        recipe = "unilib:crop_rice_brown_harvest",
        burntime = 5,
    })

end
