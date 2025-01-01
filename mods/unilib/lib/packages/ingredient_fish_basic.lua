---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.ingredient_fish_basic = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ingredient_fish_basic.init()

    return {
        description = "Basic raw fish set",
        depends = "shared_ethereal_fish",
        notes = "Includes 32 raw fish, some of which are edible while raw (but all of which can" ..
                " be cooked)",
    }

end

function unilib.pkg.ingredient_fish_basic.post()

    -- Basic raw fish set
    local fish_list = {
        -- ethereal-ng 2021
        {"angler",                  "angler",           S("Raw Angler"),                nil,                                2,  "ocean"},
        {"catfish_redtail",         "catfish",          S("Raw Redtail Catfish"),       "Phractocephalus hemioliopterus",   2,  nil},
        {"cichlid_blueram",         "blueram",          S("Raw Blue Ram Cichlid"),      "Mikrogeophagus ramirezi",          2,  nil},
        {"cichlid_zebra",           "cichlid",          S("Raw Iceblue Zebra Cichlid"), "Maylandia greshakei",              2,  "ethereal_rainforest_ocean"},
        {"clownfish",               "clownfish",        S("Raw Clownfish"),             "Amphiprion ocellaris",             2,  "savanna"},
        {"flathead_dusky",          "flathead",         S("Raw Dusky Flathead"),        "Platycephalus fuscus",             2,  "rainforest"},
        {"jellyfish_moon",          "jellyfish",        S("Moon Jellyfish"),            "Aurelia aurita",                   0,  "ocean"},
        {"koi_showa",               "coy",              S("Raw Koi"),                   "Cyprinus carpio",                  2,  "ethereal_sakura"},
        {"pike_northern",           "pike",             S("Raw Northern Pike"),         "Esox lucius",                      2,  "ethereal_grassy"},
        {"piranha",                 "piranha",          S("Raw Piranha"),               nil,                                2,  "rainforest"},
        {"plaice",                  "plaice",           S("Raw Plaice"),                "Pleuronectes platessa",            2,  nil},
        {"pufferfish_tiger",        "pufferfish",       S("Tiger Pufferfish"),          "Takifugu rubripes",               -2,  "ethereal_desert_ocean"},
        {"salmon_atlantic",         "salmon",           S("Raw Atlantic Salmon"),       "Salmo salar",                      2,  nil},
        {"seahorse_red",            "seahorse",         S("Red Seahorse"),              "Hippocampus",                      0,  "ocean"},
        {"trout_rainbow",           "trout",            S("Raw Rainbow Trout"),         "Oncorhynchus mykiss",              2,  "ocean"},
        {"tuna_bluefin",            "bluefin",          S("Raw Bluefin Tuna"),          "Thunnus thynnus",                  2,  nil},

        -- ethereal-ng 2024
        {"carp_common",             "carp",             S("Raw Common Carp"),           "Cyprinus carpio",                  2,  "swamp"},
        {"cod",                     "cod",              S("Raw Cod"),                   "Gadus morhua",                     2,  "ocean"},
        {"flounder_european",       "flounder",         S("Raw European Flounder"),     "Platichthys flesus",               2,  "ocean"},
        {"mackerel_pacific",        "mackerel",         S("Raw Pacific Mackerel"),      "Scomber japonicus",                2,  "ethereal_glacier"},
        {"parrotfish_stoplight",    "parrot",           S("Raw Stoplight Parrotfish"),  "Sparisoma viride",                 2,  "desert"},
        {"seahorse_blue",           "seahorse_blue",    S("Blue Seahorse"),             "Hippocampus",                      0,  "ethereal_forest_coniferous_ocean"},
        {"seahorse_green",          "seahorse_green",   S("Green Seahorse"),            "Hippocampus",                      0,  "ethereal_rainforest_ocean"},
        {"seahorse_pink",           "seahorse_pink",    S("Pink Seahorse"),             "Hippocampus",                      0,  "ethereal_mushroom_ocean"},
        {"seahorse_yellow",         "seahorse_yellow",  S("Yellow Seahorse"),           "Hippocampus",                      0,  "ethereal_desert_ocean"},
        {"shrimp_white",            "shrimp",           S("White Shrimp"),              "Litopenaeus setiferus",            0,  "ocean"},
        {"snapper_red",             "redsnapper",       S("Raw Red Snapper"),           "Lutjanus campechanus",             2,  "ocean"},
        {"squid_humboldt",          "squid",            S("Humboldt Squid"),            "Dosidicus gigas",                  0,  "ocean"},
        {"tetra_neon",              "tetra",            S("Raw Neon Tetra"),            "Paracheirodon innesi",             1,  "ethereal_grayness_ocean"},
        {"tilapia",                 "tilapia",          S("Raw Tilapia"),               nil,                                2,  "ethereal_bamboo"},
        {"trevally_golden",         "trevally",         S("Raw Golden Trevally"),       "Gnathanodon speciosus",            2,  "ethereal_bamboo"},
        {"tuna_yellowfin",          "tuna",             S("Raw Yellowfin Tuna"),        "Thunnus albacares",                2,  "ethereal_rainforest"},
    }

    -- Register fish
    for _, mini_list in ipairs(fish_list) do

        unilib.pkg.shared_ethereal_fish.register_fish({
            part_name = mini_list[1],
            description = mini_list[3],
            tastiness = mini_list[5],

            orig_name = "ethereal:fish_" .. mini_list[2],
            biome_part_name = mini_list[6],
            sci_name = mini_list[4],
        })

    end

end
