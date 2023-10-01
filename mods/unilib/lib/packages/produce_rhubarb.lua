---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.produce_rhubarb = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.produce_rhubarb.init()

    return {
        description = "Rhubarb",
        notes = "Rhubarb requires shady conditions to grow",
        optional = "dye_basic",
    }

end

function unilib.pkg.produce_rhubarb.exec()

    local orig_name_list = {}
    for i = 1, 3 do
        table.insert(orig_name_list, "farming:rhubarb_" .. i)
    end

    unilib.register_produce_fredo({
        -- From farming:rhubarb (creates unilib:produce_rhubarb_harvest), farming:rhubarb_1 etc
        --      (creates unilib:produce_rhubarb_grow_1 etc)
        part_name = "rhubarb",
        grow_orig_name = orig_name_list,
        harvest_orig_name = "farming:rhubarb",
        description = S("Rhubarb"),

        replace_mode = mode,
        eat = 1,
        grow_list = {
            {},
            {},
            {
                drop = {
                    items = {
                        {items = {"unilib:produce_rhubarb_harvest 2"}, rarity = 1},
                        {items = {"unilib:produce_rhubarb_harvest"}, rarity = 2},
                        {items = {"unilib:produce_rhubarb_harvest"}, rarity = 3},
                    },
                },
            },
        },
        harvest_group_table = {flammable = 2, food_rhubarb = 1, seed = 2},
        max_light = 12,
        min_light = 10,
    })
    if unilib.dye_from_produce_flag and unilib.pkg_executed_table["dye_basic"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            output = "unilib:dye_magenta",
            recipe = {
                {"unilib:produce_rhubarb_harvest"},
            },
        })

    end

    unilib.register_juice({
        ingredient = "unilib:produce_rhubarb_harvest",
        juice_description = S("Rhubarb"),
        juice_type = "rhubarb",
        rgb = "#fb8461",
        orig_flag = true,
    })

    unilib.register_decoration("farming_redo_produce_rhubarb", {
        -- From farming_redo/mapgen.lua
        deco_type = "simple",
        decoration = "unilib:produce_rhubarb_grow_3",

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
