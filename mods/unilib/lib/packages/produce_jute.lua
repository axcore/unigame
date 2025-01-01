---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    better_farming
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.produce_jute = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.better_farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.produce_jute.init()

    return {
        description = "Jute",
        optional = "dye_basic",
    }

end

function unilib.pkg.produce_jute.exec()

    local orig_name_list = {}
    for i = 1, 3 do
        table.insert(orig_name_list, "better_farming:jute_" .. i)
    end

    unilib.register_produce_fredo({
        -- From better_farming:jute (creates unilib:produce_jute_harvest), better_farming:jute_1
        --      etc (creates unilib:produce_jute_grow_1 etc)
        part_name = "jute",
        grow_orig_name = orig_name_list,
        harvest_orig_name = "better_farming:jute",
        description = S("Jute"),

        replace_mode = mode,
        eat = 1,
        grow_list = {
            {},
            {
                drop = {
                    items = {
                        {items = {"unilib:produce_jute_harvest"}, rarity = 1},
                        {items = {"unilib:produce_jute_harvest 2"}, rarity = 3},
                    },
                },
            },
            {
                drop = {
                    items = {
                        {items = {"unilib:produce_jute_harvest"}, rarity = 1},
                        {items = {"unilib:produce_jute_harvest 3"}, rarity = 3},
                    },
                },
            },
        },
        harvest_group_table = {flammable = 2, food_jute = 1, seed = 2},
        min_light = 7,
    })
    if unilib.setting.dye_from_produce_flag and
            unilib.global.pkg_executed_table["dye_basic"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            output = "unilib:dye_yellow",
            recipe = {
                {"unilib:produce_jute_harvest"},
            },
        })

    end

    unilib.register_decoration_generic("better_farming_produce_jute", {
        -- From better_farming:jute_3
        deco_type = "simple",
        decoration = "unilib:produce_jute_grow_3",

        noise_params = {
            octaves = 3,
            offset = -0.1,
            persist = 1.1,
            -- N.B. scale was 0.1 in original code
            scale = 0.001,
            seed = 4025,
            spread = {x = 50, y = 50, z = 50},
        },
        param2 = 3,
        sidelen = 16,
    })

end
