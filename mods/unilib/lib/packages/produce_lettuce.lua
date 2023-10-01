---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.produce_lettuce = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.produce_lettuce.init()

    return {
        description = "Lettuce",
        optional = "dye_basic",
    }

end

function unilib.pkg.produce_lettuce.exec()

    local orig_name_list = {}
    for i = 1, 5 do
        table.insert(orig_name_list, "farming:lettuce_" .. i)
    end

    unilib.register_produce_fredo({
        -- From farming:lettuce (creates unilib:produce_lettuce_harvest), farming:lettuce_1 etc
        --      (creates unilib:produce_lettuce_grow_1 etc)
        part_name = "lettuce",
        grow_orig_name = orig_name_list,
        harvest_orig_name = "farming:lettuce",
        description = S("Lettuce"),

        replace_mode = mode,
        eat = 2,
        grow_list = {
            {},
            {},
            {},
            {},
            {
                drop = {
                    items = {
                        {items = {"unilib:produce_lettuce_harvest 2"}, rarity = 1},
                        {items = {"unilib:produce_lettuce_harvest 1"}, rarity = 2},
                    }
                },
            },
        },
        harvest_group_table = {flammable = 2, food_lettuce = 1, seed = 2},
    })
    if unilib.dye_from_produce_flag and unilib.pkg_executed_table["dye_basic"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            output = "unilib:dye_green",
            recipe = {
                {"unilib:produce_lettuce_harvest"},
            },
        })

    end

    unilib.register_decoration("farming_redo_produce_lettuce", {
        -- From farming_redo/mapgen.lua
        deco_type = "simple",
        decoration = "unilib:produce_lettuce_grow_5",

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
