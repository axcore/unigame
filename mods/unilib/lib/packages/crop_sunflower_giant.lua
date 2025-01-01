---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.crop_sunflower_giant = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.crop_sunflower_giant.init()

    return {
        description = "Giant sunflower (as a crop)",
        notes = "Can be grown from seeds, which are crafted using the sunflower itself",
        optional = "dye_basic",
    }

end

function unilib.pkg.crop_sunflower_giant.exec()

    local fertility_list = {"ordinary_soil"}

    local orig_name_list = {}
    for i = 1, 8 do
        table.insert(orig_name_list, "farming:sunflower_" .. i)
    end

    unilib.register_crop_fredo({
        -- From farming:sunflower (creates unilib:crop_sunflower_giant_harvest),
        --      farming:seed_sunflower (creates unilib:crop_sunflower_giant_seed),
        --      farming:sunflower_1 etc (creates unilib:crop_sunflower_giant_grow_1 etc)
        -- N.B. this is a craftitem in original code
        part_name = "sunflower_giant",
        grow_orig_name = orig_name_list,
        harvest_orig_name = "farming:sunflower",
        seed_orig_name = "farming:seed_sunflower",
        steps = 8,

        replace_mode = mode,
        fertility_list = fertility_list,
        grow_list = {
            {},
            {},
            {},
            {},
            {},
            {visual_scale = 1.90},
            {visual_scale = 1.90},
            {
                drop = {
                    items = {
                        {items = {"unilib:crop_sunflower_giant_harvest"}, rarity = 1},
                        {items = {"unilib:crop_sunflower_giant_harvest"}, rarity = 6},
                    },
                },
                visual_scale = 1.90,
            },
        },
        harvest_description = S("Giant Sunflower"),
        harvest_group_table = {flammable = 2},
        min_light = 14,
        seed_description = S("Giant Sunflower Seed"),
        seed_group_table = {flammable = 2, food_sunflower_seeds = 1, seed = 2},
    })
    -- (No growth stages drop the seed, which is instead crafted directly from the sunflower)
    unilib.register_craft({
        -- From unilib:crop_sunflower_giant_harvest
        output = "unilib:crop_sunflower_giant_seed 5",
        recipe = {
            {"unilib:crop_sunflower_giant_harvest"},
        },
    })
    if unilib.setting.dye_from_crops_flag and
            unilib.global.pkg_executed_table["dye_basic"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            output = "unilib:dye_yellow 2",
            recipe = {
                {"unilib:crop_sunflower_giant_harvest"},
            },
        })

    end

    unilib.register_decoration_generic("farming_redo_crop_sunflower_giant", {
        -- From farming_redo/mapgen.lua
        deco_type = "simple",
        decoration = "unilib:crop_sunflower_giant_grow_8",

        noise_params = {
            octaves = 3,
            offset = 0,
            persist = 0.6,
            scale = 0.002,
            seed = 254,
            spread = {x = 100, y = 100, z = 100},
        },
        sidelen = 16,
    })

end
