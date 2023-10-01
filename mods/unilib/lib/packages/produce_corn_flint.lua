---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    better_farming
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.produce_corn_flint = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.better_farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.produce_corn_flint.init()

    return {
        description = "Flint corn",
        optional = "dye_basic",
    }

end

function unilib.pkg.produce_corn_flint.exec()

    local orig_name_list = {}
    for i = 1, 8 do
        table.insert(orig_name_list, "better_farming:corn_" .. i)
    end

    unilib.register_produce_fredo({
        -- From better_farming:corn (creates unilib:produce_corn_flint_harvest),
        --      better_farming:corn_1 etc (creates unilib:produce_corn_flint_grow_1 etc)
        part_name = "corn_flint",
        grow_orig_name = orig_name_list,
        harvest_orig_name = "better_farming:corn",
        description = S("Flint Corn"),

        replace_mode = mode,
        eat = 1,
        grow_list = {
            {},
            {},
            {},
            {},
            {
                visual_scale = 1.95,
            },
            {
                visual_scale = 1.95,
            },
            {
                drop = {
                    items = {
                        {items = {"unilib:produce_corn_flint_harvest"}, rarity = 1},
                        {items = {"unilib:produce_corn_flint_harvest 2"}, rarity = 3},
                    }
                },
                visual_scale = 1.95,
            },
            {
                drop = {
                    items = {
                        {items = {"unilib:produce_corn_flint_harvest"}, rarity = 1},
                        {items = {"unilib:produce_corn_flint_harvest 2"}, rarity = 3},
                    }
                },
                visual_scale = 1.95,
            },
        },
        harvest_group_table = {flammable = 2, food_corn = 1, seed = 2},
        min_light = 7,
    })
    if unilib.dye_from_produce_flag and unilib.pkg_executed_table["dye_basic"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            output = "unilib:dye_yellow",
            recipe = {
                {"unilib:produce_corn_flint_harvest"},
            },
        })

    end

    unilib.register_decoration("better_farming_produce_corn_flint", {
        -- From better_farming:corn_8
        deco_type = "simple",
        decoration = "unilib:produce_corn_flint_grow_8",

        noise_params = {
            octaves = 3,
            offset = -0.1,
            persist = 0.7,
            -- N.B. scale was 0.1 in original code
            scale = 0.001,
            seed = 4487,
            spread = {x = 50, y = 50, z = 50},
        },
        param2 = 3,
        sidelen = 16,
    })

end
