---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    better_farming
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.produce_herb_medicinal = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.better_farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.produce_herb_medicinal.init()

    return {
        description = "Medicinal herb",
        optional = "dye_basic",
    }

end

function unilib.pkg.produce_herb_medicinal.exec()

    local orig_name_list = {}
    for i = 1, 4 do
        table.insert(orig_name_list, "better_farming:medecinal_plant_" .. i)
    end

    unilib.register_produce_fredo({
        -- From better_farming:medecinal_plant (creates unilib:produce_herb_medicinal_harvest),
        --      better_farming:medecinal_plant_1 etc (creates
        --      unilib:produce_herb_medicinal_grow_1 etc)
        part_name = "herb_medicinal",
        grow_orig_name = orig_name_list,
        harvest_orig_name = "better_farming:medecinal_plant",
        description = S("Medicinal Herb"),

        replace_mode = mode,
        -- N.B. Original code uses values 1 and 3
        eat = 3,
        grow_list = {
            {},
            {},
            {
                drop = {
                    items = {
                        {items = {"unilib:produce_herb_medicinal_harvest"}, rarity = 1},
                        {items = {"unilib:produce_herb_medicinal_harvest 2"}, rarity = 3},
                    },
                },
            },
            {
                drop = {
                    items = {
                        {items = {"unilib:produce_herb_medicinal_harvest 2"}, rarity = 1},
                        {items = {"unilib:produce_herb_medicinal_harvest 2"}, rarity = 3},
                    },
                },
            },
        },
        harvest_group_table = {flammable = 2, food_herb_medicinal = 1, seed = 2},
        min_light = 7,
    })
    if unilib.setting.dye_from_produce_flag and
            unilib.global.pkg_executed_table["dye_basic"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            output = "unilib:dye_green_dark",
            recipe = {
                {"unilib:produce_herb_medicinal_harvest"},
            },
        })

    end

    unilib.register_decoration_generic("better_farming_produce_herb_medicinal", {
        -- From better_farming:medecinal_plant_4
        deco_type = "simple",
        decoration = "better_farming:medecinal_plant_4",

        noise_params = {
            octaves = 3,
            offset = -0.1,
            persist = 0.7,
            -- N.B. scale was 0.1 in original code
            scale = 0.001,
            seed = 5860,
            spread = {x = 50, y = 50, z = 50},
        },
        param2 = 3,
        sidelen = 16,
    })

end
