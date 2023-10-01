---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.produce_pineapple = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.produce_pineapple.init()

    return {
        description = "Pineapple",
        notes = "In order to grow pineapples, use a pineapple to craft a pineapple top, then" ..
                " plant the top",
        optional = "dye_basic",
    }

end

function unilib.pkg.produce_pineapple.exec()

    -- (The harvested pineapple has non-standard properties, so it is defined separately)
    unilib.register_node("unilib:produce_pineapple_harvest", "farming:pineapple", mode, {
        -- From farming:pineapple
        description = S("Pineapple"),
        tiles = {"unilib_produce_pineapple_harvest.png"},
        -- N.B. flora = 1 not in original code
        groups = {dig_immediate = 3, flammable = 2, fleshy = 3, flora = 1, food_pineapple = 1},
        -- (no sounds)

        drawtype = "plantlike",
        inventory_image = "unilib_produce_pineapple_harvest.png",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.27, -0.37, -0.27, 0.27, 0.44, 0.27},
        },
        sunlight_propagates = true,
        walkable = false,
        wield_image = "unilib_produce_pineapple_harvest.png",
    })
    if unilib.dye_from_produce_flag and unilib.pkg_executed_table["dye_basic"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            output = "unilib:dye_yellow",
            recipe = {
                {"unilib:produce_pineapple_harvest"},
            },
        })

    end

    -- (Pineapple top is used as the seed)
    unilib.register_craftitem("unilib:produce_pineapple_top", "farming:pineapple_top", mode, {
        -- From farming:pineapple_top
        description = S("Pineapple Top"),
        inventory_image = "unilib_produce_pineapple_top.png",
        groups = {flammable = 2, seed = 2},
        -- (on_place is added in the call to unilib.register_produce_fredo() )
    })

    -- (Crafting the pineapple top also produces pineapple rings; they are defined here, rather
    --      than in a separate package, for clarity)
    unilib.register_craftitem("unilib:food_ring_pineapple", "farming:pineapple_ring", mode, {
        -- From farming:pineapple_ring
        description = S("Pineapple Ring"),
        inventory_image = "unilib_food_ring_pineapple.png",
        groups = {flammable = 2, food_pineapple_ring = 1},

        on_use = unilib.cuisine_eat_on_use("unilib:food_ring_pineapple", 1),
    })
    unilib.register_craft( {
        -- From farming:pineapple_ring
        output = "unilib:food_ring_pineapple 5",
        recipe = {
            {"group:food_pineapple"},
        },
        replacements = {
            {"unilib:produce_pineapple_harvest", "unilib:produce_pineapple_top"},
        }
    })

    local orig_name_list = {}
    for i = 1, 8 do
        table.insert(orig_name_list, "farming:pineapple_" .. i)
    end

    unilib.register_produce_fredo({
        -- From farming:pineapple_1 etc (creates unilib:produce_pineapple_grow_1 etc)
        part_name = "pineapple",
        grow_orig_name = orig_name_list,
        harvest_orig_name = "farming:pineapple",
        description = S("Pineapple"),

        replace_mode = mode,
        -- (harvested item not edible)
        grow_group_table = {
            attached_node = 1, flammable = 2, growing = 1, not_in_creative_inventory = 1,
            plant = 1, snappy = 3,
        },
        grow_list = {
            {visual_scale = 1.50},
            {visual_scale = 1.50},
            {visual_scale = 1.50},
            {visual_scale = 1.50},
            {visual_scale = 1.50},
            {visual_scale = 1.50},
            {visual_scale = 1.50},
            {
                drop = {
                    items = {
                        {items = {"unilib:produce_pineapple_harvest"}, rarity = 1},
                        {items = {"unilib:produce_pineapple_harvest"}, rarity = 10}
                    }
                },
                visual_scale = 1.50,
            },
        },
        -- (unilib:produce_pineapple_harvest is defined above, instead of being created by the
        --      function)
        no_harvest_flag = true,
        seed_name = "unilib:produce_pineapple_top",
    })

    unilib.register_juice({
        ingredient = "unilib:produce_pineapple_harvest",
        juice_description = S("Pineapple"),
        juice_type = "pineapple",
        rgb = "#dcd611",
        orig_flag = true,
    })
    unilib.register_juice_duplicate("pineapple", "unilib:food_ring_pineapple")

    unilib.register_decoration("farming_redo_produce_pineapple", {
        -- From farming_redo/mapgen.lua
        deco_type = "simple",
        decoration = "unilib:produce_pineapple_grow_8",

        noise_params = {
            octaves = 3,
            offset = 0,
            persist = 0.6,
            scale = 0.001,
            seed = 917,
            spread = {x = 100, y = 100, z = 100},
        },
        sidelen = 16,
    })

end
