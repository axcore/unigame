---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.produce_blueberry_highbush = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.produce_blueberry_highbush.init()

    return {
        description = "Highbush blueberries",
        optional = "dye_basic",
    }

end

function unilib.pkg.produce_blueberry_highbush.exec()

    local orig_name_list = {}
    for i = 1, 4 do
        table.insert(orig_name_list, "farming:blueberry_" .. i)
    end

    unilib.register_produce_fredo({
        -- From farming:blueberry (creates unilib:produce_blueberry_highbush_harvest),
        --      farming:blueberry_1 etc (creates unilib:produce_blueberry_highbush_grow_1 etc)
        part_name = "blueberry_highbush",
        grow_orig_name = orig_name_list,
        harvest_orig_name = "farming:blueberry",
        description = S("Highbush Blueberries"),

        replace_mode = mode,
        eat = 1,
        grow_list = {
            {},
            {},
            {},
            {
                drop = {
                    items = {
                        {items = {"unilib:produce_blueberry_highbush_harvest 2"}, rarity = 1},
                        {items = {"unilib:produce_blueberry_highbush_harvest"}, rarity = 2},
                        {items = {"unilib:produce_blueberry_highbush_harvest"}, rarity = 3},
                    },
                },
            },
        },
        harvest_group_table = {
            flammable = 2, food_berry = 1, food_blueberries = 1, food_blueberry = 1, seed = 2,
        },
    })
    if unilib.setting.dye_from_produce_flag and
            unilib.global.pkg_executed_table["dye_basic"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            output = "unilib:dye_blue",
            recipe = {
                {"unilib:produce_blueberry_highbush_harvest"},
            },
        })

    end

    unilib.register_juice({
        ingredient = "unilib:produce_blueberry_highbush_harvest",
        juice_description = S("Blueberry"),
        -- N.B. Original "drinks" mod used the juice type "blueberries"
        juice_type = "blueberry",
        rgb = "#521dcb",

        orig_flag = false,
    })

    unilib.register_decoration_generic("farming_redo_produce_blueberry_highbush", {
        -- From farming_redo/mapgen.lua
        deco_type = "simple",
        decoration = "unilib:produce_blueberry_highbush_grow_4",

        noise_params = {
            octaves = 3,
            offset = 0,
            persist = 0.6,
            scale = 0.002,
            seed = 678,
            spread = {x = 100, y = 100, z = 100},
        },
        sidelen = 16,
    })

end
