---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.crop_cotton = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.crop_cotton.init()

    return {
        description = "Cotton",
        notes = "Cotton seeds are dropped randomly by jungle grass, and also by the wild cotton" ..
                " plant",
        optional = "dye_basic",
    }

end

function unilib.pkg.crop_cotton.exec()

    local fertility_list = {"arid_soil", "desert_soil", "ordinary_soil"}

    local orig_name_list = {}
    for i = 1, 8 do
        table.insert(orig_name_list, "farming:cotton_" .. i)
    end

    if not unilib.mtgame_tweak_flag then

        -- Adapted from minetest_game/farming
        unilib.register_crop_mtgame({
            -- From farming:cotton (creates unilib:crop_cotton_harvest), farming:seed_cotton
            --      (creates unilib:crop_cotton_seed), farming:cotton_1 etc (creates
            --      unilib:crop_cotton_grow_1 etc)
            part_name = "cotton",
            grow_orig_name = orig_name_list,
            harvest_orig_name = "farming:cotton",
            seed_orig_name = "farming:seed_cotton",
            steps = 8,

            replace_mode = mode,
            fertility_list = fertility_list,
            harvest_description = S("Cotton"),
            -- N.B. The thread group is added by the sounding_line mod
            harvest_group_table = {flammable = 4, thread = 1},
            max_light = unilib.light_max,
            min_light = 13,
            seed_description = S("Cotton Seed"),
        })

    else

        -- Adapted from farming_redo/crops/cotton.lua
        unilib.register_crop_fredo({
            -- From farming:cotton (creates unilib:crop_cotton_harvest), farming:seed_cotton
            --      (creates unilib:crop_cotton_seed), farming:cotton_1 etc (creates
            --      unilib:crop_cotton_grow_1 etc)
            part_name = "cotton",
            grow_orig_name = orig_name_list,
            harvest_orig_name = "farming:cotton",
            seed_orig_name = "farming:seed_cotton",
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
                            {items = {"unilib:crop_cotton_seed"}, rarity = 1},
                        },
                    },
                },
                {
                    drop = {
                        items = {
                            {items = {"unilib:crop_cotton_harvest"}, rarity = 1},
                            {items = {"unilib:crop_cotton_harvest"}, rarity = 2},
                        },
                    },
                },
                {
                    drop = {
                        items = {
                            {items = {"unilib:crop_cotton_harvest"}, rarity = 1},
                            {items = {"unilib:crop_cotton_harvest"}, rarity = 2},
                            {items = {"unilib:crop_cotton_seed"}, rarity = 1},
                            {items = {"unilib:crop_cotton_seed"}, rarity = 2},
                        },
                    },
                },
                {
                    drop = {
                        items = {
                            {items = {"unilib:crop_cotton_harvest"}, rarity = 1},
                            {items = {"unilib:crop_cotton_harvest"}, rarity = 2},
                            {items = {"unilib:crop_cotton_harvest"}, rarity = 3},
                            {items = {"unilib:crop_cotton_seed"}, rarity = 1},
                            {items = {"unilib:crop_cotton_seed"}, rarity = 2},
                            {items = {"unilib:crop_cotton_seed"}, rarity = 3},
                        },
                    },
                },
            },
            harvest_description = S("Cotton"),
            -- N.B. The thread group is added by the sounding_line mod
            harvest_group_table = {flammable = 4, thread = 1},
            seed_description = S("Cotton Seed"),
            seed_group_table = {attached_node = 1, flammable = 4, seed = 1, snappy = 3},
        })

    end

    if unilib.dye_from_crops_flag and unilib.pkg_executed_table["dye_basic"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            output = "unilib:dye_white 2",
            recipe = {
                {"unilib:crop_cotton_harvest"},
            },
        })

    end
    unilib.register_craft({
        -- From farming:cotton
        type = "fuel",
        recipe = "unilib:crop_cotton_harvest",
        burntime = 1,
    })

end
