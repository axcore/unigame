---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.crop_barley = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.crop_barley.init()

    return {
        description = "Barley",
        notes = "Barley seeds are dropped randomly by dry grass",
        optional = {
            "dye_basic",
            "ingredient_flour_barley",
            "ingredient_flour_ordinary",
            "utensil_mortar_pestle",
        },
    }

end

function unilib.pkg.crop_barley.exec()

    local fertility_list = {"arid_soil"}

    local orig_name_list = {}
    for i = 1, 8 do
        table.insert(orig_name_list, "farming:barley_" .. i)
    end

    unilib.register_crop_fredo({
        -- From farming:barley (creates unilib:crop_barley_harvest), farming:seed_barley (creates
        --      unilib:crop_barley_seed), farming:barley_1 etc (creates unilib:crop_barley_grow_1
        --      etc)
        part_name = "barley",
        grow_orig_name = orig_name_list,
        harvest_orig_name = "farming:barley",
        seed_orig_name = "farming:seed_barley",
        steps = 8,

        replace_mode = mode,
        fertility_list = fertility_list,
        grow_list = {
            {},
            {},
            {},
            {},
            {},
            {
                drop = {
                    items = {
                        {items = {"unilib:crop_barley_harvest"}, rarity = 2},
                        {items = {"unilib:crop_barley_seed"}, rarity = 2},
                    },
                },
            },
            {
                drop = {
                    items = {
                        {items = {"unilib:crop_barley_harvest"}, rarity = 2},
                        {items = {"unilib:crop_barley_seed"}, rarity = 1},
                    },
                },
            },
            {
                drop = {
                    items = {
                        {items = {"unilib:crop_barley_harvest"}, rarity = 1},
                        {items = {"unilib:crop_barley_harvest"}, rarity = 3},
                        {items = {"unilib:crop_barley_seed"}, rarity = 1},
                        {items = {"unilib:crop_barley_seed"}, rarity = 3},
                    },
                },
            },
        },
        harvest_description = S("Barley"),
        harvest_group_table = {flammable = 2, food_barley = 1},
        paramtype2 = "meshoptions",
        place_param2 = 3,
        seed_description = S("Barley Seed"),
    })
    -- N.B. The "ingredient_flour_barley" package, if loaded, uses an identical recipe to craft
    --      barley flour
    if unilib.global.pkg_executed_table["ingredient_flour_ordinary"] ~= nil and
            unilib.global.pkg_executed_table["utensil_mortar_pestle"] ~= nil and
            unilib.global.pkg_executed_table["ingredient_flour_barley"] == nil then

        unilib.register_craft({
            -- From farming:barley
            output = "unilib:ingredient_flour_ordinary",
            recipe = {
                {
                    "unilib:crop_barley_harvest",
                    "unilib:crop_barley_harvest",
                    "unilib:crop_barley_harvest",
                },
                {
                    "unilib:crop_barley_harvest",
                    "unilib:utensil_mortar_pestle",
                    "",
                },
            },
            replacements = {
                {"group:food_mortar_pestle", "unilib:utensil_mortar_pestle"},
            },
        })

    end
    if unilib.setting.dye_from_crops_flag and
            unilib.global.pkg_executed_table["dye_basic"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            output = "unilib:dye_green 2",
            recipe = {
                {"unilib:crop_barley_harvest"},
            },
        })

    end
    unilib.register_craft({
        -- From farming:barley
        type = "fuel",
        recipe = "unilib:crop_barley_harvest",
        burntime = 1,
    })

end
