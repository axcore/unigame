---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_farlands_flower_mixed = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_farlands_flower_mixed.init()

    return {
        description = "Generic decoration package placing flowers from the flowers_plus mod on" ..
                " grasses from farlands. Other flowers for which farlands does not provide a" ..
                " decoration (for some reason) are placed on ordinary grass",
    }

end

function unilib.pkg.deco_farlands_flower_mixed.post()

    -- Code adapted from the "deco_beautiflowers_mixed" mod. Some flowers in that mod did not have
    --      a decoration, but unilib provides decorations for all of them
    for _, mini_list in ipairs({
        {
            "allium_purple",
            "farlands_forest_coniferous_tall",
            "unilib:dirt_ordinary_with_litter_leafy",
        },
        {"daisy_oxeye", nil, nil},
        {"flower_ground_blue", nil, nil},
        {"flower_ground_pink", nil, nil},
        {"flower_ground_red", nil, nil},
        {"foxglove_pink", "farlands_forest_deciduous_tall", nil},
        {"foxglove_purple", "farlands_forest_deciduous", nil},
        {"lantana", "farlands_forest_deciduous_tall", nil},
        {"lavender", "farlands_swamp", "unilib:dirt_ordinary_with_turf_swamp"},
        {"lily_flame", "farlands_rainforest", "unilib:dirt_ordinary_with_turf_forest"},
        {"lobelia", nil, nil},
        {"pansy_blue", nil, nil},
        {"pansy_purple", nil, nil},
        {"petunia_blue", nil, nil},
        {"petunia_pink", nil, nil},
        {"petunia_white", nil, nil},
        {"rose_frozen", nil, nil},
    }) do

        local part_name = mini_list[1]
        local biome_name = mini_list[2]
        local dirt_name = mini_list[3] or "dirt_ordinary_with_turf"

        -- (Will check that the flower package is loaded. For the sake of simplicity, assume that
        --      if this package deco package is loaded, then all the farlands biome/dirt packages
        --      are loaded too)
        if unilib.global.pkg_executed_table["flower_" .. part_name] ~= nil then

            unilib.register_decoration_complete("farlands_flower_" .. part_name, nil, {
                -- From flowers_plus/init.lua
                biomes = biome_name,
                place_on = "unilib:" .. dirt_name,
                -- (y_max and y_min not in original code, but added for consistency with other
                --      flowers)
                y_max = unilib.constant.y_max,
                y_min = 1,
            })

        end

    end

end

