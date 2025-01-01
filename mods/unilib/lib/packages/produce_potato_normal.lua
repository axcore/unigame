---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.produce_potato_normal = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.produce_potato_normal.init()

    return {
        description = "Normal potato",
        optional = "dye_basic",
    }

end

function unilib.pkg.produce_potato_normal.exec()

    local orig_name_list = {}
    for i = 1, 4 do
        table.insert(orig_name_list, "farming:potato_" .. i)
    end

    unilib.register_produce_fredo({
        -- From farming:potato (creates unilib:produce_potato_normal_harvest), farming:potato_1 etc
        --      (creates unilib:produce_potato_normal_grow_1 etc)
        part_name = "potato_normal",
        grow_orig_name = orig_name_list,
        harvest_orig_name = "farming:potato",
        description = S("Normal Potato"),

        replace_mode = mode,
        grow_list = {
            {},
            {},
            {
                drop = {
                    items = {
                        {items = {"unilib:produce_potato_normal_harvest"}, rarity = 1},
                        {items = {"unilib:produce_potato_normal_harvest"}, rarity = 3},
                    },
                },
            },
            {
                drop = {
                    items = {
                        {items = {"unilib:produce_potato_normal_harvest 2"}, rarity = 1},
                        {items = {"unilib:produce_potato_normal_harvest 3"}, rarity = 2},
                    },
                },
            },
        },
        harvest_group_table = {flammable = 2, food_potato = 1, seed = 2},
        waving = 1,
    })
    unilib.override_item("unilib:produce_potato_normal_harvest", {
        on_use = function(itemstack, user, pointed_thing)

            -- 1 in 3 chance of being poisoned
            -- N.B. No call to unilib.cuisine.eat_on_use(); checking food history doesn't matter
            --      when a food can be both nutritious and poisonous
            if user then

                if math.random(3) == 1 then
                    return core.do_item_eat(-1, nil, itemstack, user, pointed_thing)
                else
                    return core.do_item_eat(1, nil, itemstack, user, pointed_thing)
                end

            end

        end,
    })
    if unilib.setting.dye_from_produce_flag and
            unilib.global.pkg_executed_table["dye_basic"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            output = "unilib:dye_brown",
            recipe = {
                {"unilib:produce_potato_normal_harvest"},
            },
        })

    end

    unilib.register_juice({
        ingredient = "unilib:produce_potato_normal_harvest",
        juice_description = S("Potato"),
        juice_type = "potato",
        rgb = "#d19d0b",

        orig_flag = false,
    })

    unilib.register_decoration_generic("farming_redo_produce_potato_normal", {
        -- From farming_redo/mapgen.lua
        -- N.B. The original code does not use the final growth stage for the decoration
        deco_type = "simple",
        decoration = "unilib:produce_potato_normal_grow_3",

        noise_params = {
            octaves = 3,
            offset = 0,
            persist = 0.6,
            scale = 0.002,
            seed = 465,
            spread = {x = 100, y = 100, z = 100},
        },
        sidelen = 16,
    })

end
