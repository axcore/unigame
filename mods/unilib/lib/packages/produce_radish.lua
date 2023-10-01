---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.produce_radish = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.produce_radish.init()

    return {
        description = "Radish",
        optional = "dye_basic",
    }

end

function unilib.pkg.produce_radish.exec()

    --[[
    local orig_name_list = {}
    for i = 1, 5 do
        table.insert(orig_name_list, "farming:raddish_" .. i)
    end
    ]]--

    unilib.register_produce_fredo({
        -- Original to unilib, using textures from farlands/farming/raddish.lua. Creates
        --      unilib:produce_radish_harvest and unilib:produce_raddish_grow_1 etc
        part_name = "radish",
        grow_orig_name = {},
        harvest_orig_name = nil,
        description = S("Radish"),

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
                        {items = {"unilib:produce_radish_harvest 2"}, rarity = 1},
                        {items = {"unilib:produce_radish_harvest"}, rarity = 2},
                    }
                },
            },
        },
        harvest_group_table = {flammable = 2, food_radish = 1, seed = 2},
        min_light = 13,
    })
    if unilib.dye_from_produce_flag and unilib.pkg_executed_table["dye_basic"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            output = "unilib:dye_red",
            recipe = {
                {"unilib:produce_radish_harvest"},
            },
        })

    end

    unilib.register_decoration("farming_redo_produce_radish", {
        -- Original to unilib
        deco_type = "simple",
        decoration = "unilib:produce_radish_grow_5",

        noise_params = {
            octaves = 3,
            offset = 0,
            persist = 0.6,
            scale = 0.001,
            seed = 448,
            spread = {x = 100, y = 100, z = 100},
        },
        sidelen = 16,
    })

end
