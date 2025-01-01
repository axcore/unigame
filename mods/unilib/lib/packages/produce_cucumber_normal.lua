---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.produce_cucumber_normal = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.produce_cucumber_normal.init()

    return {
        description = "Normal cucumber",
        optional = "dye_basic",
    }

end

function unilib.pkg.produce_cucumber_normal.exec()

    local orig_name_list = {}
    for i = 1, 4 do
        table.insert(orig_name_list, "farming:cucumber_" .. i)
    end

    unilib.register_produce_fredo({
        -- From farming:cucumber (creates unilib:produce_cucumber_normal_harvest),
        --      farming:cucumber_1 etc (creates unilib:produce_cucumber_normal_grow_1 etc)
        part_name = "cucumber_normal",
        grow_orig_name = orig_name_list,
        harvest_orig_name = "farming:cucumber",
        description = S("Normal Cucumber"),

        replace_mode = mode,
        eat = 4,
        grow_list = {
            {sunlight_propogates = false},
            {sunlight_propogates = false},
            {sunlight_propogates = false},
            {
                drop = {
                    items = {
                        {items = {"unilib:produce_cucumber_normal_harvest 2"}, rarity = 1},
                        {items = {"unilib:produce_cucumber_normal_harvest 2"}, rarity = 2}
                    },
                },
                sunlight_propogates = false,
            },
        },
        harvest_group_table = {flammable = 2, food_cucumber = 1, seed = 2},
    })
    if unilib.setting.dye_from_produce_flag and
            unilib.global.pkg_executed_table["dye_basic"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            output = "unilib:dye_green",
            recipe = {
                {"unilib:produce_cucumber_normal_harvest"},
            },
        })

    end

    unilib.register_juice({
        ingredient = "unilib:produce_cucumber_normal_harvest",
        juice_description = S("Cucumber"),
        juice_type = "cucumber",
        rgb = "#73af59",

        orig_flag = true,
    })

    unilib.register_decoration_generic("farming_redo_produce_cucumber_normal", {
        -- From farming_redo/mapgen.lua
        deco_type = "simple",
        decoration = "unilib:produce_cucumber_normal_grow_4",

        noise_params = {
            octaves = 3,
            offset = 0,
            persist = 0.6,
            scale = 0.002,
            seed = 245,
            spread = {x = 100, y = 100, z = 100},
        },
        sidelen = 16,
    })

end
