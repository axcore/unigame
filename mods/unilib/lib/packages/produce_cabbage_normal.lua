---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.produce_cabbage_normal = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.produce_cabbage_normal.init()

    return {
        description = "Normal cabbage",
        optional = "dye_basic",
    }

end

function unilib.pkg.produce_cabbage_normal.exec()

    local orig_name_list = {}
    for i = 1, 6 do
        table.insert(orig_name_list, "farming:cabbage_" .. i)
    end

    unilib.register_produce_fredo({
        -- From farming:cabbage (creates unilib:produce_cabbage_normal_harvest),
        --      farming:cabbage_1 etc (creates unilib:produce_cabbage_normal_grow_1 etc)
        part_name = "cabbage_normal",
        grow_orig_name = orig_name_list,
        harvest_orig_name = "farming:cabbage",
        description = S("Normal Cabbage"),

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
                    max_items = 2,
                    items = {
                        {items = {"unilib:produce_cabbage_normal_harvest 2"}, rarity = 1},
                        {items = {"unilib:produce_cabbage_normal_harvest 1"}, rarity = 2},
                    },
                },
            },
        },
        harvest_group_table = {flammable = 2, food_cabbage = 1, seed = 2},
        waving = 1,
    })
    if unilib.setting.dye_from_produce_flag and
            unilib.global.pkg_executed_table["dye_basic"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            output = "unilib:dye_green",
            recipe = {
                {"unilib:produce_cabbage_normal_harvest"},
            },
        })

    end

    unilib.register_juice({
        ingredient = "unilib:produce_cabbage_normal_harvest",
        juice_description = S("Cabbage"),
        juice_type = "cabbage",
        rgb = "#a4c088",

        orig_flag = false,
    })

    unilib.register_decoration_generic("farming_redo_produce_cabbage_normal", {
        -- From farming_redo/mapgen.lua
        deco_type = "simple",
        decoration = "unilib:produce_cabbage_normal_grow_6",

        noise_params = {
            octaves = 3,
            offset = 0,
            persist = 0.6,
            scale = 0.002,
            seed = 789,
            spread = {x = 100, y = 100, z = 100},
        },
        sidelen = 16,
    })

end
