---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.produce_pepper = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.produce_pepper.init()

    return {
        description = "Pepper",
        notes = "In order to grow peppers, use them to craft peppercorn, then plant the peppercorn",
        depends = "food_pepper",
    }

end

function unilib.pkg.produce_pepper.exec()

    -- (Peppercorn is used as the seed)
    unilib.register_craftitem("unilib:produce_pepper_peppercorn", "farming:peppercorn", mode, {
        -- From farming:peppercorn
        description = S("Peppercorn"),
        inventory_image = "unilib_produce_pepper_peppercorn.png",
        groups = {flammable = 3, food_peppercorn = 1, seed = 1},
        -- (on_place is added in the call to unilib.register_produce_fredo() )
    })
    unilib.register_craft({
        -- From farming:peppercorn
        output = "unilib:produce_pepper_peppercorn",
        recipe = {
            {"group:food_pepper"},
        },
    })

    local orig_name_list = {}
    for i = 1, 7 do
        table.insert(orig_name_list, "farming:pepper_" .. i)
    end

    unilib.register_produce_fredo({
        -- From farming:pepper, farming:pepper_yellow and farming:pepper_red (creates
        --      unilib:food_pepper_green, unilib:food_pepper_yellow and unilib:food_pepper_red),
        --      farming:pepper_1 etc (creates unilib:produce_pepper_grow_1 etc)
        part_name = "pepper",
        grow_orig_name = orig_name_list,
        harvest_orig_name = "farming:pepper",
        description = S("Pepper"),

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
            -- Stage 5 (green pepper)
            {
                drop = {
                    max_items = 2,
                    items = {
                        {items = {"unilib:food_pepper_green 2"}, rarity = 1},
                        {items = {"unilib:food_pepper_green"}, rarity = 2},
                        {items = {"unilib:food_pepper_green"}, rarity = 3},
                    },
                },
            },
            -- Stage 6 (yellow pepper)
            {
                drop = {
                    max_items = 2,
                    items = {
                        {items = {"unilib:food_pepper_yellow 2"}, rarity = 1},
                        {items = {"unilib:food_pepper_yellow"}, rarity = 2},
                        {items = {"unilib:food_pepper_yellow"}, rarity = 3},
                    },
                },
            },
            -- Stage 7 (red pepper)
            {
                drop = {
                    max_items = 2,
                    items = {
                        {items = {"unilib:food_pepper_red 2"}, rarity = 1},
                        {items = {"unilib:food_pepper_red"}, rarity = 2},
                        {items = {"unilib:food_pepper_red"}, rarity = 3},
                    },
                },
            },
        },
        no_harvest_flag = true,
        paramtype2 = "meshoptions",
        place_param2 = 1,
        seed_name = "unilib:produce_pepper_peppercorn",
        waving = 1,
    })

    unilib.register_decoration("farming_redo_produce_pepper", {
        -- From farming_redo/mapgen.lua
        deco_type = "simple",
        decoration = {
            "unilib:produce_pepper_grow_5",
            "unilib:produce_pepper_grow_6",
            "unilib:produce_pepper_grow_7",
        },

        noise_params = {
            octaves = 3,
            offset = 0,
            persist = 0.6,
            scale = 0.002,
            seed = 933,
            spread = {x = 100, y = 100, z = 100},
        },
        sidelen = 16,
    })

end
