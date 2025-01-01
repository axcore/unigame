---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.crop_wheat = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.crop_wheat.init()

    return {
        description = "Wheat",
        notes = "Wheat seeds are dropped randomly by ordinary grass",
        optional = "dye_basic",
    }

end

function unilib.pkg.crop_wheat.exec()

    local fertility_list = {"arid_soil", "ordinary_soil"}

    local orig_name_list = {}
    for i = 1, 8 do
        table.insert(orig_name_list, "farming:wheat_" .. i)
    end

    if not unilib.setting.mtgame_tweak_flag then

        -- Adapted from minetest_game/farming

        unilib.register_crop_mtgame({
            -- From farming:wheat (creates unilib:crop_wheat_harvest), farming:seed_wheat (creates
            --      unilib:crop_wheat_seed), farming:wheat_1 etc (creates unilib:crop_wheat_grow_1
            --      etc)
            part_name = "wheat",
            grow_orig_name = orig_name_list,
            harvest_orig_name = "farming:wheat",
            seed_orig_name = "farming:seed_wheat",
            steps = 8,

            replace_mode = mode,
            fertility_list = fertility_list,
            harvest_description = S("Wheat"),
            harvest_group_table = {flammable = 4, food_wheat = 1},
            max_light = unilib.constant.light_max,
            min_light = 13,
            paramtype2 = "meshoptions",
            place_param2 = 3,
            seed_description = S("Wheat Seed"),
        })

    else

        -- Adapted from farming_redo/crops/wheat.lua
        unilib.register_crop_fredo({
            -- From farming:wheat (creates unilib:crop_wheat_harvest), farming:seed_wheat (creates
            --      unilib:crop_wheat_seed), farming:wheat_1 etc (creates unilib:crop_wheat_grow_1
            --      etc)
            part_name = "wheat",
            grow_orig_name = orig_name_list,
            harvest_orig_name = "farming:wheat",
            seed_orig_name = "farming:seed_wheat",
            steps = 8,

            replace_mode = mode,
            fertility_list = fertility_list,
            grow_group_table = {
                attached_node = 1, flammable = 4, not_in_creative_inventory = 1, plant = 1,
                snappy = 3,
            },
            grow_list = {
                {},
                {},
                {},
                {},
                {
                    drop = {
                        items = {
                            {items = {"unilib:crop_wheat_harvest"}, rarity = 2},
                            {items = {"unilib:crop_wheat_seed"}, rarity = 2},
                        },
                    },
                },
                {
                    drop = {
                        items = {
                            {items = {"unilib:crop_wheat_harvest"}, rarity = 2},
                            {items = {"unilib:crop_wheat_seed"}, rarity = 1},
                        },
                    },
                },
                {
                    drop = {
                        items = {
                            {items = {"unilib:crop_wheat_harvest"}, rarity = 1},
                            {items = {"unilib:crop_wheat_harvest"}, rarity = 3},
                            {items = {"unilib:crop_wheat_seed"}, rarity = 1},
                            {items = {"unilib:crop_wheat_seed"}, rarity = 3},
                        },
                    },
                },
                {
                    drop = {
                        items = {
                            {items = {"unilib:crop_wheat_harvest"}, rarity = 1},
                            {items = {"unilib:crop_wheat_harvest"}, rarity = 3},
                            {items = {"unilib:crop_wheat_seed"}, rarity = 1},
                            {items = {"unilib:crop_wheat_seed"}, rarity = 3},
                        },
                    },
                },
            },
            harvest_description = S("Wheat"),
            harvest_group_table = {flammable = 4, food_wheat = 1},
            paramtype2 = "meshoptions",
            place_param2 = 3,
            seed_description = S("Wheat Seed"),
            seed_group_table = {attached_node = 1, flammable = 4, seed = 1, snappy = 3},
        })

    end

    if unilib.setting.dye_from_crops_flag and
            unilib.global.pkg_executed_table["dye_basic"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            output = "unilib:dye_yellow 2",
            recipe = {
                {"unilib:crop_wheat_harvest"},
            },
        })

    end

    unilib.register_craft({
        -- From farming:wheat
        type = "fuel",
        recipe = "unilib:crop_wheat_harvest",
        burntime = 1,
    })

end
