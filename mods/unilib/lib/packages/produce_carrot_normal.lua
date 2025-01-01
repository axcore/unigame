---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.produce_carrot_normal = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.produce_carrot_normal.init()

    return {
        description = "Normal carrot",
        optional = "dye_basic",
    }

end

function unilib.pkg.produce_carrot_normal.exec()

    local orig_name_list = {}
    for i = 1, 8 do
        table.insert(orig_name_list, "farming:carrot_" .. i)
    end

    unilib.register_produce_fredo({
        -- From farming:carrot (creates unilib:produce_carrot_normal_harvest), farming:carrot_1 etc
        --      (creates unilib:produce_carrot_normal_grow_1 etc)
        part_name = "carrot_normal",
        grow_orig_name = orig_name_list,
        harvest_orig_name = "farming:carrot",
        description = S("Normal Carrot"),

        replace_mode = mode,
        eat = 4,
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
                        {items = {"unilib:produce_carrot_normal_harvest"}, rarity = 1},
                        {items = {"unilib:produce_carrot_normal_harvest 2"}, rarity = 3},
                    },
                },
            },
            {
                drop = {
                    items = {
                        {items = {"unilib:produce_carrot_normal_harvest 2"}, rarity = 1},
                        {items = {"unilib:produce_carrot_normal_harvest 3"}, rarity = 2},
                    },
                },
            },
        },
        harvest_group_table = {flammable = 2, food_carrot = 1, seed = 2},
    })
    if unilib.setting.dye_from_produce_flag and
            unilib.global.pkg_executed_table["dye_basic"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            output = "unilib:dye_orange",
            recipe = {
                {"unilib:produce_carrot_normal_harvest"},
            },
        })

    end

    unilib.register_juice({
        ingredient = "unilib:produce_carrot_normal_harvest",
        juice_description = S("Carrot"),
        juice_type = "carrot",
        rgb = "#ed9121",

        orig_flag = true,
    })

    unilib.register_decoration_generic("farming_redo_produce_carrot_normal", {
        -- From farming_redo/mapgen.lua
        deco_type = "simple",
        decoration = "unilib:produce_carrot_normal_grow_7",

        noise_params = {
            octaves = 3,
            offset = 0,
            persist = 0.6,
            scale = 0.002,
            seed = 890,
            spread = {x = 100, y = 100, z = 100},
        },
        sidelen = 16,
    })

end
