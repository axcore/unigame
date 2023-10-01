---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.produce_parsley_flatleaf = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.produce_parsley_flatleaf.init()

    return {
        description = "Flat-leaf parsley",
        optional = "dye_basic",
    }

end

function unilib.pkg.produce_parsley_flatleaf.exec()

    local orig_name_list = {}
    for i = 1, 3 do
        table.insert(orig_name_list, "farming:parsley_" .. i)
    end

    unilib.register_produce_fredo({
        -- From farming:parsley (creates unilib:produce_parsley_flatleaf_harvest), farming:parsley_1
        --      etc (creates unilib:produce_parsley_flatleaf_grow_1 etc)
        part_name = "parsley_flatleaf",
        grow_orig_name = orig_name_list,
        harvest_orig_name = "farming:parsley",
        description = S("Flat Leaf Parsley"),

        replace_mode = mode,
        -- (not edible)
        grow_group_table = {
            attached_node = 1, flammable = 2, growing = 1, not_in_creative_inventory = 1,
            plant = 1, snappy = 3,
        },
        grow_list = {
            {},
            {},
            {
                drop = {
                    items = {
                        {items = {"unilib:produce_parsley_flatleaf_harvest 2"}, rarity = 1},
                        {items = {"unilib:produce_parsley_flatleaf_harvest"}, rarity = 2},
                        {items = {"unilib:produce_parsley_flatleaf_harvest"}, rarity = 3},
                    },
                },
            },
        },
        harvest_group_table = {flammable = 2, food_parsley = 1, seed = 2},
        max_light = 15,
        min_light = 13,
    })
    if unilib.dye_from_produce_flag and unilib.pkg_executed_table["dye_basic"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            output = "unilib:dye_green",
            recipe = {
                {"unilib:produce_parsley_flatleaf_harvest"},
            },
        })

    end

    unilib.register_decoration("farming_redo_produce_parsley_flatleaf", {
        -- From farming_redo/mapgen.lua
        deco_type = "simple",
        decoration = "unilib:produce_parsley_flatleaf_grow_3",

        noise_params = {
            octaves = 3,
            offset = 0,
            persist = 0.6,
            scale = 0.002,
            seed = 329,
            spread = {x = 100, y = 100, z = 100},
        },
        sidelen = 16,
    })

end
