---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- register_biome_csv.lua
--      Regiser biomes from CSV
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

-- When reading biomes, show warnings if nodes don't exist
local biome_check_table = {}

---------------------------------------------------------------------------------------------------
-- Regiser biomes from CSV
---------------------------------------------------------------------------------------------------

function unilib.register._register_biome_from_csv(data_table)

    -- Original to unilib
    -- The file biomes.csv in the remix folder defines a list of biomes and their properties
    -- Convert data loaded from the CSV into the format expected by unilib.register_biome(), then
    --      call that function
    --
    -- Args:
    --      data_table (table): Table created by ../lib/system/read/read_csv_remix.lua, defining the
    --          properties of a single biome. For the table format, see the comments in
    --          ../lib/system/global/global_variables.lua

    -- If the Minetest setting is specified, force a single biome across the whole world
    if unilib.setting.debug_forced_biome ~= nil and unilib.setting.debug_forced_biome ~= "" then

        if data_table.biome_name ~= unilib.setting.debug_forced_biome then

            return

        else

            data_table.y_max = unilib.constant.y_max
            data_table.y_min = unilib.constant.y_min
            data_table.heat_point = 50
            data_table.humidity_point = 50

        end

    end

    -- Prepare the biome definition
    local def_table = {}

    def_table.name = data_table.biome_name
    def_table.description = unilib.utils.brackets(data_table.description, data_table.remix_name)

    if data_table.dust ~= "" then
        def_table.node_dust = data_table.dust
    end

    if data_table.top_str ~= "" then

        local this_list = data_table.top_str:split("%s", false, 1, true)
        def_table.node_top = this_list[1]
        def_table.depth_top = tonumber(this_list[2] or 1)

    end

    if data_table.fill_str ~= "" then

        local this_list = data_table.fill_str:split("%s", false, 1, true)
        def_table.node_filler = this_list[1]
        def_table.depth_filler = tonumber(this_list[2] or 1)

    end

    if data_table.stone ~= "" then
        def_table.node_stone = data_table.stone
    end

    if data_table.water_top_str ~= "" then

        local this_list = data_table.water_top_str:split("%s", false, 1, true)
        def_table.node_water_top = this_list[1]
        def_table.depth_water_top = tonumber(this_list[2] or 1)

    end

    if data_table.water ~= "" then
        def_table.node_water = data_table.water
    end

    if data_table.river ~= "" then
        def_table.node_river_water = data_table.river
    end

    if data_table.riverbed_str ~= "" then

        local this_list = data_table.riverbed_str:split("%s", false, 1, true)
        def_table.node_riverbed = this_list[1]
        def_table.depth_riverbed = tonumber(this_list[2] or 1)

    end

    if data_table.cave_liquid ~= "" then

        -- Minetest expects a string or a list; make sure a concatenated string is converted to a
        --      list
        def_table.node_cave_liquid = unilib.utils.split_string_by_whitespace(data_table.cave_liquid)

    end

    if data_table.dungeon ~= "" then
        def_table.node_dungeon = data_table.dungeon
    end

    if data_table.dungeon_alt ~= "" then
        def_table.node_dungeon_alt = data_table.dungeon_alt
    end

    if data_table.dungeon_stair ~= "" then
        def_table.node_dungeon_stair = data_table.dungeon_stair
    end

    def_table.y_max = tonumber(data_table.y_max) or unilib.constant.y_max
    def_table.y_min = tonumber(data_table.y_min) or unilib.constant.y_min
    def_table.vertical_blend = tonumber(data_table.blend) or 0
    def_table.heat_point = tonumber(data_table.heat) or 50
    def_table.humidity_point = tonumber(data_table.humidity) or 50

    -- Check for missing nodes
    for _, full_name in pairs({
        def_table.node_dust,
        def_table.node_top,
        def_table.node_filler,
        def_table.node_stone,
        def_table.node_water_top,
        def_table.node_water,
        def_table.node_river_water,
        def_table.node_riverbed,
        def_table.node_cave_liquid,
        def_table.node_dungeon,
        def_table.node_dungeon_alt,
        def_table.node_dungeon_stair,
    }) do

        -- During all calls to this function, show only one warning for each missing node
        if full_name ~= nil and biome_check_table[full_name] == nil then

            if not unilib.utils.is_registered_node_or_mtgame_alias(full_name) then

                biome_check_table[full_name] = true
                unilib.utils.show_warning(
                    "unilib.register_biome_from_csv(): Unrecognised node in CSV file",
                    full_name
                )

            end

        end

    end

    -- The true argument shows that this is a CSV biome
    return unilib.register_biome(def_table, true)

end
