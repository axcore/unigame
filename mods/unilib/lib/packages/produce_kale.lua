---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    better_farming
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.produce_kale = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.better_farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.produce_kale.init()

    return {
        description = "Kale",
        optional = "dye_basic",
    }

end

function unilib.pkg.produce_kale.exec()

    local orig_name_list = {}
    for i = 1, 3 do
        table.insert(orig_name_list, "better_farming:kale_" .. i)
    end

    unilib.register_produce_fredo({
        -- From better_farming:kale (creates unilib:produce_kale_harvest), better_farming:kale_1
        --      etc (creates unilib:produce_kale_grow_1 etc)
        part_name = "kale",
        grow_orig_name = orig_name_list,
        harvest_orig_name = "better_farming:kale",
        description = S("Kale"),

        replace_mode = mode,
        eat = 1,
        grow_list = {
            {},
            {
                drop = {
                    items = {
                        {items = {"unilib:produce_kale_harvest"}, rarity = 1},
                        {items = {"unilib:produce_kale_harvest 2"}, rarity = 3},
                    },
                },
            },
            {
                drop = {
                    items = {
                        {items = {"unilib:produce_kale_harvest"}, rarity = 1},
                        {items = {"unilib:produce_kale_harvest 3"}, rarity = 3},
                    },
                },
            },
        },
        harvest_group_table = {flammable = 2, food_kale = 1, seed = 2},
        min_light = 7,
    })
    if unilib.setting.dye_from_produce_flag and
            unilib.global.pkg_executed_table["dye_basic"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            output = "unilib:dye_green_dark",
            recipe = {
                {"unilib:produce_kale_harvest"},
            },
        })

    end

    unilib.register_juice({
        ingredient = "unilib:produce_kale_harvest",
        juice_description = S("Kale"),
        juice_type = "kale",
        rgb = "#4c8e3a",

        orig_flag = false,
    })

    unilib.register_decoration_generic("better_farming_produce_kale", {
        -- From better_farming:kale_3
        deco_type = "simple",
        decoration = "unilib:produce_kale_grow_3",

        noise_params = {
            octaves = 3,
            offset = -0.1,
            persist = 0.9,
            -- N.B. scale was 0.1 in original code
            scale = 0.001,
            seed = 4842,
            spread = {x = 50, y = 50, z = 50},
        },
        param2 = 3,
        sidelen = 16,
    })

end
