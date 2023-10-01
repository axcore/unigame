---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aqua_farming
-- Code:    GPL 3.0
-- Media:   CC-BY-3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.crop_undersea_grass = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aqua_farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.crop_undersea_grass.init()

    return {
        description = "Edible sea grass (undersea crop)",
        depends = {"sand_ordinary", "shared_aqua_farming"},
        optional = "dye_basic",
    }

end

function unilib.pkg.crop_undersea_grass.exec()

    unilib.register_craftitem(
        -- From aqua_farming:sea_grass_item
        "unilib:crop_undersea_grass_harvest",
        "aqua_farming:sea_grass_item",
        mode,
        {
            description = S("Raw Edible Sea Grass"),
            inventory_image = "unilib_crop_undersea_grass_harvest.png",
            groups = {food = 1, food_vegan = 1, seafood = 1},
        }
    )

    local orig_name_list = {}
    for i = 1, 5 do
        table.insert(orig_name_list, "aqua_farming:sea_grass_" .. i)
    end

    unilib.pkg.shared_aqua_farming.register_crop({
        -- From aqua_farming:sea_grass_item (creates unilib:crop_undersea_grass_harvest),
        --      aqua_farming:sea_grass_seed (creates unilib:crop_undersea_grass_seed),
        --      aqua_farming:sea_grass_1 etc (creates unilib:crop_undersea_grass_grow_1 etc),
        --      aqua_farming:sea_grass_wild (creates unilib:crop_undersea_grass_wild)
        part_name = "grass",
        grow_orig_name = orig_name_list,
        harvest_orig_name = "aqua_farming:sea_grass_item",
        seed_orig_name = "aqua_farming:sea_grass_seed",
        wild_orig_name = "aqua_farming:sea_grass_wild",
        steps = 5,

        replace_mode = mode,
        base_node = "unilib:sand_ordinary",
        chance = 10,
        delay = 6,
        drop_table = {
            items = {
                {items = {"unilib:crop_undersea_grass_harvest"}},
                {items = {"unilib:crop_undersea_grass_seed 2"}},
                {items = {"unilib:crop_undersea_grass_seed 3"}, rarity = 10},
            },
        },
        min_light = 4,
        seed_description = S("Edible Sea Grass Seed"),
        wild_description = S("Wild Edible Sea Grass"),
    })
    if unilib.dye_from_crops_flag and unilib.pkg_executed_table["dye_basic"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            -- N.B. For undersea crops, output is only 1 instead of the usual 2
            output = "unilib:dye_green",
            recipe = {
                {"unilib:crop_undersea_grass_harvest"},
            },
        })

    end

    for i = 1, 4 do

        unilib.register_decoration("aqua_farming_crop_sea_grass_" .. i, {
            -- From aqua_farming/mapgen_sea_grass.lua
            deco_type = "simple",
            decoration = "unilib:crop_undersea_grass_wild",

            flags = "force_placement",
            noise_params = {
                octaves = 3,
                offset = -0.04,
                persist = 0.7,
                scale = 0.1,
                seed = 87112,
                spread = {x = 200, y = 200, z = 200},
            },
            param2 = 48,
            param2_max = 96,
            place_offset_y = -1,
            sidelen = 16,
        })

    end

end
