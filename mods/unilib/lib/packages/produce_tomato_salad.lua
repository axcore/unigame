---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.produce_tomato_salad = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.produce_tomato_salad.init()

    return {
        description = "Salad tomato",
        optional = "dye_basic",
    }

end

function unilib.pkg.produce_tomato_salad.exec()

    local orig_name_list = {}
    for i = 1, 8 do
        table.insert(orig_name_list, "farming:tomato_" .. i)
    end

    unilib.register_produce_fredo({
        -- From farming:tomato (creates unilib:produce_tomato_salad_harvest), farming:tomato_1 etc
        --      (creates unilib:produce_tomato_salad_grow_1 etc)
        part_name = "tomato_salad",
        grow_orig_name = orig_name_list,
        harvest_orig_name = "farming:tomato",
        description = S("Salad Tomato"),

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
                        {items = {"unilib:produce_tomato_salad_harvest"}, rarity = 1},
                        {items = {"unilib:produce_tomato_salad_harvest"}, rarity = 3},
                    },
                },
            },
            {
                drop = {
                    items = {
                        {items = {"unilib:produce_tomato_salad_harvest 3"}, rarity = 1},
                        {items = {"unilib:produce_tomato_salad_harvest 2"}, rarity = 2},
                        {items = {"unilib:produce_tomato_salad_harvest 1"}, rarity = 3},
                    },
                },
            },
        },
        harvest_group_table = {flammable = 2, food_tomato = 1, seed = 2},
    })
    if unilib.dye_from_produce_flag and unilib.pkg_executed_table["dye_basic"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            output = "unilib:dye_red",
            recipe = {
                {"unilib:produce_tomato_salad_harvest"},
            },
        })

    end

    unilib.register_juice({
        ingredient = "unilib:produce_tomato_salad_harvest",
        juice_description = S("Tomato"),
        juice_type = "tomato",
        rgb = "#990000",
        orig_flag = true,
    })

    unilib.register_decoration("farming_redo_produce_tomato_salad", {
        -- From farming_redo/mapgen.lua
        -- N.B. The original code does not use the final growth stage for the decoration
        deco_type = "simple",
        decoration = "unilib:produce_tomato_salad_grow_7",

        noise_params = {
            octaves = 3,
            offset = 0,
            persist = 0.6,
            scale = 0.001,
            seed = 329,
            spread = {x = 100, y = 100, z = 100},
        },
        sidelen = 16,
    })

end
