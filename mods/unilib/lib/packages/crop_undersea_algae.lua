---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aqua_farming
-- Code:    GPL 3.0
-- Media:   CC-BY-3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.crop_undersea_algae = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.aqua_farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.crop_undersea_algae.init()

    return {
        description = "Green algae (undersea crop)",
        depends = {"sand_ordinary", "shared_aqua_farming"},
        optional = "dye_basic",
    }

end

function unilib.pkg.crop_undersea_algae.exec()

    unilib.register_craftitem(
        -- From aqua_farming:sea_alga_item
        "unilib:crop_undersea_algae_harvest",
        "aqua_farming:sea_alga_item",
        mode,
        {
            description = S("Raw Green Algae"),
            inventory_image = "unilib_crop_undersea_algae_harvest.png",
            groups = {food = 1, food_vegan = 1, seafood = 1},

            on_use = unilib.cuisine.eat_on_use("unilib:crop_undersea_algae_harvest", 1),
        }
    )

    local orig_name_list = {}
    for i = 1, 6 do
        table.insert(orig_name_list, "aqua_farming:sea_alga_" .. i)
    end

    unilib.pkg.shared_aqua_farming.register_crop({
        -- From aqua_farming:sea_alga_item (creates unilib:crop_undersea_algae_harvest),
        --      aqua_farming:sea_alga_seed (creates unilib:crop_undersea_algae_seed),
        --      aqua_farming:sea_alga_1 etc (creates unilib:crop_undersea_algae_grow_1 etc),
        --      aqua_farming:sea_alga_wild (creates unilib:crop_undersea_algae_wild)
        part_name = "algae",
        grow_orig_name = orig_name_list,
        harvest_orig_name = "aqua_farming:sea_alga_item",
        seed_orig_name = "aqua_farming:sea_alga_seed",
        wild_orig_name = "aqua_farming:sea_alga_wild",
        steps = 6,

        replace_mode = mode,
        base_node = "unilib:sand_ordinary",
        -- N.B. 10 in original code
        chance = 15,
        drop_table = {
            items = {
                {items = {"unilib:crop_undersea_algae_harvest"}},
                {items = {"unilib:crop_undersea_algae_seed 2"}},
                {items = {"unilib:crop_undersea_algae_harvest 2"}, rarity = 10},
            },
        },
        interval = 10,
        min_light = 10,
        seed_description = S("Green Algae Seed"),
        wild_description = S("Wild Green Algae"),
    })
    if unilib.setting.dye_from_crops_flag and
            unilib.global.pkg_executed_table["dye_basic"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            -- N.B. For undersea crops, output is only 1 instead of the usual 2
            output = "unilib:dye_green",
            recipe = {
                {"unilib:crop_undersea_algae_harvest"},
            },
        })

    end

    for i = 1, 4 do

        unilib.register_decoration_generic("aqua_farming_crop_sea_algae_" .. i, {
            -- From aqua_farming/mapgen_sea_alga.lua
            deco_type = "simple",
            decoration = "unilib:crop_undersea_algae_wild",

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
