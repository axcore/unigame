---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    bluetangs_ethereal_fishes
-- Code:    n/a
-- Media:   CC-BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.ingredient_fish_extended = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.bluetangs_ethereal_fishes.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ingredient_fish_extended.init()

    return {
        description = "Extended raw fish set",
        depends = "shared_ethereal_fish",
        notes = "Extends the \"ingredient_fish_basic\" package, providing 25 additional raw fish",
    }

end

function unilib.pkg.ingredient_fish_extended.exec()

    -- Extended raw fish set
    local fish_list = {
        {"angelfish_freshwater",    S("Raw Freshwater Angelfish"),      "Pterophyllum scalare",    -1,  nil},
        {"bass_largemouth",         S("Raw Largemouth Bass"),           "Micropterus salmoides",    2,  nil},
        {"betta",                   S("Raw Betta"),                     "Betta splendens",          1,  nil},
        {"butterflyfish_oriental",  S("Raw Oriental Butterflyfish"),    "Chaetodon auripes",       -1,  nil},
        {"catfish_blind",           S("Raw Blind Cave Catfish"),        "Astyanax jordani",         1,  nil},
        {"danio_zebra",             S("Raw Zebra Danio"),               "Danio rerio",              1,  nil},
        {"grouper_goliath",         S("Raw Goliath Grouper"),           "Epinephelus itajara",     -1,  nil},
        {"guppy_dragon",            S("Raw Dragon Guppy"),              "Poecilia reticulata",      1,  nil},
        {"koi_goshiki",             S("Raw Goshiki Koi"),               "Cyprinus carpio",          1,  "ethereal_sakura"},
        {"koi_orenji",              S("Raw Orenji Koi"),                "Cyprinus carpio",          1,  "ethereal_sakura"},
        {"lantern",                 S("Raw Lantern Fish"),              nil,                        1,  nil},
        {"lionfish_red",            S("Raw Red Lionfish"),              "Pterois volitans",        -1,  nil},
        {"mummichog",               S("Raw Mummichog"),                 "Fundulus heteroclitus",    1,  nil},
        {"perch_yellow",            S("Raw Yellow Perch"),              "Perca flavescens",         2,  nil},
        {"platy_wagtail",           S("Raw Wagtail Platy"),             "Xiphophorus maculatus",    1,  nil},
        {"pleco_common",            S("Raw Common Pleco"),              "Hypostomus plecostomus",   1,  nil},
        {"porcupine",               S("Raw Porcupine Fish"),            "Diodon holocanthus",      -1,  nil},
        {"pupfish_desert",          S("Raw Desert Pupfish"),            "Cyprinodon macularius",    1,  nil},
        {"sardine",                 S("Raw Sardine"),                   nil,                        2,  nil},
        {"seahorse_lined",          S("Lined Seahorse"),                "Hippocampus erectus",      0,  "ocean"},
        {"sergeant_major",          S("Raw Sergeant Major Fish"),       "Abudefduf saxatilis",     -1,  nil},
        {"squid_tempura",           S("Tempura Squid"),                 "Todarodes pacificus",      0,  "ocean"},
        {"tetra_blind",             S("Raw Blind Cave Tetra"),          "Astyanax mexicanus",       1,  "ethereal_grayness_ocean"},
        {"triggerfish_wedgetail",   S("Raw Wedgetail Triggerfish"),     "Rhinecanthus rectangulus", 1,  nil},
        {"walleye",                 S("Raw Walleye"),                   "Sander vitreus",           2,  nil},
    }

    -- Register fish
    for _, mini_list in ipairs(fish_list) do

        unilib.pkg.shared_ethereal_fish.register_fish({
            part_name = mini_list[1],
            description = mini_list[2],
            tastiness = mini_list[4],

            orig_name = nil,
            biome_part_name = mini_list[5],
            sci_name = mini_list[3],
        })

    end

end
