---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    better_farming
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.produce_bean_adzuki = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.better_farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.produce_bean_adzuki.init()

    return {
        description = "Adzuki beans",
        optional = "dye_basic",
    }

end

function unilib.pkg.produce_bean_adzuki.exec()

    local orig_name_list = {}
    for i = 1, 7 do
        table.insert(orig_name_list, "better_farming:adzuki_" .. i)
    end

    unilib.register_produce_fredo({
        -- From better_farming:adzuki (creates unilib:produce_bean_adzuki_harvest),
        --      better_farming:adzuki_1 etc (creates unilib:produce_bean_adzuki_grow_1 etc)
        -- N.B. Ignored stack_max = 150 in original code
        part_name = "bean_adzuki",
        grow_orig_name = orig_name_list,
        harvest_orig_name = "better_farming:adzuki",
        description = S("Adzuki Beans"),

        replace_mode = mode,
        eat = 1,
        grow_list = {
            {},
            {},
            {},
            {},
            {},
            {
                drop = {
                    items = {
                        {items = {"unilib:produce_bean_adzuki_harvest 2"}, rarity = 1},
                        {items = {"unilib:produce_bean_adzuki_harvest 3"}, rarity = 2},
                    },
                },
            },
            {
                drop = {
                    items = {
                        {items = {"unilib:produce_bean_adzuki_harvest 3"}, rarity = 1},
                        {items = {"unilib:produce_bean_adzuki_harvest 4"}, rarity = 3},
                    },
                },
            },
        },
        harvest_group_table = {flammable = 2, food_adzuki = 1, seed = 2},
        min_light = 7,
    })
    if unilib.setting.dye_from_produce_flag and
            unilib.global.pkg_executed_table["dye_basic"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            output = "unilib:dye_red",
            recipe = {
                {"unilib:produce_bean_adzuki_harvest"},
            },
        })

    end

    unilib.register_decoration_generic("better_farming_produce_bean_adzuki", {
        -- From better_farming:adzuki_7
        deco_type = "simple",
        decoration = "unilib:produce_bean_adzuki_grow_7",

        noise_params = {
            octaves = 3,
            offset = -0.1,
            persist = 1.2,
            -- N.B. scale was 0.1 in original code
            scale = 0.001,
            seed = 4254,
            spread = {x = 50, y = 50, z = 50},
        },
        param2 = 3,
        sidelen = 16,
    })

end
