---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    better_farming
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.produce_asparagus_green = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.better_farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.produce_asparagus_green.init()

    return {
        description = "Green asparagus",
        optional = "dye_basic",
    }

end

function unilib.pkg.produce_asparagus_green.exec()

    local orig_name_list = {}
    for i = 1, 5 do
        table.insert(orig_name_list, "better_farming:aspargus_" .. i)
    end

    unilib.register_produce_fredo({
        -- From better_farming:aspargus (creates unilib:produce_asparagus_green_harvest),
        --      better_farming:aspargus_1 etc (creates unilib:produce_asparagus_green_grow_1 etc)
        part_name = "asparagus_green",
        grow_orig_name = orig_name_list,
        harvest_orig_name = "better_farming:aspargus",
        description = S("Green Asparagus"),

        replace_mode = mode,
        eat = 1,
        grow_list = {
            {},
            {},
            {},
            {
                drop = {
                    items = {
                        {items = {"unilib:produce_asparagus_green_harvest"}, rarity = 1},
                        {items = {"unilib:produce_asparagus_green_harvest 2"}, rarity = 3},
                    }
                },
            },
            {
                drop = {
                    items = {
                        {items = {"unilib:produce_asparagus_green_harvest"}, rarity = 1},
                        {items = {"unilib:produce_asparagus_green_harvest 2"}, rarity = 3},
                    }
                },
            },
        },
        harvest_group_table = {flammable = 2, food_asparagus = 1, seed = 2},

        min_light = 7,
    })
    if unilib.dye_from_produce_flag and unilib.pkg_executed_table["dye_basic"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            output = "unilib:dye_green",
            recipe = {
                {"unilib:produce_asparagus_green_harvest"},
            },
        })

    end

    unilib.register_decoration("better_farming_produce_asparagus_green", {
        -- From better_farming:aspargus_5
        deco_type = "simple",
        decoration = "unilib:produce_asparagus_green_grow_5",

        noise_params = {
            octaves = 3,
            offset = -0.1,
            persist = 0.7,
            -- N.B. scale was 0.1 in original code
            scale = 0.001,
            seed = 4502,
            spread = {x = 50, y = 50, z = 50},
        },
        param2 = 3,
        sidelen = 16,
    })

end
