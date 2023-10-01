---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.ingredient_fish_basic = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ingredient_fish_basic.init()

    return {
        description = "Basic raw fish set",
        notes = "Includes 16 raw fish, some of which are edible while raw (but all of which can" ..
                " be cooked). Also includes bonus/junk items for all fishing rods",
    }

end

function unilib.pkg.ingredient_fish_basic.exec()

    -- Basic raw fish set
    -- Throughout this package, the strings representing biomes can match a specific biome
    --      (e.g. "ethereal_sakura") or a general biome (e.g. "ocean", which matches any biome
    --      containing that word, e.g. "my_ocean_biome")
    -- N.B. In the descriptions, the word "Raw" is a clue to the player about which fish are edible
    local fish_list = {
        {"angler",      nil,    S("Raw Angler"),        2,      "ocean"},
        {"bluefin",     nil,    S("Raw Blue Fin"),      2,      nil},
        {"blueram",     nil,    S("Raw Blue Ram"),      2,      nil},
        {"catfish",     nil,    S("Raw Catfish"),       2,      nil},
        {"cichlid",     nil,    S("Raw Cichlid"),       2,      "ethereal_rainforest_ocean"},
        {"clownfish",   nil,    S("Raw Clownfish"),     2,      "savanna"},
        {"koi",         "coy",  S("Raw Koi"),           2,      "ethereal_sakura"},
        {"flathead",    nil,    S("Raw Flathead"),      2,      "rainforest"},
        {"jellyfish",   nil,    S("Jellyfish"),         0,      "ocean"},
        {"pike",        nil,    S("Raw Pike"),          2,      "ethereal_grassy"},
        {"piranha",     nil,    S("Raw Piranha"),       2,      "rainforest"},
        {"plaice",      nil,    S("Raw Plaice"),        2,      nil},
        {"pufferfish",  nil,    S("Pufferfish"),        -2,     "ethereal_desert_ocean"},
        {"salmon",      nil,    S("Raw Salmon"),        2,      nil},
        {"seahorse",    nil,    S("Seahorse"),          0,      "ocean"},
        {"trout",       nil,    S("Raw Trout"),         2,      "ocean"},
    }

    for _, row_list in ipairs(fish_list) do

        local part_name = row_list[1]
        local orig_name
        if row_list[2] == nil then
            orig_name = "ethereal:fish_" .. part_name
        else
            orig_name = "ethereal:fish_" .. row_list[2]
        end

        local description = row_list[3]
        local tastiness = row_list[4]
        local biome_name = row_list[5]

        if tastiness == 0 then

            unilib.register_craftitem("unilib:ingredient_fish_" .. part_name, orig_name, mode, {
                -- From ethereal:fish_angler, etc. Creates unilib:ingredient_fish_angler, etc
                description = description,
                inventory_image = "unilib_ingredient_fish_" .. part_name .. ".png",
            })

        else

            unilib.register_craftitem("unilib:ingredient_fish_" .. part_name, orig_name, mode, {
                -- From ethereal:fish_angler, etc. Creates unilib:ingredient_fish_angler, etc
                description = description,
                inventory_image = "unilib_ingredient_fish_" .. part_name .. ".png",
                groups = {ethereal_fish = 1, food_fish_raw = 1},

                on_use = unilib.cuisine_eat_on_use(
                    "unilib:ingredient_fish_" .. part_name, tastiness
                ),
            })

        end

        -- (These fish can be caught with any rod, but some require a specific biome)
        unilib.register_fishing_fish({
            full_name = "unilib:ingredient_fish_" .. part_name,
            biome_name = biome_name,
        })

    end

    -- Basic bonus item set
    local bonus_list = {
        {"unilib:flower_waterlily_ordinary",    nil},
        {"unilib:item_book_ordinary",           nil},
        {"unilib:mineral_crystallinum_spike",    "ethereal_frost"},
        {"unilib:fruit_banana_bunch",           "ethereal_grove"},
        -- From animalia mod
        {"animalia:nametag",                    nil},
        {"animalia:saddle",                     nil},
        -- From mobs_redo mod
        {"mobs:nametag",                        nil},
        {"mobs:saddle",                         nil},
        -- From petz mod; there is no name tag
        {"petz:saddle",                         nil},
    }

    for _, row_list in ipairs(bonus_list) do

        unilib.register_fishing_bonus({
            full_name = row_list[1],
            biome_name = row_list[2],
        })

    end

    -- Basic junk item set
    local junk_list = {
        {"unilib:utensil_bowl_wooden",          nil},
        {"unilib:item_stick_ordinary",          nil},
        {"unilib:item_string_ordinary",         nil},
        {"unilib:plant_papyrus_ordinary",       nil},
        {"unilib:dye_black",                    nil},
        {"unilib:tree_bamboo_trunk",            "ethereal_bamboo"},
    }

    for _, row_list in ipairs(junk_list) do

        unilib.register_fishing_junk({
            full_name = row_list[1],
            biome_name = row_list[2],
        })

    end

end
