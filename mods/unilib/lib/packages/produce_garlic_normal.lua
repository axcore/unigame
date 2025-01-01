---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.produce_garlic_normal = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.produce_garlic_normal.init()

    return {
        description = "Normal garlic",
        notes = "In order to grow normal garlic, craft a garlic clove from a garlic bulb, and" ..
                " plant the clove",
        optional = "dye_basic",
    }

end

function unilib.pkg.produce_garlic_normal.exec()

    local c_clove = "unilib:produce_garlic_normal_clove"

    -- (The harvested garlic bulb has non-standard properties, so is defined separately)
    unilib.register_craftitem("unilib:produce_garlic_normal_harvest", "farming:garlic", mode, {
        -- From farming:garlic
        description = S("Normal Garlic Bulb"),
        inventory_image = "unilib_produce_garlic_normal_harvest.png",
        groups = {flammable = 3, food_garlic = 1},

        on_use = unilib.cuisine.eat_on_use("unilib:produce_garlic_normal_harvest", 1),
    })
    unilib.register_craft({
        -- From farming:garlic
        output = "unilib:produce_garlic_normal_harvest",
        recipe = {
            {c_clove, c_clove, c_clove},
            {c_clove, "", c_clove},
            {c_clove, c_clove, c_clove},
        },
    })
    if unilib.setting.dye_from_produce_flag and
            unilib.global.pkg_executed_table["dye_basic"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            output = "unilib:dye_white",
            recipe = {
                {"unilib:produce_garlic_normal_harvest"},
            },
        })

    end

    -- (Normal garlic cloves are used as the seed)
    unilib.register_craftitem(c_clove, "farming:garlic_clove", mode, {
        -- From farming:garlic_clove
        description = S("Normal Garlic Clove"),
        inventory_image = "unilib_produce_garlic_normal_clove.png",
        groups = {flammable = 3, food_garlic_clove = 1, seed = 2},
        -- (on_place is added in the call to unilib.register_produce_fredo() )
    })
    unilib.register_craft({
        -- From farming:garlic_clove
        type = "shapeless",
        output = c_clove .. " 8",
        recipe = {"unilib:produce_garlic_normal_harvest"},
    })

    local orig_name_list = {}
    for i = 1, 5 do
        table.insert(orig_name_list, "farming:garlic_" .. i)
    end

    unilib.register_produce_fredo({
        -- From farming:garlic (creates unilib:produce_garlic_normal_harvest), farming:garlic_1 etc
        --      (creates unilib:produce_garlic_normal_grow_1 etc)
        part_name = "garlic_normal",
        grow_orig_name = orig_name_list,
        harvest_orig_name = "farming:garlic",
        description = S("Normal Garlic"),

        replace_mode = mode,
        grow_group_table = {
            attached_node = 1, flammable = 3, growing = 1, not_in_creative_inventory = 1,
            plant = 1, snappy = 3,
        },
        grow_list = {
            {},
            {},
            {},
            {},
            {
                drop = {
                    items = {
                        {items = {"unilib:produce_garlic_normal_harvest 3"}, rarity = 1},
                        {items = {"unilib:produce_garlic_normal_harvest"}, rarity = 2},
                        {items = {"unilib:produce_garlic_normal_harvest"}, rarity = 5},
                    },
                },
            },
        },
        -- (unilib:produce_pineapple_harvest is defined above, instead of being created by the
        --      function)
        no_harvest_flag = true,
        paramtype2 = "meshoptions",
        place_param2 = 3,
        seed_name = c_clove,
        waving = 1,
    })

    unilib.register_juice({
        ingredient = "unilib:produce_garlic_normal_harvest",
        juice_description = S("Garlic"),
        juice_type = "garlic",
        rgb = "#eab9a3",

        orig_flag = false,
    })
    unilib.juice.register_duplicate("garlic", c_clove)

    unilib.register_decoration_generic("farming_redo_produce_garlic_normal", {
        -- From farming_redo/mapgen.lua
        deco_type = "simple",
        decoration = "unilib:produce_garlic_normal_grow_5",

        noise_params = {
            octaves = 3,
            offset = 0,
            persist = 0.6,
            scale = 0.002,
            seed = 467,
            spread = {x = 100, y = 100, z = 100},
        },
        sidelen = 16,
    })

end
