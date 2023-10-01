---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.produce_raspberry = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.produce_raspberry.init()

    return {
        description = "Wild raspberries",
        optional = "dye_basic",
    }

end

function unilib.pkg.produce_raspberry.exec()

    local orig_name_list = {}
    for i = 1, 4 do
        table.insert(orig_name_list, "farming:raspberry_" .. i)
    end

    unilib.register_produce_fredo({
        -- From farming:raspberry (creates unilib:produce_raspberry_harvest), farming:raspberry_1
        --      etc (creates unilib:produce_raspberry_grow_1 etc)
        part_name = "raspberry",
        grow_orig_name = orig_name_list,
        harvest_orig_name = "farming:raspberry",
        description = S("Wild Raspberries"),

        replace_mode = mode,
        eat = 1,
        grow_list = {
            {},
            {},
            {},
            {
                drop = {
                    items = {
                        {items = {"unilib:produce_raspberry_harvest 2"}, rarity = 1},
                        {items = {"unilib:produce_raspberry_harvest"}, rarity = 2},
                        {items = {"unilib:produce_raspberry_harvest"}, rarity = 3},
                    }
                },
            },
        },
        harvest_group_table = {
            flammable = 2, food_berry = 1, food_raspberries = 1, food_raspberry = 1, seed = 2,
        },
    })
    if unilib.dye_from_produce_flag and unilib.pkg_executed_table["dye_basic"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            output = "unilib:dye_red",
            recipe = {
                {"unilib:produce_raspberry_harvest"},
            },
        })

    end

    unilib.register_juice({
        ingredient = "unilib:produce_raspberry_harvest",
        juice_description = S("Raspberry"),
        -- N.B. Original "drinks" mod used the juice type "raspberries"
        juice_type = "raspberry",
        rgb = "#c70039",
        orig_flag = false,
    })

    unilib.register_decoration("farming_redo_produce_raspberry", {
        -- From farming_redo/mapgen.lua
        deco_type = "simple",
        decoration = "unilib:produce_raspberry_grow_4",

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
