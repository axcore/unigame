---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.ingredient_fish_gaia = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ingredient_fish_gaia.init()

    return {
        description = "Fish set for the \"gaia\" remix",
        depends = "shared_ethereal_fish",
        excludes = {"ingredient_fish_basic", "ingredient_fish_extended"},
    }

end

function unilib.pkg.ingredient_fish_gaia.post()

    -- Gaia fish set (includes fish from the "ingredient_fish_basic" and "ingredient_fish_extended"
    --      packages, but with gaia biomes)
    -- Fish have been allocated to gaia biomes in a very crude way. Some freshwater fish are
    --      allocated to "coastal" or "beach", so they can be found in rivers in any biome
    local fish_list = {
        {"angelfish_freshwater",    nil,                S("Raw Freshwater Angelfish"),      "Pterophyllum scalare",            -1,  "coastal"},
        {"angler",                  "angler",           S("Raw Angler"),                    nil,                                2,  "cold"},
        {"bass_largemouth",         nil,                S("Raw Largemouth Bass"),           "Micropterus salmoides",            2,  "coastal"},
        {"betta",                   nil,                S("Raw Betta"),                     "Betta splendens",                  1,  "warm"},
        {"butterflyfish_oriental",  nil,                S("Raw Oriental Butterflyfish"),    "Chaetodon auripes",               -1,  "mild"},
        {"carp_common",             "carp",             S("Raw Common Carp"),               "Cyprinus carpio",                  2,  "beach"},
        {"catfish_blind",           nil,                S("Raw Blind Cave Catfish"),        "Astyanax jordani",                 1,  "ocean"},
        {"catfish_redtail",         "catfish",          S("Raw Redtail Catfish"),           "Phractocephalus hemioliopterus",   2,  "warm"},
        -- N.B. tastiness = 2 in "ingredient_fish_basic"
        {"cichlid_blueram",         "blueram",          S("Raw Blue Ram Cichlid"),          "Mikrogeophagus ramirezi",          1,  "warm"},
        -- N.B. tastiness = 2 in "ingredient_fish_basic"
        {"cichlid_zebra",           "cichlid",          S("Raw Iceblue Zebra Cichlid"),     "Maylandia greshakei",              1,  "hot"},
        -- N.B. tastiness = 2 in "ingredient_fish_basic"
        {"clownfish",               "clownfish",        S("Raw Clownfish"),                 "Amphiprion ocellaris",             1,  "warm"},
        {"cod",                     "cod",              S("Raw Cod"),                       "Gadus morhua",                     2,  "ocean"},
        {"danio_zebra",             nil,                S("Raw Zebra Danio"),               "Danio rerio",                      1,  "mild"},
        {"flathead_dusky",          "flathead",         S("Raw Dusky Flathead"),            "Platycephalus fuscus",             2,  "mild"},
        {"flounder_european",       "flounder",         S("Raw European Flounder"),         "Platichthys flesus",               2,  "ocean"},
        {"grouper_goliath",         nil,                S("Raw Goliath Grouper"),           "Epinephelus itajara",             -1,  "ocean"},
        {"guppy_dragon",            nil,                S("Raw Dragon Guppy"),              "Poecilia reticulata",              1,  "hot"},
        {"jellyfish_moon",          "jellyfish",        S("Moon Jellyfish"),                "Aurelia aurita",                   0,  "ocean"},
        {"koi_goshiki",             nil,                S("Raw Goshiki Koi"),               "Cyprinus carpio",                  1,  "mild"},
        {"koi_orenji",              nil,                S("Raw Orenji Koi"),                "Cyprinus carpio",                  1,  "mild"},
        -- N.B. tastiness = 2 in "ingredient_fish_basic"
        {"koi_showa",               "coy",              S("Raw Koi"),                       "Cyprinus carpio",                  1,  "mild"},
        {"lantern",                 nil,                S("Raw Lantern Fish"),              nil,                                1,  "cool"},
        {"lionfish_red",            nil,                S("Raw Red Lionfish"),              "Pterois volitans",                -1,  "hot"},
        {"mackerel_pacific",        "mackerel",         S("Raw Pacific Mackerel"),          "Scomber japonicus",                2,  "cool"},
        {"mummichog",               nil,                S("Raw Mummichog"),                 "Fundulus heteroclitus",            1,  "mild"},
        -- N.B. tastiness = 2 in "ingredient_fish_basic"
        {"parrotfish_stoplight",    "parrot",           S("Raw Stoplight Parrotfish"),      "Sparisoma viride",                 1,  "warm"},
        {"perch_yellow",            nil,                S("Raw Yellow Perch"),              "Perca flavescens",                 2,  "cool"},
        {"pike_northern",           "pike",             S("Raw Northern Pike"),             "Esox lucius",                      2,  "cool"},
        {"piranha",                 "piranha",          S("Raw Piranha"),                   nil,                                2,  "hot"},
        {"plaice",                  "plaice",           S("Raw Plaice"),                    "Pleuronectes platessa",            2,  "ocean"},
        {"platy_wagtail",           nil,                S("Raw Wagtail Platy"),             "Xiphophorus maculatus",            1,  "warm"},
        {"pleco_common",            nil,                S("Raw Common Pleco"),              "Hypostomus plecostomus",           1,  "coastal"},
        {"porcupine",               nil,                S("Raw Porcupine Fish"),            "Diodon holocanthus",              -1,  "warm"},
        {"pufferfish_tiger",        "pufferfish",       S("Tiger Pufferfish"),              "Takifugu rubripes",               -2,  "cold"},
        {"pupfish_desert",          nil,                S("Raw Desert Pupfish"),            "Cyprinodon macularius",            1,  "beach"},
        {"salmon_atlantic",         "salmon",           S("Raw Atlantic Salmon"),           "Salmo salar",                      2,  "cold"},
        {"sardine",                 nil,                S("Raw Sardine"),                   nil,                                2,  "beach"},
        {"seahorse_blue",           "seahorse_blue",    S("Blue Seahorse"),                 "Hippocampus",                      0,  "beach"},
        {"seahorse_green",          "seahorse_green",   S("Green Seahorse"),                "Hippocampus",                      0,  "beach"},
        {"seahorse_lined",          nil,                S("Lined Seahorse"),                "Hippocampus erectus",              0,  "ocean"},
        {"seahorse_pink",           "seahorse_pink",    S("Pink Seahorse"),                 "Hippocampus",                      0,  "ocean"},
        {"seahorse_red",            "seahorse",         S("Red Seahorse"),                  "Hippocampus",                      0,  "ocean"},
        {"seahorse_yellow",         "seahorse_yellow",  S("Yellow Seahorse"),               "Hippocampus",                      0,  "ocean"},
        {"sergeant_major",          nil,                S("Raw Sergeant Major Fish"),       "Abudefduf saxatilis",             -1,  "hot"},
        {"shrimp_white",            "shrimp",           S("White Shrimp"),                  "Litopenaeus setiferus",            0,  "beach"},
        {"snapper_red",             "redsnapper",       S("Raw Red Snapper"),               "Lutjanus campechanus",             2,  "ocean"},
        {"squid_humboldt",          "squid",            S("Humboldt Squid"),                "Dosidicus gigas",                  0,  "ocean"},
        {"squid_tempura",           nil,                S("Tempura Squid"),                 "Todarodes pacificus",              0,  "ocean"},
        {"tetra_blind",             nil,                S("Raw Blind Cave Tetra"),          "Astyanax mexicanus",               1,  "ocean"},
        {"tetra_neon",              "tetra",            S("Raw Neon Tetra"),                "Paracheirodon innesi",             1,  "ocean"},
        {"tilapia",                 "tilapia",          S("Raw Tilapia"),                   nil,                                2,  "coastal"},
        {"trevally_golden",         "trevally",         S("Raw Golden Trevally"),           "Gnathanodon speciosus",            2,  "warm"},
        {"triggerfish_wedgetail",   nil,                S("Raw Wedgetail Triggerfish"),     "Rhinecanthus rectangulus",         1,  "warm"},
        {"trout_rainbow",           "trout",            S("Raw Rainbow Trout"),             "Oncorhynchus mykiss",              2,  "ocean"},
        {"tuna_bluefin",            "bluefin",          S("Raw Bluefin Tuna"),              "Thunnus thynnus",                  2,  "mild"},
        {"tuna_yellowfin",          "tuna",             S("Raw Yellowfin Tuna"),            "Thunnus albacares",                2,  "mild"},
        {"walleye",                 nil,                S("Raw Walleye"),                   "Sander vitreus",                   2,  "beach"},
    }

    -- Register fish
    for _, mini_list in ipairs(fish_list) do

        local orig_name
        if mini_list[2] ~= nil then
            orig_name = "ethereal:fish_" .. mini_list[2]
        end

        unilib.pkg.shared_ethereal_fish.register_fish({
            part_name = mini_list[1],
            description = mini_list[3],
            tastiness = mini_list[5],

            orig_name = orig_name,
            biome_part_name = mini_list[6],
            sci_name = mini_list[4],
        })

    end

end
