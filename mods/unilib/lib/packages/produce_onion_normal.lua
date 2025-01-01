---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.produce_onion_normal = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.produce_onion_normal.init()

    return {
        description = "Normal Onion",
        optional = "dye_basic",
    }

end

function unilib.pkg.produce_onion_normal.exec()

    local orig_name_list = {}
    for i = 1, 5 do
        table.insert(orig_name_list, "farming:onion_" .. i)
    end

    unilib.register_produce_fredo({
        -- From farming:onion (creates unilib:produce_onion_normal_harvest), farming:onion_1 etc
        --      (creates unilib:produce_onion_normal_grow_1 etc)
        part_name = "onion_normal",
        grow_orig_name = orig_name_list,
        harvest_orig_name = "farming:onion",
        description = S("Normal Onion"),

        replace_mode = mode,
        eat = 1,
        grow_group_table = {
            attached_node = 1, flammable = 3, growing = 1, not_in_creative_inventory = 1, plant = 1,
            snappy = 3,
        },
        grow_list = {
            {},
            {},
            {},
            {},
            {
                drop = {
                    max_items = 5,
                    items = {
                        {items = {"unilib:produce_onion_normal_harvest"}, rarity = 1},
                        {items = {"unilib:produce_onion_normal_harvest"}, rarity = 1},
                        {items = {"unilib:produce_onion_normal_harvest"}, rarity = 2},
                        {items = {"unilib:produce_onion_normal_harvest"}, rarity = 2},
                        {items = {"unilib:produce_onion_normal_harvest"}, rarity = 5},
                    },
                },
            },
        },
        harvest_group_table = {flammable = 3, food_onion = 1, seed = 2},
        paramtype2 = "meshoptions",
        place_param2 = 3,
        waving = 1,
    })
    if unilib.setting.dye_from_produce_flag and
            unilib.global.pkg_executed_table["dye_basic"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            output = "unilib:dye_brown",
            recipe = {
                {"unilib:produce_onion_normal_harvest"},
            },
        })

    end

    unilib.register_juice({
        ingredient = "unilib:produce_onion_normal_harvest",
        juice_description = S("Onion"),
        juice_type = "onion",
        rgb = "#e1ae99",

        orig_flag = false,
    })

    unilib.register_decoration_generic("farming_redo_produce_onion_normal", {
        -- From farming_redo/mapgen.lua
        deco_type = "simple",
        decoration = "unilib:produce_onion_normal_grow_5",

        noise_params = {
            octaves = 3,
            offset = 0,
            persist = 0.6,
            scale = 0.002,
            seed = 912,
            spread = {x = 100, y = 100, z = 100},
        },
        sidelen = 16,
    })

end
