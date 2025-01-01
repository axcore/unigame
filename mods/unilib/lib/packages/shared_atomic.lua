---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.shared_atomic = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

-- Flag set to true, if we should show a warning if the elements and nodes/craftitems/tools
--      specified by the CSV files in this remix don't actually exist, or when any other problems
--      occur
-- If you modify periodic_table.csv, vapourise.csv or construct.csv, then you should temporarily
--      enable this flag to check for errors
local debug_warning_flag = false
-- Lines in vapourise.csv should specify one or more proportions which might add up to 100, so that
--      those proportions represent percentages. If this flag is true, show a warning for line whose
--      proportions don't add up to 100 (or 0, the default value)
-- Note that many lines have proportions that don't add up to 100 on purpose
-- For example, "unilib:sand_quartz" has the proportions "aluminium 3 iron 1", but that is
--      substituted into "group:sand" which has the proportions "other 20"; so the actual
--      proportions are "aluminium 15 iron 5"
local debug_warn_proportions_flag = false
-- When the output proportions of one item (e.g. "unilib:sand_quartz") is substituted into
--      another(e.g. "group:sand"), check that the vapourisation process doesn't produce more
--      samplings than the collector can store (default 8)
-- Flag set to true if the check should be done
local debug_warn_excess_flag = false

---------------------------------------------------------------------------------------------------
-- Shared variables
---------------------------------------------------------------------------------------------------

-- Constants read from the constants.csv must be available to other "atomic" packages
unilib.pkg.shared_atomic.constant_flag = false
unilib.pkg.shared_atomic.constant_table = {}

-- Table of elements, in the form
--      periodic_table[element_name] = mini_table
-- ...where "element_name" is a string like "hydrogen", and "mini_table" is in the form
--      .name = "hydrogen"
--      .description = "Hydrogen" (a translated string)
--      .number = 1 (the atomic number)
--      .symbol = "H"
--      .available_flag = true if available by vapourisation, false if not
-- Note that if vapourise.csv specifies an element can be obtained by vapourising items in a group,
--      e.g. "group:sand", then that element is "available" regardless of whether any items in
--      that group exist in the game. Otherwise, specific items e.g. "unilib:sand_ordinary" must
--      exist in the game, before .available_flag is set to true
unilib.pkg.shared_atomic.periodic_table = {}
-- Number of elements in the table (i.e. the size of the table)
unilib.pkg.shared_atomic.periodic_table_size = 0

-- Table of nodes/craftitems/tools, and the elements into which they're converted by the vapouriser
--      (although the actual conversion takes place in the "machine_atomic_collector" package)
-- The converted element is one of the samplings created below; e.g. the element_name "hydrogen"
--      represents "unilib:sampling_hydrogen")
-- Table in the form
--      vapourise_item_table[input_name] = vapourise_list
-- ...where "vapourise_list" is a list of mini-lists, each in the form
--      { element_name, max_quantity, probability }
-- The vapourisation calculation is described at length in the "atomic" remix's vapourise.csv file
unilib.pkg.shared_atomic.vapourise_item_table = {}
-- Corresponding table of item groups, and the elements into which they're converted
-- Table in the form
--      vapourise_group_table[group_name] = vapourise_list
-- ...where "group_name" is "soil" representing "group:soil", and so on, and "vapourise_list" is in
--      the format described above but with the following addition: "element_name" can also be the
--      word "other"
-- When "element_name" is the word "other", it is substituted for the output described in
--      unilib.pkg.shared_atomic.vapourise_item_table, whose "max_quantity" values are adjusted
--      accordingly
-- The vapourisation calculation is described at length in the "atomic" remix's vapourise.csv file
unilib.pkg.shared_atomic.vapourise_group_table = {}

-- Table of vapourised samplings and the nodes/craftitems/tools into which they can be converted
--      by the collector
-- Table in the form
--      construct_table[element_name] = { output_list, number_of_samplings_required }
-- ...where "output_list" contains the unilib name and the original mod's equivalent name (if any);
--      the first name in the list that actually exists in the game is the one used
unilib.pkg.shared_atomic.construct_table = {}
-- Lookup table, converting e.g. "unilib:sampling_hydrogen" into "hydrogen"
unilib.pkg.shared_atomic.lookup_table = {}

-- Atomic machine configurations (values shared between multiple machines)
-- The "size" of the machine (actually, the size of its inventory). A value in the range 2-8 (tubes
--      require an absolutely minimum inventory size of 2, even if the vapouriser/collector can
--      make do with one). If the value is modified permanently, the layout of the formspecs for
--      those machines may need to be adjusted
unilib.pkg.shared_atomic.machine_size = 8
-- The optimal distance of the tube between a vapouriser and a collector (a distance of 1
--      corresponds to 1 tube). Above or below this distance, the probability of each sampling being
--      produced is reduced
unilib.pkg.shared_atomic.optimal_distance = 20
-- The probability reduction for each tube above or below the optimal distance. To help out players
--      with few resources, we'll give them the first 20% for free
unilib.pkg.shared_atomic.tube_probability_penalty = 0.8 / unilib.pkg.shared_atomic.optimal_distance
-- The time delay (in seconds) between each vapourisation. Also the speed at which items are
--      moved along tubes between the vapouriser and collector
unilib.pkg.shared_atomic.transfer_time = 2

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function parse_elements(factor, vapourise_path, i, line, no_other_flag)

    -- Parses the third column in one of the lines in the "atomic" remix's vapourise.csv
    -- The first column specifies a node/craftitem/tool, e.g. "unilib:stone_ordinary" (not used by
    --      this function)
    -- The second column, passed as the "factor" argument, is a multiplication factor
    -- The third column, passed as the "line" argument, specifies the samplings produced when the
    --      item is vapourised, in which proportions, and in which probabilities
    --
    -- Each line is a collection of words, separated by whitespace
    -- Any word containing alphabetic characters, e.g. "hydrogen", is an element-name representing
    --      one of the samplings created below, e.g. "unilib:sampling_hydrogen". The word "other"
    --      has a special meaning
    -- That word is optionally followed by up to two values: the maximum quantity of samplings for
    --      each vapourisation (an integer, 1 or above, default 1), and the maximum probability that
    --      this type of sampling will be produced during the vapourisation (a float in the range
    --      0-1, default 1)
    -- Any leading/trailing numeric values are discarded
    --
    -- Returns a list, in the same form as a value in unilib.pkg.shared_atomic.vapourise_item_table,
    --      i.e. in the form { element_name, max_quantity, probability }
    -- If no alphabetic words are found returns an empty list

    local word_list = unilib.utils.split_string_by_whitespace(line)
    if #word_list == 0 then
        return word_list
    end

    -- (A reversed list is computationally cheaper)
    local word_list = unilib.utils.reverse_list(word_list)

    -- Parse the list
    local return_list = {}
    local combined_quantity = 0

    while #word_list > 0 do

        local element_name = table.remove(word_list)
        if tonumber(element_name) == nil then

            -- element_name obtained, now obtain the two optional numbers, starting by setting
            --      their default values
            local max_quantity = 1
            local probability = 1

            local optional = tonumber(word_list[#word_list])
            if optional ~= nil and optional > 0 then

                max_quantity = table.remove(word_list)
                local optional2 = tonumber(word_list[#word_list])
                if optional2 ~= nil and optional2 >= 0 then
                    probability = table.remove(word_list)
                end

            end

            combined_quantity = combined_quantity + max_quantity

            -- If element_name is invalid, ignore it
            if element_name == "other" and no_other_flag then

                if debug_warning_flag then

                    unilib.utils.show_warning(
                        "shared_atomic package: \"other\" can\'t be used with specific input" ..
                                " items",
                        vapourise_path,
                        i
                    )

                end

            elseif element_name ~= "other" and
                    unilib.pkg.shared_atomic.periodic_table[element_name] == nil then

                if debug_warning_flag then

                    unilib.utils.show_warning(
                        "shared_atomic package: Unknown element in CSV file", vapourise_path, i
                    )

                end

            else

                table.insert(
                    return_list,
                    {element_name, math.ceil(max_quantity * factor), probability}
                )

            end

        end

    end

    if debug_warn_proportions_flag and combined_quantity ~= 0 and combined_quantity ~= 100 then

        unilib.utils.show_warning(
            "shared_atomic package: Combined proportions not add up to 100 in CSV file",
            vapourise_path,
            i,
            combined_quantity
        )

    end

    return return_list

end

local function update_vapourise_item_table(input_name, factor, vapourise_path, i, element_str)

    local parsed_list = parse_elements(factor, vapourise_path, i, element_str, true)

    -- Register the specified item as vapourisable...
    unilib.pkg.shared_atomic.vapourise_item_table[input_name] = parsed_list
    -- ...as well as any aliases
    if unilib.global.node_deconvert_table[input_name] ~= nil then

        for _, orig_name in pairs(unilib.global.node_deconvert_table[input_name]) do
            unilib.pkg.shared_atomic.vapourise_item_table[orig_name] = parsed_list
        end

    elseif unilib.global.craftitem_deconvert_table[input_name] ~= nil then

        for _, orig_name in pairs(unilib.global.craftitem_deconvert_table[input_name]) do
            unilib.pkg.shared_atomic.vapourise_item_table[orig_name] = parsed_list
        end

    elseif unilib.global.tool_deconvert_table[input_name] ~= nil then

        for _, orig_name in pairs(unilib.global.tool_deconvert_table[input_name]) do
            unilib.pkg.shared_atomic.vapourise_item_table[orig_name] = parsed_list
        end

    end

end

local function update_vapourise_group_table(input_name, factor, vapourise_path, i, element_str)

    local parsed_list = parse_elements(factor, vapourise_path, i, element_str, false)

    -- Register items in the group as vapourisable
    -- "input_name" is in the form group:X
    unilib.pkg.shared_atomic.vapourise_group_table[string.sub(input_name, 7)] = parsed_list

end

local function update_construct_table(element_name, output_name, quantity)

    -- Register the specified item as constructable...
    local output_list = {output_name}
    -- ...as well as any alises
    if unilib.global.node_deconvert_table[output_name] ~= nil then

        for _, orig_name in pairs(unilib.global.node_deconvert_table[output_name]) do
            table.insert(output_list, orig_name)
        end

    elseif unilib.global.craftitem_deconvert_table[output_name] ~= nil then

        for _, orig_name in pairs(unilib.global.craftitem_deconvert_table[output_name]) do
            table.insert(output_list, orig_name)
        end

    elseif unilib.global.tool_deconvert_table[output_name] ~= nil then

        for _, orig_name in pairs(unilib.global.tool_deconvert_table[output_name]) do
            table.insert(output_list, orig_name)
        end

    end

    unilib.pkg.shared_atomic.construct_table[element_name] = {output_list, tonumber(quantity)}

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_atomic.init()

    return {
        description = "Shared package for the \"atomic\" remix and its packages",
    }

end

function unilib.pkg.shared_atomic.post()

    -- Read the constants table from the "atomic" remix CSV
    local remix_dir = unilib.utils.get_remix_dir("atomic")
    local constants_path = remix_dir .. "/constants.csv"
    if not unilib.utils.is_file(constants_path) then

        if debug_warning_flag then
            unilib.utils.show_warning("shared_atomic package: Missing CSV file", constants_path)
        end

    else

        for i, csv_table in ipairs(unilib.utils.read_csv(constants_path)) do

            -- "key" is expected to contain at least one letter, "value" at least one digit
            local key, value = unpack(csv_table)
            if key ~= nil and value ~= nil then

                if not string.find(key, "%a") then

                    if debug_warning_flag then

                        unilib.utils.show_warning(
                            "shared_atomic package: Invalid constant", constants_path, i
                        )

                    end

                elseif not string.find(value, "[%d]") then

                    if debug_warning_flag then

                        unilib.utils.show_warning(
                            "shared_atomic package: Invalid constant value", constants_path, i
                        )

                    end

                else

                    unilib.pkg.shared_atomic.constant_table[key] = tonumber(value)
                    -- (Table is not empty)
                    unilib.pkg.shared_atomic.constant_flag = true

                end

            end

        end

    end

    -- Read the periodic table from the "atomic" remix CSV
    local periodic_path = remix_dir .. "/periodic_table.csv"
    if not unilib.utils.is_file(periodic_path) then

        if debug_warning_flag then
            unilib.utils.show_warning("shared_atomic package: Missing CSV file", periodic_path)
        end

    else

        for i, csv_table in ipairs(unilib.utils.read_csv(periodic_path)) do

            local number, symbol, description = unpack(csv_table)
            if number ~= nil then

                local mini_table = {
                    name = string.lower(description),
                    description = S(description),
                    number = tonumber(number),
                    symbol = symbol,
                    available_flag = false,
                }

                unilib.pkg.shared_atomic.periodic_table[mini_table.name] = mini_table
                unilib.pkg.shared_atomic.periodic_table_size =
                        unilib.pkg.shared_atomic.periodic_table_size + 1

            end

        end

    end

    -- Read the vapourisation table from the same remix
    local vapourise_path = remix_dir .. "/vapourise.csv"
    if not unilib.utils.is_file(vapourise_path) then

        if debug_warning_flag then
            unilib.utils.show_warning("shared_atomic package: Missing CSV file", vapourise_path)
        end

    else

        for i, csv_table in ipairs(unilib.utils.read_csv(vapourise_path)) do

            local input_str, factor, element_str = unpack(csv_table)
            if input_str ~= nil then

                if factor == nil or factor == "" then
                    factor = 1
                elseif unilib.pkg.shared_atomic.constant_table[factor] ~= nil then
                    factor = unilib.pkg.shared_atomic.constant_table[factor]
                end

                if input_str == "" or element_str == "" or element_str == nil then

                    if debug_warning_flag then

                        unilib.utils.show_warning(
                            "shared_atomic package: Invalid line in CSV file", vapourise_path, i
                        )

                    end

                else

                    for _, input_name in ipairs(
                        unilib.utils.split_string_by_whitespace(input_str)
                    ) do

                        if unilib.pkg.shared_atomic.vapourise_item_table[input_name] ~= nil or
                            unilib.pkg.shared_atomic.vapourise_group_table[input_name] ~= nil then

                            if debug_warning_flag then

                                unilib.utils.show_warning(
                                    "shared_atomic package: Duplicate input item in CSV file",
                                    vapourise_path,
                                    i
                                )

                            end

                        elseif string.sub(input_name, 1, 6) == "group:" then

                            update_vapourise_group_table(
                                input_name, factor, vapourise_path, i, element_str
                            )

                        elseif core.registered_items[input_name] == nil then

                            if debug_warning_flag then

                                unilib.utils.show_warning(
                                    "shared_atomic package: Unrecognised item in CSV file",
                                    vapourise_path,
                                    i
                                )

                            end

                        else

                            update_vapourise_item_table(
                                input_name, factor, vapourise_path, i, element_str
                            )

                        end

                    end

                end

            end

        end

    end

    -- If required, check that each input item doesn't produce more than
    --      unilib.pkg.shared_atomic.machine_size (default 8) outputs
    if debug_warn_excess_flag then

        for input_name, vapourise_list in pairs(unilib.pkg.shared_atomic.vapourise_item_table) do

            local sampling_table = {}
            for _, mini_list in pairs(vapourise_list) do
                sampling_table[mini_list[1]] = true
            end

            local def_table = core.registered_items[input_name]
            if def_table and def_table.groups ~= nil then

                for group, _ in pairs(def_table.groups) do

                    local group_vapourise_list =
                            unilib.pkg.shared_atomic.vapourise_group_table[group]
                    if group_vapourise_list ~= nil then

                        for _, mini_list in pairs(group_vapourise_list) do

                            if mini_list[1] ~= "other" then
                                sampling_table[mini_list[1]] = true
                            end

                        end

                    end

                end

            end

            local sampling_count = unilib.utils.get_table_size(sampling_table)
            if sampling_count > unilib.pkg.shared_atomic.machine_size then

                local msg = table.concat(unilib.utils.sort_table(sampling_table))
                unilib.utils.show_warning(
                    "shared_atomic package: Input item produces more samplings than the" ..
                            " collector can store",
                    input_name,
                    sampling_count,
                    table.concat(unilib.utils.sort_table(sampling_table), " ")
                )

            end

        end

    end

    -- Read the construction table from the same remix
    local construct_path = remix_dir .. "/construct.csv"
    if not unilib.utils.is_file(construct_path) then

        if debug_warning_flag then
            unilib.utils.show_warning("shared_atomic package: Missing CSV file", construct_path)
        end

    else

        for i, csv_table in ipairs(unilib.utils.read_csv(construct_path)) do

            local element_name, output_name, quantity = unpack(csv_table)
            if element_name ~= nil then

                if element_name == "" or output_name == "" or output_name == nil then

                    if debug_warning_flag then

                        unilib.utils.show_warning(
                            "shared_atomic package: Invalid line in CSV file", construct_path, i
                        )

                    end

                elseif unilib.pkg.shared_atomic.periodic_table[element_name] == nil then

                    if debug_warning_flag then

                        unilib.utils.show_warning(
                            "shared_atomic package: Unknown element in CSV file", construct_path, i
                        )

                    end

                elseif core.registered_items[output_name] == nil then

                    if debug_warning_flag then

                        unilib.utils.show_warning(
                            "shared_atomic package: Unrecognised item in CSV file",
                            construct_path,
                            i
                        )

                    end

                else

                    if quantity == "" or quantity == nil then
                        quantity = 1
                    elseif unilib.pkg.shared_atomic.constant_table[quantity] ~= nil then
                        quantity = unilib.pkg.shared_atomic.constant_table[quantity]
                    end

                    update_construct_table(element_name, output_name, tonumber(quantity))
                    unilib.pkg.shared_atomic.lookup_table["unilib:sampling_" .. element_name] =
                            element_name

                end

            end

        end

    end

    -- Check whether each element is actually available from vapourisation, and update
    --      unilib.pkg.shared_atomic.periodic_table accordingly
    -- To avoid circular relationships, ignore items that can be constructed from the collector
    local ignore_table = {}
    for _, mini_list in pairs(unilib.pkg.shared_atomic.construct_table) do

        for _, output_item in pairs(mini_list[1]) do

            if core.registered_items[output_item] ~= nil then
                ignore_table[output_item] = true
            end

        end

    end

    for input_item, vapourise_list in pairs(unilib.pkg.shared_atomic.vapourise_item_table) do

        if ignore_table[input_item] == nil then

            for _, mini_list in pairs(vapourise_list) do
                unilib.pkg.shared_atomic.periodic_table[mini_list[1]]["available_flag"] = true
            end

        end

    end

    -- Create a "sampling" of each element, visible in machines like the atomic collector, but not
    --      available to the player directly
    for element_name, mini_table in pairs(unilib.pkg.shared_atomic.periodic_table) do

        unilib.register_craftitem("unilib:sampling_" .. element_name, nil, mode, {
            -- Original to unilib
            description = mini_table.description,
            inventory_image = "unilib_sampling_" .. element_name .. ".png",
            groups = {not_in_creative_inventory = 1},

            stack_max = 999,
        })

    end

    -- A failure to convert a single item into a collection of samplings produces a wisp of smoke
    --      (also not available to the player directly)
    unilib.register_craftitem("unilib:sampling_smoke", nil, mode, {
        -- Original to unilib
        description = S("Wisp of Smoke"),
        inventory_image = "unilib_sampling_smoke.png",
        groups = {not_in_creative_inventory = 1},

        stack_max = 999,
    })

end
