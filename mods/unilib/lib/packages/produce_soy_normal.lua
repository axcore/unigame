---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.produce_soy_normal = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.produce_soy_normal.init()

    return {
        description = "Normal soy pod",
        notes = "In order to grow normal soy, plant the soy pod, not soy beans",
        optional = "dye_basic",
    }

end

function unilib.pkg.produce_soy_normal.exec()

    local orig_name_list = {}
    for i = 1, 7 do
        table.insert(orig_name_list, "farming:soy_" .. i)
    end

    unilib.register_produce_fredo({
        -- From farming:soy_pod (creates unilib:produce_soy_normal_harvest), farming:soy_1 etc
        --      (creates unilib:produce_soy_normal_grow_1 etc)
        part_name = "soy_normal",
        grow_orig_name = orig_name_list,
        harvest_orig_name = "farming:soy_pod",
        description = S("Normal Soy Pod"),

        replace_mode = mode,
        -- (not edible)
        grow_list = {
            {},
            {},
            {},
            {},
            {
                drop = {
                    max_items = 1,
                    items = {
                        {items = {"unilib:produce_soy_normal_harvest"}, rarity = 1},
                    },
                },
            },
            {
                drop = {
                    max_items = 3,
                    items = {
                        {items = {"unilib:produce_soy_normal_harvest"}, rarity = 1},
                        {items = {"unilib:produce_soy_normal_harvest"}, rarity = 2},
                        {items = {"unilib:produce_soy_normal_harvest"}, rarity = 3},
                    },
                },
            },
            {
                drop = {
                    max_items = 5,
                    items = {
                        {items = {"unilib:produce_soy_normal_harvest"}, rarity = 1},
                        {items = {"unilib:produce_soy_normal_harvest"}, rarity = 2},
                        {items = {"unilib:produce_soy_normal_harvest"}, rarity = 3},
                        {items = {"unilib:produce_soy_normal_harvest"}, rarity = 4},
                        {items = {"unilib:produce_soy_normal_harvest"}, rarity = 5},
                    },
                },
            },
        },
        harvest_group_table = {flammable = 2, food_soy_pod = 1, seed = 2},
        paramtype2 = "meshoptions",
        place_param2 = 3,
        waving = 1,
    })
    if unilib.setting.dye_from_produce_flag and
            unilib.global.pkg_executed_table["dye_basic"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            output = "unilib:dye_yellow",
            recipe = {
                {"unilib:produce_soy_normal_harvest"},
            },
        })

    end

    unilib.register_decoration_generic("farming_redo_produce_soy_normal", {
        -- From farming_redo/mapgen.lua
        -- N.B. The original code does not use the final growth stage for the decoration
        deco_type = "simple",
        decoration = "unilib:produce_soy_normal_grow_5",

        noise_params = {
            octaves = 3,
            offset = 0,
            persist = 0.6,
            scale = 0.002,
            seed = 809,
            spread = {x = 100, y = 100, z = 100},
        },
        sidelen = 16,
    })

end
