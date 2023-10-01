---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cucina_vegana
-- Code:    LGPL3.0
-- Media:   LGPL3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.crop_flax_golden = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.cucina_vegana.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.crop_flax_golden.init()

    return {
        description = "Golden Flax (as a crop)",
        notes = "Roasted flax (if the package is loaded) is used in many crafting recipes",
        optional = "dye_basic",
    }

end

function unilib.pkg.crop_flax_golden.exec()

    local fertility_list = {"ordinary_soil"}

    local orig_name_list = {}
    for i = 1, 6 do
        table.insert(orig_name_list, "cucina_vegana:flax_" .. i)
    end

    if not unilib.cucina_vegana_redo_flag then

        -- Adapted from cucina_vegana/flax_default.lua
        unilib.register_crop_mtgame({
            -- From cucina_vegana:flax (creates unilib:crop_flax_golden_harvest),
            --      cucina_vegana:seed_flax (creates unilib:crop_flax_golden_seed),
            --      cucina_vegana:flax_1 etc (creates unilib:crop_flax_golden_grow_1 etc)
            part_name = "flax_golden",
            grow_orig_name = orig_name_list,
            harvest_orig_name = "cucina_vegana:flax",
            seed_orig_name = "cucina_vegana:seed_flax",
            steps = 6,

            replace_mode = mode,
            fertility_list = fertility_list,
            harvest_description = S("Raw Golden Flax"),
            -- N.B. crop_flax = 1 not in original code; added to match "crop_flax_brown" package
            harvest_group_table = {crop_flax = 1, flammable = 1, string = 1},
            max_light = unilib.light_max,
            min_light = 10,
            seed_description = S("Golden Flax Seed"),
            seed_group_table = {attached_node = 1, flammable = 4, seed_flax = 1},
        })

    else

        -- Adapted from cucina_vegana/flax_redo.lua
        unilib.register_crop_fredo({
            -- From cucina_vegana:flax (creates unilib:crop_flax_golden_harvest),
            --      cucina_vegana:flax_seed (creates unilib:crop_flax_golden_seed),
            --      cucina_vegana:flax_1 etc (creates unilib:crop_flax_golden_grow_1 etc)
            part_name = "flax_golden",
            grow_orig_name = orig_name_list,
            harvest_orig_name = "cucina_vegana:flax",
            seed_orig_name = "cucina_vegana:flax_seed",
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
                            {items = {"unilib:crop_flax_golden_seed"}, rarity = 2},
                        },
                    },
                },
                {
                    drop = {
                        items = {
                            {items = {"unilib:crop_flax_golden_harvest 3"}, rarity = 1},
                            {items = {"unilib:crop_flax_golden_harvest 4"}, rarity = 3},
                            {items = {"unilib:crop_flax_golden_seed 3"}, rarity = 1},
                            {items = {"unilib:crop_flax_golden_seed 4"}, rarity = 3},
                        },
                    },
                },
            },
            harvest_description = S("Golden Flax"),
            -- N.B. crop_flax = 1 not in original code; added to match "crop_flax_brown" package
            harvest_group_table = {crop_flax = 1, flammable = 1, string = 1},
            min_light = 10,
            seed_description = S("Golden Flax Seed"),
            seed_group_table = {
                attached_node = 1, dig_immediate = 1, flammable = 4, seed = 1, seed_flax = 1,
                snappy = 3,
            },
        })

    end

    if unilib.dye_from_crops_flag and unilib.pkg_executed_table["dye_basic"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            output = "unilib:dye_orange 2",
            recipe = {
                {"unilib:crop_flax_golden_harvest"},
            },
        })

    end
    unilib.register_craft({
        -- From cucina_vegana:flax_seed
        type = "fuel",
        recipe = "unilib:crop_flax_golden_seed",
        burntime = 10,
    })

end
