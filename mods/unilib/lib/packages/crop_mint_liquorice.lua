---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    better_farming
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.crop_mint_liquorice = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.better_farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.crop_mint_liquorice.init()

    return {
        description = "Liquorice mint",
        optional = "dye_basic",
    }

end

function unilib.pkg.crop_mint_liquorice.exec()

    local fertility_list = {"ordinary_soil"}

    local orig_name_list = {}
    for i = 1, 4 do
        table.insert(orig_name_list, "better_farming:mint_" .. i)
    end

    unilib.register_crop_mtgame({
        -- From better_farming:mint (creates unilib:crop_mint_liquorice_harvest),
        --      better_farming:seed_mint (creates unilib:crop_mint_liquorice_seed),
        --      better_farming:mint_1 etc (creates unilib:crop_mint_liquorice_grow_1 etc)
        part_name = "mint_liquorice",
        grow_orig_name = orig_name_list,
        harvest_orig_name = "better_farming:mint",
        seed_orig_name = "better_farming:seed_mint",
        steps = 4,

        replace_mode = mode,
        eat = 2,
        fertility_list = fertility_list,
        harvest_description = S("Liquorice Mint"),
        -- N.B. food_mint not in original code
        harvest_group_table = {flammable = 4, food_mint = 1},
        min_light = 7,
        seed_description = S("Liquorice Mint Seed"),
        seed_group_table = {attached_node = 1, flammable = 2, seed = 1, snappy = 3},
    })
    if unilib.dye_from_crops_flag and unilib.pkg_executed_table["dye_basic"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            output = "unilib:dye_green_dark 2",
            recipe = {
                {"unilib:crop_mint_liquorice_harvest"},
            },
        })

    end

    unilib.register_decoration("better_farming_crop_mint_liquorice", {
        -- From better_farming:mint_4
        deco_type = "simple",
        decoration = "unilib:crop_mint_liquorice_grow_4",

        noise_params = {
            octaves = 3,
            offset = -0.1,
            persist = 0.7,
            -- N.B. scale was 0.1 in original code
            scale = 0.001,
            seed = 6058,
            spread = {x = 50, y = 50, z = 50},
        },
        param2 = 3,
        sidelen = 16,
    })

end
