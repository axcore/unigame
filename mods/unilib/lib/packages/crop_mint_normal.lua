---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.crop_mint_normal = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.crop_mint_normal.init()

    return {
        description = "Normal mint",
        optional = "dye_basic",
    }

end

function unilib.pkg.crop_mint_normal.exec()

    local fertility_list = {"ordinary_soil"}

    local orig_name_list = {}
    for i = 1, 4 do
        table.insert(orig_name_list, "farming:mint_" .. i)
    end

    unilib.register_crop_fredo({
        -- From farming:mint_leaf (creates unilib:crop_mint_normal_harvest), farming:seed_mint
        --      (creates unilib:crop_mint_normal_seed), farming:mint_1 etc (creates
        --      unilib:crop_mint_normal_grow_1 etc)
        part_name = "mint_normal",
        grow_orig_name = orig_name_list,
        harvest_orig_name = "farming:mint_leaf",
        seed_orig_name = "farming:seed_mint",
        steps = 4,

        replace_mode = mode,
        fertility_list = fertility_list,
        grow_list = {
            {},
            {},
            {},
            {
                drop = {
                    items = {
                        {items = {"unilib:crop_mint_normal_harvest 2"}, rarity = 1},
                        {items = {"unilib:crop_mint_normal_harvest 2"}, rarity = 2},
                        {items = {"unilib:crop_mint_normal_seed 1"}, rarity = 1},
                        {items = {"unilib:crop_mint_normal_seed 2"}, rarity = 2},
                    },
                },
            },
        },
        harvest_description = S("Normal mint Leaf"),
        harvest_group_table = {flammable = 4, food_mint = 1},
        seed_description = S("Normal mint Seed"),
        seed_group_table = {seed = 2, flammable = 2},
    })
    if unilib.setting.dye_from_crops_flag and
            unilib.global.pkg_executed_table["dye_basic"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            output = "unilib:dye_green 2",
            recipe = {
                {"unilib:crop_mint_normal_harvest"},
            },
        })

    end

    unilib.register_decoration_generic("farming_redo_crop_mint_normal", {
        -- From farming_redo/mapgen.lua
        deco_type = "simple",
        decoration = "unilib:crop_mint_normal_grow_4",

        noise_params = {
            octaves = 3,
            offset = 0,
            persist = 0.6,
            scale = 0.005,
            seed = 801,
            spread = {x = 100, y = 100, z = 100},
        },
        sidelen = 16,
    })

end
