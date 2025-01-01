---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aqua_farming
-- Code:    GPL 3.0
-- Media:   CC-BY-3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.crop_undersea_strawberry = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.aqua_farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.crop_undersea_strawberry.init()

    return {
        description = "Sea strawberry (undersea crop)",
        depends = {"dirt_ordinary", "shared_aqua_farming"},
        optional = "dye_basic",
    }

end

function unilib.pkg.crop_undersea_strawberry.exec()

    unilib.register_craftitem(
        -- From aqua_farming:sea_strawberry_item
        "unilib:crop_undersea_strawberry_harvest",
        "aqua_farming:sea_strawberry_item",
        mode,
        {
            description = S("Raw Sea Strawberry"),
            inventory_image = "unilib_crop_undersea_strawberry_harvest.png",
            groups = {food = 1, food_strawberry = 1, food_vegan = 1, seafood = 1},

            on_use = unilib.cuisine.eat_on_use("unilib:crop_undersea_strawberry_harvest", 3),
        }
    )

    local orig_name_list = {}
    for i = 1, 8 do
        table.insert(orig_name_list, "aqua_farming:sea_strawberry_" .. i)
    end

    unilib.pkg.shared_aqua_farming.register_crop({
        -- From aqua_farming:sea_strawberry_item (creates unilib:crop_undersea_strawberry_harvest),
        --      aqua_farming:sea_strawberry_seed (creates unilib:crop_undersea_strawberry_seed),
        --      aqua_farming:sea_strawberry_1 etc (creates unilib:crop_undersea_strawberry_grow_1
        --      etc), aqua_farming:sea_strawberry_wild (creates
        --      unilib:crop_undersea_strawberry_wild)
        part_name = "strawberry",
        grow_orig_name = orig_name_list,
        harvest_orig_name = "aqua_farming:sea_strawberry_item",
        seed_orig_name = "aqua_farming:sea_strawberry_seed",
        wild_orig_name = "aqua_farming:sea_strawberry_wild",
        steps = 8,

        replace_mode = mode,
        base_node = "unilib:dirt_ordinary",
        -- N.B. 15 in original code
        chance = 12,
        drop_table = {
            items = {
                {items = {"unilib:crop_undersea_strawberry_seed 2"}},
                {items = {"unilib:crop_undersea_strawberry_harvest 4"}},
                {items = {"unilib:crop_undersea_strawberry_seed 3"}, rarity = 15},
            },
        },
        -- N.B. 10 in original code
        interval = 15,
        min_light = 8,
        seed_description = S("Sea Strawberry Seed"),
        wild_description = S("Wild Sea Strawberry"),
    })
    if unilib.setting.dye_from_crops_flag and
            unilib.global.pkg_executed_table["dye_basic"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            -- N.B. For undersea crops, output is only 1 instead of the usual 2
            output = "unilib:dye_red",
            recipe = {
                {"unilib:crop_undersea_strawberry_harvest"},
            },
        })

    end

    unilib.register_juice({
        ingredient = "unilib:crop_undersea_strawberry_harvest",
        juice_description = S("Strawberry"),
        juice_type = "strawberry",
        rgb = "#ff3636",

        orig_flag = false,
    })

    for i = 1, 3 do

        unilib.register_decoration_generic("aqua_farming_crop_sea_strawberry_" .. i, {
            -- From aqua_farming/mapgen_sea_strawberry.lua
            deco_type = "simple",
            decoration = "unilib:crop_undersea_strawberry_wild",

            flags = "force_placement",
            noise_params = {
                octaves = 3,
                offset = -4,
                persist = 0.7,
                scale = 4,
                seed = 7013,
                spread = {x = 50, y = 50, z = 50},
            },
            -- N.B. No .param2/.param2_max in original code
            param2 = 0,
            param2_max = 3,
            place_offset_y = -1,
            sidelen = 4,
        })

    end

end
