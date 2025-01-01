---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.produce_blackberry = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.produce_blackberry.init()

    return {
        description = "Wild blackberries",
        optional = "dye_basic",
    }

end

function unilib.pkg.produce_blackberry.exec()

    local orig_name_list = {}
    for i = 1, 4 do
        table.insert(orig_name_list, "farming:blackberry_" .. i)
    end

    unilib.register_produce_fredo({
        -- From farming:blackberry (creates unilib:produce_blackberry_harvest), farming:blackberry_1
        --      etc (creates unilib:produce_blackberry_grow_1 etc)
        part_name = "blackberry",
        grow_orig_name = orig_name_list,
        harvest_orig_name = "farming:blackberry",
        description = S("Wild Blackberries"),

        replace_mode = mode,
        eat = 1,
        grow_list = {
            {},
            {},
            {},
            {
                drop = {
                    items = {
                        {items = {"unilib:produce_blackberry_harvest 2"}, rarity = 1},
                        {items = {"unilib:produce_blackberry_harvest"}, rarity = 2},
                        {items = {"unilib:produce_blackberry_harvest"}, rarity = 3},
                    },
                },
            },
        },
        harvest_group_table = {
            flammable = 2, food_berry = 1, food_blackberries = 1, food_blackberry = 1, seed = 2,
        },
    })
    if unilib.setting.dye_from_produce_flag and
            unilib.global.pkg_executed_table["dye_basic"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            output = "unilib:dye_black",
            recipe = {
                {"unilib:produce_blackberry_harvest"},
            },
        })

    end

    unilib.register_juice({
        ingredient = "unilib:produce_blackberry_harvest",
        juice_description = S("Blackberry"),
        juice_type = "blackberry",
        rgb = "#581845",

        orig_flag = false,
    })

    unilib.register_decoration_generic("farming_redo_produce_blackberry", {
        -- From farming_redo/mapgen.lua
        deco_type = "simple",
        decoration = "unilib:produce_blackberry_grow_4",

        noise_params = {
            octaves = 3,
            offset = 0,
            persist = 0.6,
            scale = 0.002,
            seed = 567,
            spread = {x = 100, y = 100, z = 100},
        },
        sidelen = 16,
    })

end
