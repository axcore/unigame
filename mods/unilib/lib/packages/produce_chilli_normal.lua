---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.produce_chilli_normal = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.produce_chilli_normal.init()

    return {
        description = "Normal chilli pepper",
        optional = "dye_basic",
    }

end

function unilib.pkg.produce_chilli_normal.exec()

    local orig_name_list = {}
    for i = 1, 8 do
        table.insert(orig_name_list, "farming:chili_" .. i)
    end

    unilib.register_produce_fredo({
        -- From farming:chili (creates unilib:produce_chilli_normal_harvest), farming:chili_1 etc
        --      (creates unilib:produce_chilli_normal_grow_1 etc)
        part_name = "chilli_normal",
        grow_orig_name = orig_name_list,
        harvest_orig_name = "farming:chili",
        description = S("Normal Chilli Pepper"),

        replace_mode = mode,
        eat = 2,
        grow_group_table = {
            attached_node = 1, flammable = 4, growing = 1, not_in_creative_inventory = 1,
            plant = 1, snappy = 3,
        },
        grow_list = {
            {},
            {},
            {},
            {},
            {},
            {},
            {},
            {
                drop = {
                    items = {
                        {items = {"unilib:produce_chilli_normal_harvest 3"}, rarity = 1},
                        {items = {"unilib:produce_chilli_normal_harvest 2"}, rarity = 2},
                    },
                },
            },
        },
        -- (Standard and American spellings, just in case)
        harvest_group_table = {
            flammable = 4, food_chili_pepper = 1, food_chilli_pepper = 1, seed = 2,
        },
    })
    if unilib.dye_from_produce_flag and unilib.pkg_executed_table["dye_basic"] ~= nil then

        unilib.register_craft({
            -- From farming:chili
            output = "unilib:dye_red",
            -- N.B. group:food_chilli_pepper in original code
            recipe = {
                {"unilib:produce_chilli_normal_harvest"},
            }
        })

    end

    unilib.register_decoration("farming_redo_produce_chilli_normal", {
        -- From farming_redo/mapgen.lua
        deco_type = "simple",
        decoration = "unilib:produce_chilli_normal_grow_8",

        noise_params = {
            octaves = 3,
            offset = 0,
            persist = 0.6,
            scale = 0.003,
            seed = 760,
            spread = {x = 100, y = 100, z = 100},
        },
        sidelen = 16,
    })

end
