---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unimobs
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.meta_petz_settings = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.unimobs.add_mode

local debug_warning_flag = false

---------------------------------------------------------------------------------------------------
-- Shared variables
---------------------------------------------------------------------------------------------------

-- Constants read from the mob_constants.csv file should be available to other packages
unilib.pkg.meta_petz_settings.constant_flag = false
unilib.pkg.meta_petz_settings.constant_table = {}

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function to_bool(arg)

    if arg == nil then
        return false
    end

    if unilib.pkg.meta_petz_settings.constant_table[arg] ~= nil then
        arg = unilib.pkg.meta_petz_settings.constant_table[arg]
    end

    if arg == "true" or arg == "TRUE" then
        return true
--  elseif arg == "false" or arg == "FALSE" then
--      return false
    else
        return false
    end

end

local function to_string_or_nil(arg)

    if arg == nil or arg == "" then
        return nil
    elseif unilib.pkg.meta_petz_settings.constant_table[arg] ~= nil then
        return unilib.pkg.meta_petz_settings.constant_table[arg]
    else
        return arg
    end

end

local function to_number_or_default_value(arg, default)

    if arg == nil then
        return default
    elseif unilib.pkg.meta_petz_settings.constant_table[arg] ~= nil then
        return tonumber(unilib.pkg.meta_petz_settings.constant_table[arg])
    else
        return tonumber(arg)
    end

end

local function to_string_or_default_value(arg, default)

    -- N.B. This function is no longer called; it could be removed

    if arg == nil then
        return default
    elseif unilib.pkg.meta_petz_settings.constant_table[arg] ~= nil then
        return tostring(unilib.pkg.meta_petz_settings.constant_table[arg])
    else
        return tostring(arg)
    end

end

local function convert_custom_table(arg)

    -- The "arg" argument, if not nil, is expected to be a stringified table in the form
    --      "KEY=VALUE KEY=VALUE KEY=VALUE..."
    -- Convert "arg" to a table (which may be empty), and return it
    -- For each KEY=VALUE pair, the VALUE component is converted to a boolean or a numeric value,
    --      when possible; otherwise it is stored as a string
    -- N.B. This function does NOT substitute constant values

    local return_table = {}
    if arg == nil then
        return return_table
    end

    for term in string.gmatch(arg, "%S+") do

        local key, value = string.match(term, "([^=]+)=([^=]+)")
        if key ~= nil and value ~= nil then

            -- Convert boolean/numeric values
            if value == "true" or value == "TRUE" then

                return_table[key] = true

            elseif value == "false" or value == "FALSE" then

                return_table[key] = false

            else

                local num = tonumber(value)
                if num ~= nil then
                    return_table[key] = num
                else
                    return_table[key] = value
                end

            end

        end

    end

    return return_table

end

local function convert_harmful_nodes(arg)

    -- The "arg" argument, if not nil, is expected to be a whitespace-separated list of terms
    -- Each term is in the form NAME,DAMAGE,WHERE
    -- Convert "arg" into a list of mini-tables, in the form described below

    local return_list = {}
    if arg == nil then
        return return_list
    end

    for term in string.gmatch(arg, "%S+") do

        local word_list = {}
        for word in string.gmatch(term, "([^,]+)") do
            table.insert(word_list, word)
        end

        if #word_list > 0 then

            table.insert(
                return_list,
                {
                    name = word_list[1],
                    damage = tonumber(word_list[2]) or 1,
                    where = word_list[3] or "entity",
                }
            )

        end

    end

    return return_list

end

local function convert_string_to_list(arg)

    -- The "arg" argument, if not nil, is expected to be a whitespace-separated list
    -- Convert the string to an actual list
    -- Any items in "arg" which match keys in unilib.pkg.meta_petz_settings.constant_table, are
    --      substituted for the corresponding values

    local return_list = {}
    if arg == nil then
        return return_list
    end

    for word in string.gmatch(arg, "%S+") do

        local substitution = unilib.pkg.meta_petz_settings.constant_table[word]
        if substitution ~= nil then

            -- "substitution" may also be a whitespace-separated list
            for this_word in string.gmatch(substitution, "%S+") do
                table.insert(return_list, this_word)
            end

        else

            table.insert(return_list, word)

        end

    end

    return return_list

end

local function convert_string_to_lookup_table(arg)

    -- The "arg" argument, if not nil, is expected to be a whitespace-separated list
    -- Convert the string to a lookup table, in which the keys are the items in "arg", and the
    --      corresponding values are always true
    -- Any items in "arg" which match keys in unilib.pkg.meta_petz_settings.constant_table, are
    --      substituted for the corresponding values

    local return_table = {}
    if arg == nil then
        return return_table
    end

    for word in string.gmatch(arg, "%S+") do

        local substitution = unilib.pkg.meta_petz_settings.constant_table[word]
        if substitution ~= nil then

            -- "substitution" may also be a whitespace-separated list
            for this_word in string.gmatch(substitution, "%S+") do
                return_table[this_word] = true
            end

        else

            return_table[word] = true

        end

    end

    return return_table

end

local function extract_first_item_from_string(arg)

    -- Alternative to convert_string_to_lookup_table()
    -- The "arg" argument, if not nil, is expected to be a whitespace-separated list
    -- Extract the first item from the string, ignoring any of the subsequent ones. If no items are
    --      found, returns an empty string
    -- If the extracted item matches a key in unilib.pkg.meta_petz_settings.constant_table, it is
    --      substituted for the corresponding value

    if arg == nil then
        return ""
    end

    for word in string.gmatch(arg, "%S+") do

        local substitution = unilib.pkg.meta_petz_settings.constant_table[word]
        if substitution ~= nil then

            -- "substitution" may also be a whitespace-separated list
            for this_word in string.gmatch(substitution, "%S+") do
                return this_word
            end

        else

            return word

        end

    end

    -- "arg" is an empty string, or whitespace, (or a constant that consists of an empty string or
    --      whitespace)
    return ""

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.meta_petz_settings.init()

    return {
        description = "Loads mob-specific settings from the \"petz\" remix",
        -- N.B. This package's .exec() function must be run before the .exec() functions for any
        --      mob package, so that the mob packages can access the global variable
        --      unimobs.petz_msetting (via calls to unimobs.petz_api.get_msetting(), of course)
        first = true,
    }

end

function unilib.pkg.meta_petz_settings.exec()

    -- Read CSVs from the first remix with the label "petz" (default: the "petz" remix itself)
    local remix_name = unilib.utils.get_remix_by_label("petz") or "petz"
    local remix_dir = unilib.utils.get_remix_dir(remix_name)
    local constants_path = remix_dir .. "/mob_constants.csv"
    if not unilib.utils.is_file(constants_path) then

        if debug_warning_flag then

            unilib.utils.show_warning(
                "meta_petz_settings package: Missing CSV file", constants_path
            )

        end

    else

        for i, csv_table in ipairs(unilib.utils.read_csv(constants_path)) do

            -- "key" is expected to contain at least one letter, "value" at least one alphanumeric
            --      character
            local key, value = unpack(csv_table)
            if key ~= nil then

                if not string.find(key, "%a") then

                    if debug_warning_flag then

                        unilib.utils.show_warning(
                            "meta_petz_settings package: Invalid constant", constants_path, i
                        )

                    end

                else

                    -- Unspecified constants are allowed, so that empty columns can be marked
                    if not string.find(value, "%w") then
                        value = ""
                    end

                    unilib.pkg.meta_petz_settings.constant_table[key] = value
                    -- (Table is not empty)
                    unilib.pkg.meta_petz_settings.constant_flag = true

                end

            end

        end

    end

    -- Read mob-specific settings from the remix CSV
    local settings_path = remix_dir .. "/mob_settings.csv"
    if not unilib.utils.is_file(settings_path) then

        if debug_warning_flag then
            unilib.utils.show_warning("meta_petz_settings package: Missing CSV file", settings_path)
        end

    else

        for i, csv_table in ipairs(unilib.utils.read_csv(settings_path)) do

            local mob_type, disable_spawn_flag, custom_spawn_probability, spawn_node_str,
                    spawn_biome_str, spawn_max_height, spawn_min_height, spawn_herd_size,
                    predator_str, prey_str, repel_item_str, follow_item_str, feed_item_str,
                    custom_tame_count, breed_item_str, max_mating_distance, convert_with_str,
                    convert_to, custom_convert_count, harmful_node_str, custom_str,
                    check = unpack(csv_table)

            -- All fields are optional except "mob_type"
            if mob_type ~= nil then

                if not string.find(mob_type, "%a") then

                    if debug_warning_flag then

                        unilib.utils.show_warning(
                            "meta_petz_settings package: Invalid mob name", settings_path, i
                        )

                    end

                else

                    -- N.B. Uncomment this line to check that every line in the remix CSV has the
                    --      right number of columns
--                  unilib.log(tostring(check))

                    local mini_table = {
                        -- (was .disable_spawn)
                        -- Flag that can be set to true, temporarily, to prevent mobs from spawning
                        --      naturally (some mobs, such as ants and bees, spawn because of
                        --      non-generic code)
                        disable_spawn_flag = to_bool(disable_spawn_flag),
                        -- (was .spawn_chance)
                        -- Probability of spawning at suitable locations; a float in the range 0-1
                        --      (e.g. 0.6)
                        custom_spawn_probability = to_number_or_default_value(
                            custom_spawn_probability,
                            unimobs.petz_setting.spawn_probability
                        ),
                        -- (was .spawn_nodes)
                        -- Whitespace-separated string, converted to a lookup table, with any
                        --      constants substituted
                        -- If the lookup table is empty, the mob can spawn in/on any node (this is
                        --      a change from the original code, which specified nodes for every
                        --      mob). Otherwise, the mob can spawn only in/on the specified nodes
                        spawn_node_table = convert_string_to_lookup_table(spawn_node_str),
                        -- (not in original code)
                        -- Flag set to true if .spawn_node_table is empty (set below; we only want
                        ---     to walk through the table once)
                        spawn_node_all_flag = false,
                        -- (was .spawn_biome)
                        -- Whitespace-separated string, converted to a lookup table, with any
                        --      constants substituted
                        -- If the lookup table is empty, the mob can spawn in any biome (this is
                        --      a change from the original code, which specified the value "default"
                        --      to signify spawning in all biomes). Otherwise, the mob can spawn
                        --      only in the specified biome
                        spawn_biome_table = convert_string_to_lookup_table(spawn_biome_str),
                         -- (not in original code)
                        -- Flag set to true if .spawn_biome_table is empty (set below; we only want
                        --      to walk through the table once)
                        spawn_biome_all_flag = false,
                         -- (not in original code)
                         -- Maximum spawn height (if specified, an integer)
                        spawn_max_height = tonumber(spawn_max_height),
                         -- (not in original code)
                         -- Minimum spawn height (if specified, an integer)
                        spawn_min_height = tonumber(spawn_min_height),
                        -- (was .spawn_herd)
                        -- An integer, minimum value 1, maximum value
                        --      unimobs.petz_setting.max_spawn_herd_size
                        spawn_herd_size = to_number_or_default_value(spawn_herd_size, 1),
                        -- (was .predators)
                        -- Whitespace-separated string, converted to a list, with any constants
                        --      substituted
                        predator_list = convert_string_to_list(predator_str),
                        -- (was .preys)
                        -- Whitespace-separated string, converted to a list, with any constants
                        --      substituted
                        prey_list = convert_string_to_list(prey_str),
                        -- (not in original code)
                        -- Whitespace-separated string, converted to a lookup table, with any
                        --      constants substituted
                        -- Any items in the table, when wielded by the player, will repel the mob
                        -- Note that items in this table can be either items (e.g.
                        --      "unilib:item_stick_ordinary") or groups (e.g. "group:stick")
                        repel_item_table = convert_string_to_lookup_table(repel_item_str),
                        -- (not in original code)
                        -- The same whitespace-separated string, with all items but the first one
                        --      removed. As above, the value can be the name of an item or a group
                        --      name
                        repel_item_first = extract_first_item_from_string(repel_item_str),
                         -- (not in original code)
                        -- Flag set to true if .repel_item_table is empty (set below; we only want
                        --      to walk through the table once)
                        repel_item_none_flag = false,
                        -- (was .follow)
                        -- Whitespace-separated string, converted to a lookup table, with any
                        --      constants substituted
                        -- Any items in the table, when wielded by the player, will cause the mob to
                        --      follow
                        -- Note that items in this table can be either items (e.g.
                        --      "unilib:item_stick_ordinary") or groups (e.g. "group:stick")
                        follow_item_table = convert_string_to_lookup_table(follow_item_str),
                        -- (not in original code)
                        -- The same whitespace-separated string, with all items but the first one
                        --      removed. As above, the value can be the name of an item or a group
                        --      name
                        follow_item_first = extract_first_item_from_string(follow_item_str),
                         -- (not in original code)
                        -- Flag set to true if .follow_item_table is empty (set below; we only want
                        --      to walk through the table once)
                        follow_item_none_flag = false,
                         -- (not in original code)
                        -- Whitespace-separated string, converted to a lookup table, with any
                        --      constants substituted
                        -- Any items in the table, when used on a mob, will feed the mob
                        -- Note that in the original code, the items for feeding/following were the
                        --      same, creating the nonsensical situation that butterflies could be
                        --      fed using torches (and so on). It's suggested that the feed items
                        --      should be the same as the follow items, minus any items that's
                        --      aren't edible (such as torches)
                        -- Note that items in this table can be either items (e.g.
                        --      "unilib:item_stick_ordinary") or groups (e.g. "group:stick")
                        feed_item_table = convert_string_to_lookup_table(feed_item_str),
                        -- (not in original code)
                        -- The same whitespace-separated string, with all items but the first one
                        --      removed. As above, the value can be the name of an item or a group
                        --      name
                        feed_item_first = extract_first_item_from_string(feed_item_str),
                         -- (not in original code)
                        -- Flag set to true if .feed_item_table is empty (set below; we only want
                        --      to walk through the table once)
                        feed_item_none_flag = false,
                        -- (not in original code)
                        -- Number of times needed to feed the mob, in order to tame it; if not
                        --      specified, then the default value
                        --      (unimobs.petz_setting.default_tame_count) applies
                        custom_tame_count = tonumber(custom_tame_count),
                        -- (was .breed)
                        -- Whitespace-separated string, converted to a lookup table, with any
                        --      constants substituted
                        -- Any items in the table, when wielded by the player, will breed the mob
                        -- Note that items in this table can be either items (e.g.
                        --      "unilib:item_stick_ordinary") or groups (e.g. "group:stick")
                        breed_item_table = convert_string_to_lookup_table(breed_item_str),
                        -- (not in original code)
                        -- The same whitespace-separated string, with all items but the first one
                        --      removed. As above, the value can be the name of an item or a group
                        --      name
                        breed_item_first = extract_first_item_from_string(breed_item_str),
                         -- (not in original code)
                        -- Flag set to true if .breed_item_table is empty (set below; we only want
                        --      to walk through the table once)
                        breed_item_none_flag = false,
                        -- (was .copulation_distance)
                        -- An integer, the maximum distance between two mobs in order to produce a
                        --      baby momb
                        max_mating_distance = to_number_or_default_value(max_mating_distance, 0),
                        -- (was .convert)
                        -- Whitespace-separated string, converted to a lookup table, with any
                        --      constants substituted
                        -- Any items in the table, when wielded by the player, will convert the mob
                        --      from one type to another (e.g. converts wolves to dogs)
                        -- Note that items in this table can be either items (e.g.
                        --      "unilib:item_stick_ordinary") or groups (e.g. "group:stick")
                        convert_with_table = convert_string_to_lookup_table(convert_with_str),
                        -- (not in original code)
                        -- The same whitespace-separated string, with all items but the first one
                        --      removed. As above, the value can be the name of an item or a group
                        --      name
                        convert_with_first = extract_first_item_from_string(convert_with_str),
                         -- (not in original code)
                        -- Flag set to true if .convert_with_table is empty (set below; we only want
                        --      to walk through the table once)
                        convert_with_none_flag = false,
                        -- String describing a mob (e.g. "unilib:mob_dog_normal", substituted if
                        --      it's a constant), or any empty string if species conversion doesn't
                        --      apply to this mob
                        convert_to = to_string_or_nil(convert_to),
                        -- (was .convert_count)
                        -- Number of times needed to feed the mob, in order to convert it into
                        --      another kind of mob; if not specified, then the default value
                        --      (unimobs.petz_setting.default_convert_count) applies
                        custom_convert_count = tonumber(custom_convert_count),
                        -- (not in original code; replaces the unused mob property .noxious_nodes)
                        -- List describing nodes that cause damage to the mob (fire, lava and so on
                        --      automatically cause damage)
                        -- In the remix CSV file, you can specify one or more items in the form
                        --      NAME,DAMAGE,WHERE
                        -- ...in which NAME is a node name, DAMAGE is an optional number (default is
                        --      1), and WHERE is an optional string (either "entity" representing
                        --      the entity's position, or "stand" representing its standing
                        --      position; default is "stand")
                        -- This is automatically converted into a list of mini-tables in the form
                        --      .harmful_node_data_list - {
                        --          {name = "air", damage = 1, where = "entity"},
                        --          {name = "unilib:grass_ordinary_1", damage = 1, where = "stand"},
                        --      }
                        -- N.B. Does NOT support the conversion of constant values
                        harmful_node_data_list = convert_harmful_nodes(harmful_node_str),
                        -- N.B. Replaces a number of individual settings in the original petz.conf
                        -- N.B. Does NOT support the conversion of constant values
                        -- Includes the following settings, that were separate settings in the
                        --      original petz code:
                        --
                        --      .can_create_beaver_dam=true     (for beaver_normal, was .create_dam)
                        --      .cocoon_max_time=1500           (for silkworm_normal)
                        --      .cocoon_min_time=1200           (for silkworm_normal)
                        --      .custom_lay_egg_interval=1200   (for ant_queen, was
                        --                                          .lay_antegg_timing)
                        --      .custom_lifespan=3600           (not used by any petz mob)
                        --      .custom_max_laid_eggs=50        (for ant_queen, was
                        --                                          .ant_max_laid_eggs)
                        --      .custom_max_laid_eggs=1         (for gecko_normal, was
                        --                                          .max_laid_eggs)
                        --      .is_dyeable=true                (for sheep_normal, was .colorized)
                        --      .lay_egg_max_time=240           (for moth_normal)
                        --      .lay_egg_min_time=150           (for moth_normal)
                        --      .lay_egg_on_node=group:leaves   (for silkworm_normal)
                        --      .max_population=5               (for ant_queen, was
                        --                                          .ant_population)
                        --      .spawn_month=12                 (for monster_evil_santa, was
                        --                                          .seasonal)
                        --      .spawn_month=10                 (for monster_mr_pumpkin, was
                        --                                          .seasonal)
                        --
                        -- Packages which use these settings, should specify default values via a
                        --      call to unimobs.petz_api.initialise_custom_msetting(), in case the
                        --      remix CSV does not specify any values. See the "mob_silkworm_normal"
                        --      package for some example code
                        custom_table = convert_custom_table(custom_str),
                    }

                    if unilib.utils.is_table_empty(mini_table.spawn_node_table) then
                        mini_table.spawn_node_all_flag = true
                    end

                    if unilib.utils.is_table_empty(mini_table.spawn_biome_table) then
                        mini_table.spawn_biome_all_flag = true
                    end

                    if unilib.utils.is_table_empty(mini_table.repel_item_table) then
                        mini_table.repel_item_none_flag = true
                    end

                    if unilib.utils.is_table_empty(mini_table.follow_item_table) then
                        mini_table.follow_item_none_flag = true
                    end

                    if unilib.utils.is_table_empty(mini_table.feed_item_table) then
                        mini_table.feed_item_none_flag = true
                    end

                    if unilib.utils.is_table_empty(mini_table.breed_item_table) then
                        mini_table.breed_item_none_flag = true
                    end

                    if unilib.utils.is_table_empty(mini_table.convert_with_table) then
                        mini_table.convert_with_none_flag = true
                    end

                    unimobs.petz_msetting[mob_type] = mini_table

                end

            end

        end

    end

end
