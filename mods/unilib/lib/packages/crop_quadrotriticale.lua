---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    grains
-- Code:    MIT
-- Media:   CC BY 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.crop_quadrotriticale = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.grains.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.crop_quadrotriticale.init()

    return {
        description = "Quadrotriticale (wheat/rye hybrid)",
        notes = "As a hybrid, it can be substituted into any craft recipe requiring wheat or" ..
                " rye. Quadrotriticale does not multiply its seed, when harvested, so" ..
                " additional quadrotriticale seeds must be crafted from wheat and rye seeds",
        depends = {"crop_rye", "crop_wheat", "dye_basic", "ingredient_sugar_normal"},
    }

end

function unilib.pkg.crop_quadrotriticale.exec()

    local c_rye = "unilib:crop_rye_seed"
    local c_wheat = "unilib:crop_wheat_seed"

    local fertility_list = {"ordinary_soil"}

    unilib.register_crop_fredo({
        -- Code original to unilib, textures from barley in the "grains" mod. Creates
        --      unilib:crop_quadrotriticale_harvest, unilib:crop_quadrotriticale_seed,
        --      unilib:crop_quadrotriticale_grow_1 etc
        part_name = "quadrotriticale",
        grow_orig_name = {},
        harvest_orig_name = nil,
        seed_orig_name = nil,
        steps = 8,

        replace_mode = mode,
        fertility_list = fertility_list,
        -- N.B. Seed output has been reduced, to force the player to craft quadrotriticale seeds
        grow_list = {
            {},
            {},
            {},
            {},
            {},
            {},
            {
                drop = {
                    items = {
                        {items = {"unilib:crop_quadrotriticale_harvest"}, rarity = 2},
                        {items = {"unilib:crop_quadrotriticale_seed"}, rarity = 2},
                    },
                },
            },
            {
                drop = {
                    items = {
                        {items = {"unilib:crop_quadrotriticale_harvest"}, rarity = 1},
                        {items = {"unilib:crop_quadrotriticale_harvest"}, rarity = 3},
                        {items = {"unilib:crop_quadrotriticale_seed"}, rarity = 2},
                    },
                },
            },
        },
        harvest_description = S("Quadrotriticale"),
        -- (As a wheat/rye hybrid hybrid, quadrotriticale can substitute for either in any craft
        --      recipes)
        harvest_group_table = {
            flammable = 2, food_quadrotrticale = 1, food_rye = 1, food_wheat = 1,
        },
        paramtype2 = "meshoptions",
        place_param2 = 3,
        seed_description = S("Quadrotriticale Seed"),
    })
    unilib.register_craft({
        -- Original to unilib
        output = "unilib:crop_quadrotriticale_seed",
        recipe = {
            {c_rye, c_wheat, c_rye},
            {c_wheat, "unilib:ingredient_sugar_normal", c_wheat},
            {c_rye, c_wheat, c_rye},
        },
    })
    if unilib.dye_from_crops_flag and unilib.pkg_executed_table["dye_basic"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            output = "unilib:dye_grey_dark 2",
            recipe = {
                {"unilib:crop_quadrotriticale_harvest"},
            },
        })

    end
    unilib.register_craft({
        -- Original to unilib
        type = "fuel",
        recipe = "unilib:crop_quadrotriticale_harvest",
        burntime = 2,
    })

end
