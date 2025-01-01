---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.produce_pumpkin_yellow = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.produce_pumpkin_yellow.init()

    return {
        description = "Yellow Pumpkin",
        notes = "In order to grow yellow pumpkins, use a cutting board to slice the pumpkin. The" ..
                " slices can be planted",
        -- Required to make pumpkin slices
        depends = "utensil_board_cutting",
        optional = "dye_basic",
    }

end

function unilib.pkg.produce_pumpkin_yellow.exec()

    -- (The slice is used as the seed)
    unilib.register_craftitem(
        -- From farming:pumpkin_slice
        "unilib:produce_pumpkin_yellow_slice",
        "farming:pumpkin_slice",
        mode,
        {
            description = S("Yellow Pumpkin Slice"),
            inventory_image = "unilib_produce_pumpkin_yellow_slice.png",
            groups = {flammable = 2, food_pumpkin_slice = 1, seed = 2},

            -- (on_place is added in the call to unilib.register_produce_fredo() )
            on_use = unilib.cuisine.eat_on_use("unilib:produce_pumpkin_yellow_slice", 2),
        }
    )
    unilib.register_craft({
        -- From farming:pumpkin_slice
        output = "unilib:produce_pumpkin_yellow_harvest",
        recipe = {
            {"unilib:produce_pumpkin_yellow_slice", "unilib:produce_pumpkin_yellow_slice"},
            {"unilib:produce_pumpkin_yellow_slice", "unilib:produce_pumpkin_yellow_slice"},
        },
    })
    unilib.register_craft({
        -- From farming:pumpkin_slice
        output = "unilib:produce_pumpkin_yellow_slice 4",
        recipe = {
            {"unilib:utensil_board_cutting", "unilib:produce_pumpkin_yellow_harvest"},
        },
        replacements = {
            {"unilib:utensil_board_cutting", "unilib:utensil_board_cutting"},
        },
    })
    if unilib.setting.dye_from_produce_flag and
            unilib.global.pkg_executed_table["dye_basic"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            output = "unilib:dye_yellow",
            recipe = {
                {"unilib:produce_pumpkin_yellow_slice"},
            },
        })

    end

    local orig_name_list = {}
    for i = 1, 8 do
        table.insert(orig_name_list, "farming:pumpkin_" .. i)
    end

    unilib.register_produce_fredo({
        -- From farming:pumpkin (creates creates unilib:produce_pumpkin_yellow_grow_8, aliased on to
        --      unilib:produce_pumpkin_yellow_harvest), farming:pumpkin_1 etc (creates
        --      unilib:produce_pumpkin_yellow_grow_1 etc)
        part_name = "pumpkin_yellow",
        grow_orig_name = orig_name_list,
        harvest_orig_name = "farming:pumpkin",
        description = S("Yellow Pumpkin"),

        replace_mode = mode,
        grow_list = {
            {},
            {},
            {},
            {},
            {},
            {},
            {},
            {
                complete_flag = true,           -- This is the whole node definition
                description = S("Yellow Pumpkin"),
                tiles = {
                    "unilib_produce_pumpkin_yellow_grow_bottom.png" ..
                            "^unilib_produce_pumpkin_yellow_grow_top_overlay.png",
                    "unilib_produce_pumpkin_yellow_grow_bottom.png",
                    "unilib_produce_pumpkin_yellow_grow_side.png"
                },
                groups = {
                    choppy = 2, flammable = 2, food_pumpkin = 1, oddly_breakable_by_hand = 1,
                    plant = 1,
                },
                sounds = unilib.global.sound_table.wood,

                drop = "unilib:produce_pumpkin_yellow_grow_8",
                paramtype2 = "facedir",

                on_place = core.rotate_node,
            },
        },
        no_harvest_flag = true,
        seed_name = "unilib:produce_pumpkin_yellow_slice",
        waving = 1,
    })

    unilib.register_juice({
        ingredient = "unilib:produce_pumpkin_yellow_harvest",
        juice_description = S("Pumpkin"),
        juice_type = "pumpkin",
        rgb = "#ffc04c",

        orig_flag = true,
    })
    unilib.juice.register_duplicate("pumpkin", "unilib:produce_pumpkin_yellow_slice")

    unilib.register_decoration_generic("farming_redo_produce_pumpkin_yellow", {
        -- From farming_redo/mapgen.lua
        deco_type = "simple",
        decoration = "unilib:produce_pumpkin_yellow_grow_8",

        noise_params = {
            octaves = 3,
            offset = 0,
            persist = 0.6,
            scale = 0.009,
            seed = 576,
            spread = {x = 100, y = 100, z = 100},
        },
        sidelen = 16,
    })

end
