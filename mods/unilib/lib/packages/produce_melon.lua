---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.produce_melon = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.produce_melon.init()

    return {
        description = "Melon",
        notes = "In order to grow melons, use a cutting board to slice the melon, then plant" ..
                " the slices",
        -- Required to make lemon slices
        depends = "utensil_board_cutting",
        optional = "dye_basic",
    }

end

function unilib.pkg.produce_melon.exec()

    -- (The slice is used as the seed)
    unilib.register_craftitem("unilib:produce_melon_slice", "farming:melon_slice", mode, {
        -- From farming:melon_slice
        description = S("Melon Slice"),
        inventory_image = "unilib_produce_melon_slice.png",
        groups = {flammable = 3, food_melon_slice = 1, seed = 2},

        -- (on_place is added in the call to unilib.register_produce_fredo() )
        on_use = unilib.cuisine.eat_on_use("unilib:produce_melon_slice", 2),
    })
    unilib.register_craft({
        -- From farming:melon_slice
        output = "unilib:produce_melon_harvest",
        recipe = {
            {"unilib:produce_melon_slice", "unilib:produce_melon_slice"},
            {"unilib:produce_melon_slice", "unilib:produce_melon_slice"},
        },
    })
    unilib.register_craft({
        -- From farming:melon_slice
        output = "unilib:produce_melon_slice 4",
        recipe = {
            {"unilib:utensil_board_cutting", "unilib:produce_melon_harvest"},
        },
        replacements = {
            {"unilib:utensil_board_cutting", "unilib:utensil_board_cutting"},
        },
    })
    if unilib.setting.dye_from_produce_flag and
            unilib.global.pkg_executed_table["dye_basic"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            output = "unilib:dye_red",
            recipe = {
                {"unilib:produce_melon_slice"},
            },
        })

    end

    local orig_name_list = {}
    for i = 1, 8 do
        table.insert(orig_name_list, "farming:melon_" .. i)
    end

    unilib.register_produce_fredo({
        -- From farming:melon (creates creates unilib:produce_melon_grow_8, aliased on to
        --      unilib:produce_melon_harvest), farming:melon_1 etc (creates
        --      unilib:produce_melon_grow_1 etc)
        part_name = "melon",
        grow_orig_name = orig_name_list,
        harvest_orig_name = "farming:melon",
        description = S("Melon"),

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
                description = S("Melon"),
                tiles = {
                    "unilib_produce_melon_grow_top.png",
                    "unilib_produce_melon_grow_bottom.png",
                    "unilib_produce_melon_grow_side.png"
                },
                groups = {
                    flammable = 2, food_melon = 1, oddly_breakable_by_hand = 1, plant = 1,
                    snappy = 2,
                },
                sounds = unilib.global.sound_table.wood,

                drop = "unilib:produce_melon_harvest",
                paramtype2 = "facedir",

                on_place = core.rotate_node,
            },
        },
        no_harvest_flag = true,
        seed_name = "unilib:produce_melon_slice",
    })

    unilib.register_juice({
        ingredient = "unilib:produce_melon_harvest",
        juice_description = S("Melon"),
        juice_type = "melon",
        rgb = "#ef4646",

        orig_flag = true,
    })
    unilib.juice.register_duplicate("melon", "unilib:produce_melon_slice")

    unilib.register_decoration_generic("farming_redo_produce_melon", {
        -- From farming_redo/mapgen.lua
        deco_type = "simple",
        decoration = "unilib:produce_melon_grow_8",

        noise_params = {
            octaves = 3,
            offset = 0,
            persist = 0.6,
            scale = 0.009,
            seed = 790,
            spread = {x = 100, y = 100, z = 100},
        },
        sidelen = 16,
    })

end
