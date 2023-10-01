---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    better_farming
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.produce_chilli_cayenne = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.better_farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.produce_chilli_cayenne.init()

    return {
        description = "Cayenne chilli",
        optional = "dye_basic",
    }

end

function unilib.pkg.produce_chilli_cayenne.exec()

    local orig_name_list = {}
    for i = 1, 5 do
        table.insert(orig_name_list, "better_farming:chilie_" .. i)
    end

    unilib.register_produce_fredo({
        -- From better_farming:chilie (creates unilib:produce_chilli_cayenne_harvest),
        --      better_farming:chilie_1 etc (creates unilib:produce_chilli_cayenne_grow_1 etc)
        part_name = "chilli_cayenne",
        grow_orig_name = orig_name_list,
        harvest_orig_name = "better_farming:chilie",
        description = S("Cayenne Chilli"),

        replace_mode = mode,
        eat = 2,
        grow_list = {
            {},
            {},
            {},
            {
                drop = {
                    items = {
                        {items = {"unilib:produce_chilli_cayenne_harvest"}, rarity = 1},
                        {items = {"unilib:produce_chilli_cayenne_harvest 2"}, rarity = 3},
                    }
                },
            },
            {
                drop = {
                    items = {
                        {items = {"unilib:produce_chilli_cayenne_harvest"}, rarity = 1},
                        {items = {"unilib:produce_chilli_cayenne_harvest 2"}, rarity = 3},
                    }
                },
            },
        },
        -- N.B. updated the food groups to match "produce_chilli" package
        harvest_group_table = {
            flammable = 2, food_chili_pepper = 1, food_chilli_pepper = 1, seed = 2,
        },
        min_light = 7,
    })
    if unilib.dye_from_produce_flag and unilib.pkg_executed_table["dye_basic"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            output = "unilib:dye_red",
            recipe = {
                {"unilib:produce_chilli_cayenne_harvest"},
            },
        })

    end

    unilib.register_decoration("better_farming_produce_chilli_cayenne", {
        -- From better_farming:chilie_5
        deco_type = "simple",
        decoration = "unilib:produce_chilli_cayenne_grow_5",

        noise_params = {
            octaves = 3,
            offset = -0.1,
            persist = 0.7,
            -- N.B. scale was 0.1 in original code
            scale = 0.001,
            seed = 3398,
            spread = {x = 50, y = 50, z = 50},
        },
        param2 = 3,
        sidelen = 16,
    })

end
