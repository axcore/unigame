---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aqua_farming
-- Code:    GPL 3.0
-- Media:   CC-BY-3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.crop_undersea_cucumber = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aqua_farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.crop_undersea_cucumber.init()

    return {
        description = "Sea cucumber (undersea crop)",
        depends = {"sand_ordinary", "shared_aqua_farming"},
        optional = "dye_basic",
    }

end

function unilib.pkg.crop_undersea_cucumber.exec()

    unilib.register_craftitem(
        -- From aqua_farming:sea_cucumber_item
        "unilib:crop_undersea_cucumber_harvest",
        "aqua_farming:sea_cucumber_item",
        mode,
        {
            description = S("Raw Sea Cucumber"),
            inventory_image = "unilib_crop_undersea_cucumber_harvest.png",
            groups = {food = 1, food_cucumber = 1, food_vegan = 1, seafood = 1},

            on_use = unilib.cuisine_eat_on_use("unilib:crop_undersea_cucumber_harvest", 4),
        }
    )

    local orig_name_list = {}
    for i = 1, 8 do
        table.insert(orig_name_list, "aqua_farming:sea_cucumber_" .. i)
    end

    unilib.pkg.shared_aqua_farming.register_crop({
        -- From aqua_farming:sea_cucumber_item (creates unilib:crop_undersea_cucumber_harvest),
        --      aqua_farming:sea_cucumber_seed (creates unilib:crop_undersea_cucumber_seed),
        --      aqua_farming:sea_cucumber_1 etc (creates unilib:crop_undersea_cucumber_grow_1 etc),
        --      aqua_farming:sea_cucumber_wild (creates unilib:crop_undersea_cucumber_wild)
        part_name = "cucumber",
        grow_orig_name = orig_name_list,
        harvest_orig_name = "aqua_farming:sea_cucumber_item",
        seed_orig_name = "aqua_farming:sea_cucumber_seed",
        wild_orig_name = "aqua_farming:sea_cucumber_wild",
        steps = 8,

        replace_mode = mode,
        base_node = "unilib:sand_ordinary",
        chance = 10,
        delay = 9,
        drop_table = {
            items = {
                {items = {"unilib:crop_undersea_cucumber_seed 2"}},
                {items = {"unilib:crop_undersea_cucumber_harvest 4"}},
                {items = {"unilib:crop_undersea_cucumber_seed 3"}, rarity = 15},
            },
        },
        min_light = 6,
        seed_description = S("Sea Cucumber Seed"),
        wild_description = S("Wild Sea Cucumber"),
    })
    if unilib.dye_from_crops_flag and unilib.pkg_executed_table["dye_basic"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            -- N.B. For undersea crops, output is only 1 instead of the usual 2
            output = "unilib:dye_green",
            recipe = {
                {"unilib:crop_undersea_cucumber_harvest"},
            },
        })

    end

    for i = 1, 3 do

        unilib.register_decoration("aqua_farming_crop_sea_cucumber_" .. i, {
            -- From aqua_farming/mapgen_sea_cucumber.lua
            deco_type = "simple",
            decoration = "unilib:crop_undersea_cucumber_wild",

            flags = "force_placement",
            noise_params = {
                octaves = 3,
                offset = -0.04,
                persist = 0.5,
                scale = 0.3,
                seed = 87112,
                spread = {x = 70, y = 70, z = 70},
            },
            param2 = 48,
            param2_max = 96,
            place_offset_y = -1,
            sidelen = 16,
        })

    end

end
