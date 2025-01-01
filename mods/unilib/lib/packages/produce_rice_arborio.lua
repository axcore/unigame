---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    better_farming
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.produce_rice_arborio = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.better_farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.produce_rice_arborio.init()

    return {
        description = "Arborio rice",
        optional = "dye_basic",
    }

end

function unilib.pkg.produce_rice_arborio.exec()

    local orig_name_list = {}
    for i = 1, 8 do
        table.insert(orig_name_list, "better_farming:rice_" .. i)
    end

    unilib.register_produce_fredo({
        -- From better_farming:rice_arborio (creates unilib:produce_rice_arborio_harvest),
        --      better_farming:rice_1 etc (creates unilib:produce_rice_arborio_grow_1 etc)
        -- N.B. Ignored stack_max = 300 in original code
        part_name = "rice_arborio",
        grow_orig_name = orig_name_list,
        harvest_orig_name = "better_farming:rice",
        description = S("Arborio Rice"),

        replace_mode = mode,
        eat = 1,
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
                        {items = {"unilib:produce_rice_arborio_harvest 3"}, rarity = 1},
                        {items = {"unilib:produce_rice_arborio_harvest 5"}, rarity = 2},
                    },
                },
            },
            {
                drop = {
                    items = {
                        {items = {"unilib:produce_rice_arborio_harvest 3"}, rarity = 1},
                        {items = {"unilib:produce_rice_arborio_harvest 7"}, rarity = 3},
                    },
                },
            },
        },
        harvest_group_table = {flammable = 2, food_rice = 1, seed = 2},
        min_light = 7,
    })
    if unilib.setting.dye_from_produce_flag and
            unilib.global.pkg_executed_table["dye_basic"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            output = "unilib:dye_white",
            recipe = {
                {"unilib:produce_rice_arborio_harvest"},
            },
        })

    end

    unilib.register_decoration_generic("better_farming_produce_rice_arborio", {
        -- From better_farming:rice_8
        deco_type = "simple",
        decoration = "unilib:produce_rice_arborio_grow_8",

        noise_params = {
            octaves = 3,
            offset = -0.1,
            persist = 0.7,
            -- N.B. scale was 0.1 in original code
            scale = 0.001,
            seed = 7859,
            spread = {x = 50, y = 50, z = 50},
        },
        param2 = 3,
        sidelen = 16,
    })

end
