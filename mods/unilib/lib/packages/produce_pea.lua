---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.produce_pea = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.produce_pea.init()

    return {
        description = "Pea pod",
        notes = "In order to grow peas, plant the pea pod, not individual peas",
        optional = "dye_basic",
    }

end

function unilib.pkg.produce_pea.exec()

    local orig_name_list = {}
    for i = 1, 5 do
        table.insert(orig_name_list, "farming:pea_" .. i)
    end

    unilib.register_produce_fredo({
        -- From farming:pea (creates unilib:produce_pea_harvest), farming:pea_1 etc (creates
        --      unilib:produce_pea_grow_1 etc)
        part_name = "pea",
        grow_orig_name = orig_name_list,
        harvest_orig_name = "farming:pea",
        description = S("Pea Pod"),

        replace_mode = mode,
        -- (not edible)
        grow_list = {
            {},
            {},
            {},
            {},
            {
                drop = {
                    max_items = 5,
                    items = {
                        {items = {"unilib:produce_pea_harvest"}, rarity = 1},
                        {items = {"unilib:produce_pea_harvest"}, rarity = 2},
                        {items = {"unilib:produce_pea_harvest"}, rarity = 3},
                        {items = {"unilib:produce_pea_harvest"}, rarity = 5},
                    }
                },
            },
        },
        harvest_group_table = {flammable = 2, food_pea_pod = 1, seed = 2},
        paramtype2 = "meshoptions",
        place_param2 = 3,
        waving = 1,
    })
    if unilib.dye_from_produce_flag and unilib.pkg_executed_table["dye_basic"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            output = "unilib:dye_green",
            recipe = {
                {"unilib:produce_pea_harvest"},
            },
        })

    end

    unilib.register_decoration("farming_redo_produce_pea", {
        -- From farming_redo/mapgen.lua
        deco_type = "simple",
        decoration = "unilib:produce_pea_grow_5",

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
