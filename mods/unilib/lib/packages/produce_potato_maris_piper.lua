---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    better_farming
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.produce_potato_maris_piper = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.better_farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.produce_potato_maris_piper.init()

    return {
        description = "Maris piper potato",
        optional = "dye_basic",
    }

end

function unilib.pkg.produce_potato_maris_piper.exec()

    local orig_name_list = {}
    for i = 1, 4 do
        table.insert(orig_name_list, "better_farming:potatoes_" .. i)
    end

    unilib.register_produce_fredo({
        -- From better_farming:potatoes (creates unilib:produce_potato_maris_piper_harvest),
        --      better_farming:potatoes_1 etc (creates unilib:produce_potato_maris_piper_grow_1 etc)
        part_name = "potato_maris_piper",
        grow_orig_name = orig_name_list,
        harvest_orig_name = "better_farming:potatoes",
        description = S("Maris Piper Potato"),

        replace_mode = mode,
        eat = 1,
        grow_list = {
            {},
            {},
            {
                drop = {
                    items = {
                        {items = {"unilib:produce_potato_maris_piper_harvest"}, rarity = 1},
                        {items = {"unilib:produce_potato_maris_piper_harvest 2"}, rarity = 3},
                    },
                },
            },
            {
                drop = {
                    items = {
                        {items = {"unilib:produce_potato_maris_piper_harvest 2"}, rarity = 1},
                        {items = {"unilib:produce_potato_maris_piper_harvest 2"}, rarity = 3},
                    },
                },
            },
        },
        -- N.B. Added food_potato group to match "produce_potato" package
        harvest_group_table = {flammable = 2, food_potato = 1, food_potatoes = 1, seed = 2},
        min_light = 7,
    })
    if unilib.setting.dye_from_produce_flag and
            unilib.global.pkg_executed_table["dye_basic"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            output = "unilib:dye_brown",
            recipe = {
                {"unilib:produce_potato_maris_piper_harvest"},
            },
        })

    end

    unilib.register_juice({
        ingredient = "unilib:produce_potato_maris_piper_harvest",
        juice_description = S("Potato"),
        juice_type = "potato",
        rgb = "#d19d0b",

        orig_flag = false,
    })

    unilib.register_decoration_generic("better_farming_produce_potato_maris_piper", {
        -- From better_farming:potatoes_4
        deco_type = "simple",
        decoration = "unilib:produce_potato_maris_piper_grow_4",

        noise_params = {
            octaves = 3,
            offset = -0.1,
            persist = 0.7,
            -- N.B. scale was 0.1 in original code
            scale = 0.001,
            seed = 2008,
            spread = {x = 50, y = 50, z = 50},
        },
        param2 = 3,
        sidelen = 16,
    })

end
