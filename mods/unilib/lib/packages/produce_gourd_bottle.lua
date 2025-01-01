---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    GLEMr11
-- Code:    LGPL 2.1
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.produce_gourd_bottle = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.glemr11.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.produce_gourd_bottle.init()

    return {
        description = "Bottle gourd",
        notes = "In the original code, this was a crop (with seeds). Converted to a produce" ..
                " item, because we can't add yet more types of seed to jungle grass",
        optional = "dye_basic",
    }

end

function unilib.pkg.produce_gourd_bottle.exec()

    local orig_name_list = {}
    for i = 1, 7 do
        table.insert(orig_name_list, "lib_ecology:plant_gourd_bottle_" .. i)
    end

    unilib.register_produce_fredo({
        -- Textures from GLEMr11, original code. From lib_ecology:fruit_gourd_bottle (creates
        --      unilib:produce_gourd_bottle_harvest), lib_ecology:plant_gourd_bottle_1 etc (creates
        --      unilib:produce_gourd_bottle_grow_1 etc)
        part_name = "gourd_bottle",
        grow_orig_name = orig_name_list,
        harvest_orig_name = "lib_ecology:fruit_gourd_bottle",
        description = S("Bottle Gourd"),

        replace_mode = mode,
        eat = 2,
        grow_list = {
            {},
            {},
            {},
            {},
            {},
            {},
            {
                drop = {
                    items = {
                        {items = {"unilib:produce_gourd_bottle_harvest 2"}, rarity = 1},
                        {items = {"unilib:produce_gourd_bottle_harvest"}, rarity = 2},
                    },
                },
            },
        },
        harvest_group_table = {flammable = 2, food_gourd = 1, seed = 2},
        min_light = 13,
    })
    if unilib.setting.dye_from_produce_flag and
            unilib.global.pkg_executed_table["dye_basic"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            output = "unilib:dye_white",
            recipe = {
                {"unilib:produce_gourd_bottle_harvest"},
            },
        })

    end

    unilib.register_juice({
        ingredient = "unilib:produce_gourd_bottle_harvest",
        juice_description = S("Bottle Gourd"),
        juice_type = "gourd_bottle",
        rgb = "#a9b17d",

        orig_flag = false,
    })

    unilib.register_decoration_generic("glem_produce_gourd_bottle", {
        -- Original to unilib
        deco_type = "simple",
        decoration = "unilib:produce_gourd_bottle_grow_7",

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
