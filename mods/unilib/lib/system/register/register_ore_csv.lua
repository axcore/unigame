---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- register_ore_csv.lua
--      Regiser ores from CSV
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function parse_spread(spread)

    -- Called by unilib.register_ore_from_csv() to parse a string in the form
    --      "x = 100, y = 100, z = 100", returning a table in the form {x = n, y = n, z = n}
    -- Everything but the first three numbers are ignored, so the x-y-z order must be preserved,
    --      but the non-numeric characters are irrelevant ("a = 100 b = 100 c = 100" would work just
    --      as well)
    -- If three numbers can be extracted, return nil (not an empty table)

    if spread ~= nil and spread ~= "" then

        for x, y, z in (spread):gmatch("(%d+)%D*(%d+)%D*(%d+)") do
            return {x = x, y = y, z = z}
        end

    end

    return nil

end

local function parse_clust_scarcity(clust_scarcity)

    -- Called by unilib.register_ore_from_csv() to parse a string in the form "n * n * n", but
    --      which might also be a string in the form "n"
    -- Everything but the first three numbers are ignored ("5 times 5 times 5" would work just as
    --      well)
    -- Returns a single number (the result of the multiplication, or the single specified number);
    --      or nil if the argument is not in either of those formats

    if clust_scarcity ~= nil and clust_scarcity ~= "" then

        for a, b, c in (clust_scarcity):gmatch("(%d+)%D*(%d+)%D*(%d+)") do
            return tonumber(a) * tonumber(b) * tonumber(c)
        end

    end

    return tonumber(clust_scarcity)

end

---------------------------------------------------------------------------------------------------
-- Regiser ores from CSV
---------------------------------------------------------------------------------------------------

function unilib.register._register_ore_from_csv(data_table)

    -- Original to unilib
    -- The files "ore_scatter.csv", "ore_sheet.csv", "ore_puff.csv", "ore_blob.csv", "ore_vein.csv",
    --      "ore_stratum.csv" in the remix folder define a list of ores and their properties
    -- Convert data loaded from the CSV into the format expected by unilib.register_ore(), then
    --      call that function
    --
    -- Args:
    --      data_table (table): Table created by ../lib/system/read/read_csv_remix.lua, defining the
    --          properties of a single ore distribution. For the table format, see the comments in
    --          ../lib/system/global/global_variables.lua

    local def_table = {}

    -- (All ore types)
    def_table.ore_type = data_table.ore_type
    def_table.ore = data_table.ore

    if data_table.ore_param2 ~= "" then
        def_table.ore_param2 = tonumber(data_table.ore_param2)
    end

    if data_table.wherein ~= "" then
        def_table.wherein = unilib.utils.split_string_by_whitespace(data_table.wherein, true)
    end

    def_table.clust_scarcity = parse_clust_scarcity(data_table.clust_scarcity)

    if data_table.clust_num_ores ~= "" then
        def_table.clust_num_ores = tonumber(data_table.clust_num_ores)
    end

    if data_table.clust_size ~= "" then
        def_table.clust_size = tonumber(data_table.clust_size)
    end

    if data_table.y_max ~= "" then
        def_table.y_max = tonumber(data_table.y_max)
    end

    if data_table.y_min ~= "" then
        def_table.y_min = tonumber(data_table.y_min)
    end

    def_table.flags = unilib.register.parse_flags(data_table.flags)

    if data_table.noise_threshold ~= "" then
        def_table.noise_threshold = tonumber(data_table.noise_threshold)
    end

    if data_table.np_offset ~= "" or
            data_table.np_scale ~= "" or
            data_table.np_spread ~= "" or
            data_table.np_seed ~= "" or
            data_table.np_octaves ~= "" or
            data_table.np_persist ~= "" then

        def_table.noise_params = {}

        if data_table.np_offset ~= "" then
            def_table.noise_params.offset = tonumber(data_table.np_offset)
        end

        if data_table.np_scale ~= "" then
            def_table.noise_params.scale = tonumber(data_table.np_scale)
        end

        def_table.noise_params.spread = parse_spread(data_table.np_spread)

        if data_table.np_seed ~= "" then
            def_table.noise_params.seed = tonumber(data_table.np_seed)
        end

        if data_table.np_octaves ~= "" then
            def_table.noise_params.octaves = tonumber(data_table.np_octaves)
        end

        if data_table.np_persist ~= "" then
            def_table.noise_params.persistence = tonumber(data_table.np_persist)
        end

    end

    def_table.biomes = unilib.utils.split_string_by_whitespace(data_table.biomes, true)

    -- Specific ore types
    if data_table.ore_type == "sheet" then

        if data_table.column_height_max ~= "" then
            def_table.column_height_max = tonumber(data_table.column_height_max)
        end

        if data_table.column_height_min ~= "" then
            def_table.column_height_min = tonumber(data_table.column_height_min)
        end

        if data_table.column_midpoint_factor ~= "" then
            def_table.column_midpoint_factor = tonumber(data_table.column_midpoint_factor)
        end

    elseif data_table.ore_type == "puff" then

        if data_table.nppt_offset ~= "" or
                data_table.nppt_scale ~= "" or
                data_table.nppt_spread ~= "" or
                data_table.nppt_seed ~= "" or
                data_table.nppt_octaves ~= "" or
                data_table.nppt_persist ~= "" then

            def_table.np_puff_top = {}

            if data_table.nppt_offset ~= "" then
                def_table.np_puff_top.offset = tonumber(data_table.nppt_offset)
            end

            if data_table.nppt_scale ~= "" then
                def_table.np_puff_top.scale = tonumber(data_table.nppt_scale)
            end

            def_table.np_puff_top.spread = parse_spread(data_table.nppt_spread)

            if data_table.nppt_seed ~= "" then
                def_table.np_puff_top.seed = tonumber(data_table.nppt_seed)
            end

            if data_table.nppt_octaves ~= "" then
                def_table.np_puff_top.octaves = tonumber(data_table.nppt_octaves)
            end

            if data_table.nppt_persist ~= "" then
                def_table.np_puff_top.persistence = tonumber(data_table.nppt_persist)
            end

        end

        if data_table.nppb_offset ~= "" or
                data_table.nppb_scale ~= "" or
                data_table.nppb_spread ~= "" or
                data_table.nppb_seed ~= "" or
                data_table.nppb_octaves ~= "" or
                data_table.nppb_persist ~= "" then

            def_table.np_puff_bottom = {}

            if data_table.nppb_offset ~= "" then
                def_table.np_puff_bottom.offset = tonumber(data_table.nppb_offset)
            end

            if data_table.nppb_scale ~= "" then
                def_table.np_puff_bottom.scale = tonumber(data_table.nppb_scale)
            end

            def_table.np_puff_bottom.spread = parse_spread(data_table.nppb_spread)

            if data_table.nppb_seed ~= "" then
                def_table.np_puff_bottom.seed = tonumber(data_table.nppb_seed)
            end

            if data_table.nppb_octaves ~= "" then
                def_table.np_puff_bottom.octaves = tonumber(data_table.nppb_octaves)
            end

            if data_table.nppb_persist ~= "" then
                def_table.np_puff_bottom.persistence = tonumber(data_table.nppb_persist)
            end

        end

    elseif data_table.ore_type == "vein" then

        if data_table.random_factor ~= "" then
            def_table.random_factor = tonumber(data_table.random_factor)
        end

    elseif data_table.ore_type == "stratum" then

        if data_table.npst_offset ~= "" or
                data_table.npst_scale ~= "" or
                data_table.npst_spread ~= "" or
                data_table.npst_seed ~= "" or
                data_table.npst_octaves ~= "" or
                data_table.npst_persist ~= "" then

            def_table.np_stratum_thickness = {}

            if data_table.npst_offset ~= "" then
                def_table.np_stratum_thickness.offset = tonumber(data_table.npst_offset)
            end

            if data_table.npst_scale ~= "" then
                def_table.np_stratum_thickness.scale = tonumber(data_table.npst_scale)
            end

            def_table.np_stratum_thickness.spread = parse_spread(data_table.npst_spread)

            if data_table.npst_seed ~= "" then
                def_table.np_stratum_thickness.seed = tonumber(data_table.npst_seed)
            end

            if data_table.npst_octaves ~= "" then
                def_table.np_stratum_thickness.octaves = tonumber(data_table.npst_octaves)
            end

            if data_table.npst_persist ~= "" then
                def_table.np_stratum_thickness.persistence = tonumber(data_table.npst_persist)
            end

        end

        if data_table.stratum_thickness ~= "" then
            def_table.stratum_thickness = tonumber(data_table.stratum_thickness)
        end

    end

    -- Check for valid heights, if required
    if unilib.setting.debug_check_heights_flag and
            not unilib.utils.check_heights(def_table.y_max, def_table.y_min) then

        unilib.utils.show_warning(
            "unilib.register_ore_from_csv(): Invalid height values in ore registration",
            def_table.ore,
            def_table.y_max,
            def_table.y_min
        )

    end

    -- Check for missing nodes
    for _, string_or_list in pairs({
        def_table.ore,
        def_table.wherein,
    }) do

        for _, full_name in pairs(unilib.utils.convert_to_list(string_or_list)) do

            -- During all calls to this function, show only one warning for each missing node
            if full_name ~= nil and ore_check_table[full_name] == nil then

                if not unilib.utils.is_registered_node_or_mtgame_alias(full_name) then

                    ore_check_table[full_name] = true
                    unilib.utils.show_warning(
                        "unilib.register_ore_from_csv(): Unrecognised node in CSV file",
                        full_name
                    )

                end

            end

        end

    end

    -- The true argument shows that this is a CSV ore
    return unilib.register_ore(def_table, true)

end
