---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_gaia_pebbles = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_gaia_pebbles.init()

    return {
        description = "Pebbles for the \"gaia\" remix",
        notes = "Creates large and small pebbles for every stone type found in gaia biomes (if" ..
                " they don\'t already exist), then places them as decorations. The pebbles are" ..
                " a visual guide to which types of stone can be found below the surface",
        depends = {"biome_gaia", "deco_gaia"},
        at_least_one = {"pebble_large", "pebble_small"},
    }

end

function unilib.pkg.deco_gaia_pebbles.post()

    -- unilib doesn't provides a global variable converting stone types (e.g. "ordinary") into
    --      node names (e.g. "unilib:stone_ordinary"), but not in the reverse direction, so create
    --      our own
    local convert_table = {}
    for part_name, _ in pairs(unilib.global.stone_table) do
        convert_table["unilib:stone_" .. part_name] = part_name
    end

    -- A table of stone types and their corresponding (smooth) stone nodes. Unlike "convert_table",
    --      this table only contains stones found in gaia's biomes.csv
    -- Table in the form
    --      stone_table[stone_type] = list_of_node_names
    local stone_table = {}
    -- A table of stone types and the biomes in which they're found (either at the surface level,
    --      in the level just below it, or the level just below that). Non-stone nodes are ignored
    --      in this table
    -- Table in the form
    --      biome_table[stone_type] = list_of_biome_names
    local biome_table = {}
    -- A corresponding table of stone types and the surface nodes for the biomes in which they're
    --      found
    -- Table in the form
    --      surface_table[stone_type] = list_of_node_names
    local surface_table = {}

    for _, mini_table in ipairs(unilib.global.biome_csv_setup_list) do

        if mini_table.biome_name ~= "" and string.sub(mini_table.biome_name, 1, 5) == "gaia_" then

            local stone_type_list = {}

            -- Bottom layer stones
            local bottom_name = mini_table.stone
            if bottom_name ~= "" and convert_table[bottom_name] ~= nil then

                local stone_type = convert_table[bottom_name]
                stone_table[stone_type] = bottom_name
                table.insert(stone_type_list, stone_type)

            end

            -- Middle layer stones
            local middle_name = unilib.utils.get_item_and_multiple(mini_table.fill_str)
            if middle_name ~= "" and convert_table[middle_name] ~= nil then

                local stone_type = convert_table[middle_name]
                stone_table[stone_type] = middle_name
                table.insert(stone_type_list, stone_type)

            end

            -- Surface layer stones
            local surface_name = unilib.utils.get_item_and_multiple(mini_table.top_str)
            if surface_name ~= "" and convert_table[surface_name] ~= nil then

                local stone_type = convert_table[surface_name]
                stone_table[stone_type] = surface_name
                table.insert(stone_type_list, stone_type)

            end

            -- Update the tables, so that pebbles for each stone type are placed in the biomes in
            --      which the corresponding stone nodes are found
            for _, stone_type in ipairs(stone_type_list) do

                if biome_table[stone_type] == nil then
                    biome_table[stone_type] = { mini_table.biome_name }
                elseif not unilib.utils.is_value_in_list(
                    mini_table.biome_name, biome_table[stone_type]
                ) then
                    table.insert(biome_table[stone_type], mini_table.biome_name)
                end

                if surface_name ~= "" and core.registered_nodes[surface_name] ~= nil then

                    if surface_table[stone_type] == nil then
                        surface_table[stone_type] = { surface_name }
                    elseif not unilib.utils.is_value_in_list(
                        surface_name, surface_table[stone_type]
                    ) then
                        table.insert(surface_table[stone_type], surface_name)
                    end

                end

            end

        end

    end

    -- Create any pebbles that don't already exist
    for stone_type, stone_name in pairs(stone_table) do

        local def_table = core.registered_nodes[stone_name]

        if unilib.global.pkg_executed_table["pebble_large"] ~= nil and
                core.registered_nodes["unilib:pebble_large_stone_" .. stone_type] == nil then

            unilib.pkg.pebble_large.register_pebble({
                part_name = stone_type,
                orig_name = nil,

                replace_mode = mode,
                description = def_table.description,
            })

        end

        if unilib.global.pkg_executed_table["pebble_small"] ~= nil and
            core.registered_nodes["unilib:pebble_small_stone_" .. stone_type .. "_1"] == nil then

            unilib.pkg.pebble_small.register_pebble({
                part_name = stone_type,

                replace_mode = mode,
                description = def_table.description,
            })

        end

    end

    -- Create decorations; small pebbles are relatively rare, and large pebbles are even rarer
    for stone_type, biome_list in pairs(biome_table) do

        if unilib.global.pkg_executed_table["pebble_large"] ~= nil then

            unilib.register_decoration_simple({
                deco_type = "simple",
                decoration = "unilib:pebble_large_stone_" .. stone_type,

                biomes = biome_list,
                fill_ratio = 0.0002,
                param2 = 0,
                param2_max = 3,
                place_on = surface_table[stone_type],
                y_max = tonumber(unilib.pkg.biome_gaia.constant_table["STRATO"]),
                y_min = tonumber(unilib.pkg.biome_gaia.constant_table["BEACH_MAX"]),
            })

        end

        if unilib.global.pkg_executed_table["pebble_small"] ~= nil then

            for i = 1, unilib.pkg.pebble_small.variant_count do

                unilib.register_decoration_simple({
                    deco_type = "simple",
                    decoration = "unilib:pebble_small_stone_" .. stone_type .. "_" .. i,

                    biomes = biome_list,
                    fill_ratio = 0.001,
                    param2 = 0,
                    param2_max = 3,
                    place_on = surface_table[stone_type],
                    y_max = tonumber(unilib.pkg.biome_gaia.constant_table["STRATO"]),
                    y_min = tonumber(unilib.pkg.biome_gaia.constant_table["OCEAN"]),
                })

            end

        end

    end

end
