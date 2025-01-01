---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.produce_strawberry_normal = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.produce_strawberry_normal.init()

    return {
        description = "Normal strawberry",
        optional = "dye_basic",
    }

end

function unilib.pkg.produce_strawberry_normal.exec()

    local orig_name_list = {}
    for i = 1, 8 do
        table.insert(orig_name_list, "ethereal_strawberry_" .. i)
    end

    unilib.register_produce_fredo({
        -- From ethereal:strawberry (creates unilib:produce_strawberry_normal_harvest),
        --      ethereal_strawberry_1 etc (creates unilib:produce_strawberry_normal_grow_1 etc)
        part_name = "strawberry_normal",
        grow_orig_name = orig_name_list,
        harvest_orig_name = "ethereal:strawberry",
        description = S("Normal Strawberry"),

        replace_mode = mode,
        eat = 1,
        grow_list = {
            {},
            {},
            {},
            {},
            {},
            {
                drop = {
                    items = {
                        {items = {"unilib:produce_strawberry_normal_harvest"}, rarity = 2},
                        {items = {"unilib:produce_strawberry_normal_harvest 2"}, rarity = 3},
                    },
                },
            },
            {
                drop = {
                    items = {
                        {items = {"unilib:produce_strawberry_normal_harvest"}, rarity = 1},
                        -- N.B. Confirmed with original mod author, dropping 1 is not a typo
                        {items = {"unilib:produce_strawberry_normal_harvest"}, rarity = 3},
                    },
                },
            },
            {
                drop = {
                    items = {
                        {items = {"unilib:produce_strawberry_normal_harvest 2"}, rarity = 1},
                        {items = {"unilib:produce_strawberry_normal_harvest 3"}, rarity = 3},
                    },
                },
            },
        },
        -- N.B. seed = 2 not in original code
        harvest_group_table = {flammable = 2, food_berry = 1, food_strawberry = 1, seed = 2},
        min_light = 13,
        waving = 1,
    })
    if unilib.setting.dye_from_produce_flag and
            unilib.global.pkg_executed_table["dye_basic"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            output = "unilib:dye_red",
            recipe = {
                {"unilib:produce_strawberry_normal_harvest"},
            },
        })

    end

    unilib.register_juice({
        ingredient = "unilib:produce_strawberry_normal_harvest",
        juice_description = S("Strawberry"),
        juice_type = "strawberry",
        rgb = "#ff3636",

        orig_flag = true,
    })

    unilib.register_decoration_generic("ethereal_produce_strawberry_normal", {
        -- From ethereal-ng/decor.lua
        deco_type = "simple",
        decoration = "unilib:produce_strawberry_normal_grow_7",

        noise_params = {
            octaves = 3,
            offset = 0,
            persist = 0.6,
            scale = 0.002,
            seed = 143,
            spread = {x = 100, y = 100, z = 100},
        },
        sidelen = 16,
    })

end
