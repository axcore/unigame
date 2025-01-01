---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- load_optional.lua
--      Perform optional checks
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

-- Recursion limit, when checking package dependencies
local recursion_limit = 16

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function adjust_chain_list(chain_list, new_pkg_name, dependency_mode)

    -- Called by check_dependencies()
    -- Creates a new copy of the package chain, adding the most recent package to it

    local new_list = {}
    for _, mini_list in ipairs(chain_list) do
        table.insert(new_list, mini_list)
    end

    table.insert(new_list, { new_pkg_name, dependency_mode })

    return new_list

end

local function adjust_chain_check_table(chain_check_table, new_pkg_name)

    -- Called by check_dependencies()
    -- Creates a new copy of the package chain's check table (which checks for duplicate packages
    --      in the chain), adding the most recent package to it

    local new_table = {}
    for k, v in pairs(chain_check_table) do
        new_table[k] = v
    end

    new_table[new_pkg_name] = true

    return new_table

end

local function compile_chain_output(mini_list)

    -- Called by display_formatted_dependency_list(), after all calls to check_dependencies() are
    --      complete
    -- Formats two strings representing a single missing dependency, ready for display
    --
    -- Args:
    --      mini_list (list): A list in the form
    --          [remix_name, recursion_level, recursion_result, chain_list], as described below

    local msg1 = "   [" .. mini_list[1] .. "]"
    if mini_list[3] == "missing" then
        msg1 = msg1 .. " missing dependency"
    elseif mini_list[3] == "default" then
        msg1 = msg1 .. " missing dependency (with no dependencies of its own)"
    elseif mini_list[3] == "limit" then
        msg1 = msg1 .. " recursion limit reached"
    else
        msg1 = msg1 .. " package recurs in dependency chain"
    end

    local msg2 = "      "
    local count = 0
    for _, mini_mini_list in ipairs(mini_list[4]) do

        count = count + 1
        if count > 1 then
            msg2 = msg2 .. " > "
        end

        if mini_mini_list[2] == "depends" then
            msg2 = msg2 .. "[d] "
        elseif mini_mini_list[2] == "optional" then
            msg2 = msg2 .. "[o] "
        elseif mini_mini_list[2] == "at_least_one" then
            msg2 = msg2 .. "[a] "
        elseif mini_mini_list[2] == "suggested" then
            msg2 = msg2 .. "[s] "
        end

        msg2 = msg2 .. mini_mini_list[1]

    end

    return msg1, msg2

end

local function check_dependencies(
    remix_name, orig_pkg_name, this_pkg_name, recursion_level, chain_list, chain_check_table,
    remix_check_table, output_list
)
    -- A function, called by analyse_remix() and then by itself recursively, to compare the explicit
    --      list of packages in a remix, with all dependencies of those packages, so that any
    --      missing dependencies can be added to "output_list", and then displayed by the original
    --      calling code
    --
    -- "output_list" is a list of mini-lists. Each mini-list represents a package that is explicitly
    --      mentioned in the remix, and a chain of dependent packages, with each package in the
    --      chain dependent on the previous one
    -- When recursion ends, a new mini-list is added to "output_list". Recursion ends when no
    --      further information is needed about the package that is currently the last one in the
    --      chain, "this_pkg_name"
    -- Each mini-list in "output_list" is in the form
    --      [remix_name, recursion_level, recursion_result, chain_list]
    --
    -- ...in which:
    --      - remix_name: The name of the remix being checked (e.g. "mtgame")
    --      - recursion_level: The level of recursion, with the initial call to this function having
    --          the level 0
    --      - recursion_result: A string representing the reason for the end of recursion: "default"
    --          if the final package in the chain has no dependencies, "missing" if the final #
    --          package has a dependency not explicitly mentioned in the remix, "duplicate" if the
    --          final package has a dependency already added to the chain, "limit" if the recursion
    --          limit was reached
    --      - chain_list: A chain of package dependencies. A list of mini-lists, each in the form
    --          [pkg_name, dependency_mode]. The first item in the list represents a package
    --          explicitly mentioned in the remix (corresponding to the argument "orig_pkg_name").
    --          Each subsequent item represents a package on which the previous package depends.
    --          "dependency_mode" is one of the following strings: "orig" (for the first package
    --          in the chain), "depends", "optional", "at_least_one", "suggested"
    --
    -- Note that the calling code below does one set of recursion for every remix mentioned in
    --      unilib.setting.init_remix_pkg_set; a different "remix_check_table" applies for each
    --      remix (but "output_list" is shared between all remixes)
    --
    -- Args:
    --      remix_name (str): The name of the remix being checked (e.g. "mtgame")
    --      orig_pkg_name (str): The name of a package explicitly mentioned in that remix, e.g.
    --          "stone_ordinary"
    --      this_pkg_name (str): The name of the package whose dependencies are to be checked in
    --          this function call. "this_pkg_name" is a dependency of the last item in
    --          "chain_list"
    --      recursion_level (int): The level of recursion, with the first call to this function
    --          using the value 0
    --      chain_list (list): A chain of packages dependencies, as described above
    --      chain_check_table (table): A table of package names, one for each package represented
    --          in "chain_list". The keys are package names, the corresponding values are true
    --      remix_check_table (table): A table of package names, including all packages that are
    --          explicitly mentioned in the remix, as well as all packages that have already been
    --          checked via a call to this function. The keys are package names, the corresponding
    --          values are the four values used above: "depends", "optional", "at_least_one",
    --          "suggested"
    --      output_list (list): The output to display when recursion is complete, as described above
    --
    -- Return values:
    --      The updated "remix_check_table" and "output_list"

    local update_flag = false

    -- If the package "this_pkg_name" has been loaded, check for its dependencies
    local data_table = unilib.global.pkg_table[this_pkg_name]
    if data_table ~= nil then

        -- Hard dependencies
        for _, other_pkg_name in ipairs(unilib.utils.convert_to_list(data_table["depends"])) do

            local update_flag = true

            if remix_check_table[other_pkg_name] == "optional" or
                    remix_check_table[other_pkg_name] == "suggested" then

                -- This package was previously handled as a soft dependency, but now handle it as a
                --      hard dependency
                remix_check_table[other_pkg_name] = nil

            end

            if remix_check_table[other_pkg_name] ~= nil or
                    chain_check_table[other_pkg_name] ~= nil then

                -- The "other_pkg_name" package has already been handled, so we end recursion here
                table.insert(
                    output_list,
                    {
                        remix_name,
                        recursion_level,
                        "duplicate",
                        chain_list,
                    }
                )

            elseif recursion_level >= recursion_limit then

                -- Recursion limit reached
                table.insert(
                    output_list,
                    {
                        remix_name,
                        recursion_level,
                        "limit",
                        adjust_chain_list(chain_list, other_pkg_name, "depends"),
                    }
                )

            else

                -- This hard dependency is not mentioned in the remix, but should be
                remix_check_table[other_pkg_name] = "depends"

                table.insert(
                    output_list,
                    {
                        remix_name,
                        recursion_level,
                        "missing",
                        adjust_chain_list(chain_list, other_pkg_name, "depends"),
                    }
                )

                if not unilib.setting.show_dependency_hard_limit_flag then

                    -- Add this package to the chain, and continue recursion
                    remix_check_table, output_list = check_dependencies(
                        remix_name,
                        orig_pkg_name,
                        other_pkg_name,
                        recursion_level + 1,
                        adjust_chain_list(chain_list, other_pkg_name, "depends"),
                        adjust_chain_check_table(chain_check_table, other_pkg_name),
                        remix_check_table,
                        output_list
                    )

                end

            end

        end

        -- Minimal dependencies
        local main_list = unilib.utils.convert_to_list(data_table["at_least_one"])
        if #main_list > 0 then

            local update_flag = true

            -- .at_least_one can be a simple list of package names, i.e. {a, b, c}, in which
            --      case we require at least one of the packages to be available
            -- Alternatively, it can be a list of mini-lists, e.g. { {a, b, c}, {d, e, f} }, in
            --      which case we require at least one package from each mini-list to be
            --      available
            if type(main_list[1]) ~= "table" then

                -- To keep the code below simple, convert a simple list into a list of mini-lists
                main_list = { main_list }

            end

            for _, mini_list in ipairs(main_list) do

                -- Ignore any value that's not a mini-list, e.g. { {a, b, c}, d }
                if type(mini_list) == "table" then

                    for _, other_pkg_name in ipairs(mini_list) do

                        if remix_check_table[other_pkg_name] == "optional" or
                                remix_check_table[other_pkg_name] == "suggested" then

                            -- This package was previously handled as a soft dependency, but now
                            --      handle it as a hard dependency
                            remix_check_table[other_pkg_name] = nil

                        end

                        if remix_check_table[other_pkg_name] ~= nil or
                                chain_check_table[other_pkg_name] ~= nil then

                            -- The "other_pkg_name" package has already been handled, so we end
                            --      recursion here
                            table.insert(
                                output_list,
                                {
                                    remix_name,
                                    recursion_level,
                                    "duplicate",
                                    chain_list,
                                }
                            )

                        elseif recursion_level >= recursion_limit then

                            -- Recursion limit reached
                            table.insert(
                                output_list,
                                {
                                    remix_name,
                                    recursion_level,
                                    "limit",
                                    adjust_chain_list(chain_list, other_pkg_name, "at_least_one"),
                                }
                            )

                        else

                            -- This minimal dependency is not mentioned in the remix, but should be
                            remix_check_table[other_pkg_name] = "at_least_one"

                            table.insert(
                                output_list,
                                {
                                    remix_name,
                                    recursion_level,
                                    "missing",
                                    adjust_chain_list(chain_list, other_pkg_name, "at_least_one"),
                                }
                            )

                            if not unilib.setting.show_dependency_soft_limit_flag then

                                -- Add this package to the chain, and continue recursion
                            remix_check_table, output_list = check_dependencies(
                                    remix_name,
                                    orig_pkg_name,
                                    other_pkg_name,
                                    recursion_level + 1,
                                    adjust_chain_list(chain_list, other_pkg_name, "at_least_one"),
                                    adjust_chain_check_table(chain_check_table, other_pkg_name),
                                    remix_check_table,
                                    output_list
                                )

                            end

                        end

                    end

                end

            end

        end

        -- Optional dependencies
        for _, other_pkg_name in ipairs(unilib.utils.convert_to_list(data_table["optional"])) do

            local update_flag = true

            if remix_check_table[other_pkg_name] ~= nil or
                    chain_check_table[other_pkg_name] ~= nil then

                -- The "other_pkg_name" package has already been handled, so we end recursion here
                table.insert(
                    output_list,
                    {
                        remix_name,
                        recursion_level,
                        "duplicate",
                        chain_list,
                    }
                )

            elseif recursion_level >= recursion_limit then

                -- Recursion limit reached
                table.insert(
                    output_list,
                    {
                        remix_name,
                        recursion_level,
                        "limit",
                        adjust_chain_list(chain_list, other_pkg_name, "optional"),
                    }
                )

            else

                -- This optional dependency is not mentioned in the remix, but should be
                remix_check_table[other_pkg_name] = "optional"

                table.insert(
                    output_list,
                    {
                        remix_name,
                        recursion_level,
                        "missing",
                        adjust_chain_list(chain_list, other_pkg_name, "optional"),
                    }
                )

                if not unilib.setting.show_dependency_soft_limit_flag then

                    -- Add this package to the chain, and continue recursion
                    remix_check_table, output_list = check_dependencies(
                        remix_name,
                        orig_pkg_name,
                        other_pkg_name,
                        recursion_level + 1,
                        adjust_chain_list(chain_list, other_pkg_name, "optional"),
                        adjust_chain_check_table(chain_check_table, other_pkg_name),
                        remix_check_table,
                        output_list
                    )

                end

            end

        end

        -- Suggested dependencies
        for _, other_pkg_name in ipairs(unilib.utils.convert_to_list(data_table["suggested"])) do

            local update_flag = true

            if remix_check_table[other_pkg_name] ~= nil or
                    chain_check_table[other_pkg_name] ~= nil then

                -- The "other_pkg_name" package has already been handled, so we end recursion here
                table.insert(
                    output_list,
                    {
                        remix_name,
                        recursion_level,
                        "duplicate",
                        chain_list,
                    }
                )

            elseif chain_check_table[other_pkg_name] ~= nil then

                -- The "other_pkg_name" package has already been added to the package chain; to
                --      prevent infinite recursion, we must end recursion here
                table.insert(
                    output_list,
                    {
                        remix_name,
                        recursion_level,
                        "duplicate",
                        chain_list,
                    }
                )

            elseif recursion_level >= recursion_limit then

                -- Recursion limit reached
                table.insert(
                    output_list,
                    {
                        remix_name,
                        recursion_level,
                        "limit",
                        adjust_chain_list(chain_list, other_pkg_name, "suggested"),
                    }
                )

            else

                -- This suggested dependency is not mentioned in the remix, but should be
                remix_check_table[other_pkg_name] = "suggested"

                table.insert(
                    output_list,
                    {
                        remix_name,
                        recursion_level,
                        "missing",
                        adjust_chain_list(chain_list, other_pkg_name, "suggested"),
                    }
                )

                if not unilib.setting.show_dependency_soft_limit_flag then

                    -- Add this package to the chain, and continue recursion
                    remix_check_table, output_list = check_dependencies(
                        remix_name,
                        orig_pkg_name,
                        other_pkg_name,
                        recursion_level + 1,
                        adjust_chain_list(chain_list, other_pkg_name, "suggested"),
                        adjust_chain_check_table(chain_check_table, other_pkg_name),
                        remix_check_table,
                        output_list
                    )

                end

            end

        end

    end

    if not update_flag and remix_check_table[this_pkg_name] == nil then

        -- This package has no further dependencies, is not explicitly mentioned in the remix, and
        --      has not already been handled during the recursion process
        table.insert(
            output_list,
            {
                remix_name,
                recursion_level,
                "default",
                chain_list,
            }
        )

    end

    return remix_check_table, output_list

end

local function display_list_section(msg, pkg_list)

    -- Called by display_simple_dependency_list() to display one of the four sections of the
    --      package list

    unilib.utils.show_msg(msg)

    table.sort(pkg_list)
    for _, pkg_name in ipairs(pkg_list) do

        if unilib.global.pkg_table[pkg_name] == nil or
                unilib.global.pkg_table[pkg_name]["mod_name"] == nil then

            unilib.utils.show_msg("      " .. pkg_name .. "|?")

        else

            unilib.utils.show_msg(
                "      " .. pkg_name .. "|" .. unilib.global.pkg_table[pkg_name]["mod_name"]
            )

        end

    end

end

local function display_simple_dependency_list(output_list, main_check_table, first_order_flag)

    -- Called analyse_remix(), to display a simple list of package dependencies that are not
    --      specified in one or more remixes
    --
    -- Args:
    --      output_list (list): The list described in check_dependencies()
    --      main_check_table (table): A table whose keys are all packages specified in one or more
    --          remixes
    --      first_order_flag (bool): True to display only first-order dependencies (e.g. the package
    --          b, in a > b > c > d > e); false to display all dependencies (e.g. everything except
    --          a in a > b > c > d > e)

    local depends_table = {}
    local optional_table = {}
    local at_least_one_table = {}
    local suggested_table = {}

    -- mini_list in the form [remix_name, recursion_level, recursion_result, chain_list]
    for _, mini_list in ipairs(output_list) do

        if mini_list[3] == "missing" or mini_list[3] == "default" then

            local chain_list = mini_list[4]
            if chain_list[2] ~= nil then

                -- this_mini_list in the form [pkg_name, dependency_mode]
                local stop = 2
                if not first_order_flag then
                    stop = #chain_list
                end

                for i = 2, stop do

                    local this_mini_list = chain_list[i]

                    if main_check_table[this_mini_list[1]] == nil then

                        -- If a single package is both a hard and soft dependency to some other
                        --      package, then the hard dependency takes priority in the displayed
                        --      output
                        if this_mini_list[2] == "depends" then

                            depends_table[this_mini_list[1]] = true
                            at_least_one_table[this_mini_list[1]] = nil
                            optional_table[this_mini_list[1]] = nil
                            suggested_table[this_mini_list[1]] = nil

                        elseif this_mini_list[2] == "at_least_one" then

                            at_least_one_table[this_mini_list[1]] = true
                            optional_table[this_mini_list[1]] = nil
                            suggested_table[this_mini_list[1]] = nil

                        elseif this_mini_list[2] == "optional" then

                            optional_table[this_mini_list[1]] = true
                            suggested_table[this_mini_list[1]] = nil

                        elseif this_mini_list[2] == "suggested" then

                            suggested_table[this_mini_list[1]] = true

                        end

                    end

                end

            end

        end

    end

    unilib.utils.show_msg("Simple list of dependent package(s) missing in remix(es)")

    if first_order_flag then
        unilib.utils.show_msg("(First-order dependencies, e.g. b in a > b > c > d > e)")
    else
        unilib.utils.show_msg("(All dependencies, e.g. everything but a in a > b > c > d > e)")
    end

    local depends_list = unilib.utils.sort_table(depends_table)
    local at_least_one_list = unilib.utils.sort_table(at_least_one_table)
    local optional_list = unilib.utils.sort_table(optional_table)
    local suggested_list = unilib.utils.sort_table(suggested_table)

    if #depends_list > 0 then
        display_list_section("   .depends", depends_list)
    end

    if #at_least_one_list > 0 then
        display_list_section("   .at_least_one", at_least_one_list)
    end

    if #optional_list > 0 then
        display_list_section("   .optional", optional_list)
    end

    if #suggested_list > 0 then
        display_list_section("   .suggested", suggested_list)
    end

    if #depends_list == 0 and
            #optional_list == 0 and
            #at_least_one_list == 0 and
            #suggested_list == 0 then
        display_list_section("   [none found]", suggested_list)
    end

    unilib.utils.show_msg("End of list")

end

local function display_formatted_dependency_list(output_list, not_loaded_list)

    -- Called by analyse_remix(), to display a simple list of package dependencies that are not
    --      specified in one or more remixes
    --
    -- Args:
    --      output_list (list): The list described in check_dependencies()
    --      not_loaded_list (list): A list of package names which have not been loaded (for
    --          display in a separate list)

    unilib.utils.show_msg(
        "Detailed list of dependent package(s) missing in remix(es) (d = hard dependency," ..
                " o = optional, a = at least one, s = suggested)"
    )

    local count = 0
    for _, mini_list in ipairs(output_list) do

        -- (We don't need to display infinite recursions in the package dependency chain,
        --      e.g. a > b > c > d > e > c > d > e... )
        if mini_list[3] ~= "duplicate" then

            local msg1, msg2 = compile_chain_output(mini_list)
            unilib.utils.show_msg(msg1)
            unilib.utils.show_msg(msg2)
            count = count + 1

        end

    end

    unilib.utils.show_msg(string.format("End of list (missing dependencies found: %d)", count))

    if not unilib.utils.is_table_empty(not_loaded_list) then

        unilib.utils.show_msg("Unloaded packages whose dependencies were not checked:")
        for _, pkg_name in ipairs(not_loaded_list) do
            unilib.utils.show_msg("   " .. pkg_name)
        end

        unilib.utils.show_msg(
            string.format("End of list (unchecked packages: %d)", #not_loaded_list)
        )

    end

end

local function analyse_remix(remix_list)

    -- Called by the code below, to analyse one or more remixes for their package dependencies
    -- If more than one remix is specifie, then it is treated as though it were a single remix
    --      (and a combined list of package dependencies is displayed)

    local output_list = {}
    local not_loaded_list = {}
    local main_check_table = {}

    for _, remix_name in ipairs(remix_list) do

        local check_list = {}
        local check_table = {}

        -- Compile a table of packages that are explicitly mentioned by the remix
        for _, pkg_name in ipairs(unilib.global.remix_pkg_table[remix_name]) do

            -- (We can't check the dependencies of packages that were not loaded, so they are
            --      displayed in a separate list)
            if unilib.global.pkg_table[pkg_name] ~= nil then

                table.insert(check_list, pkg_name)
                check_table[pkg_name] = "default"
                main_check_table[pkg_name] = true

            else

                table.insert(not_loaded_list, pkg_name)

            end

        end

        -- Recursively check the dependencies for each of those packages, making a note of any which
        --      are not explicitly mentioned elsewhere in the remix
        for _, pkg_name in ipairs(check_list) do

            check_table, output_list = check_dependencies(
                remix_name,
                pkg_name,
                pkg_name,
                0,
                { {pkg_name, "orig"} },
                { pkg_name = true },
                check_table,
                output_list
            )

        end

    end

    if not unilib.utils.is_table_empty(output_list) then

        unilib.utils.show_msg(
            "Package dependency analysis for remixes: " ..
                    unilib.utils.convert_to_string(remix_list)
        )

        if unilib.setting.show_dependency_simple_flag then

            -- Display simple lists of dependencies that are not explicitly mentioned by the remix
            display_simple_dependency_list(output_list, main_check_table, true)
            display_simple_dependency_list(output_list, main_check_table, false)

        end

        if unilib.setting.show_dependency_detailed_flag then

            -- Display formatted list of dependencies that are not explicitly mentioned by the remix
            display_formatted_dependency_list(output_list, not_loaded_list)

        end

    else

        unilib.utils.show_msg(
            "Checked package dependencies; all of them are specified by remixes: " ..
            unilib.utils.convert_to_string(remix_list)
        )

    end

end

---------------------------------------------------------------------------------------------------
-- Setup code
---------------------------------------------------------------------------------------------------

-- If Minetest settings allow, check the list of packages in each remix. If the remix does not also
--      specify all dependent packages (both compulsory and optional), then we can display a list of
--      affected packages
if not unilib.setting.show_dependency_combined_flag then

    for _, remix_name in ipairs(unilib.global.init_remix_list) do
        analyse_remix( { remix_name } )
    end

else

    analyse_remix(unilib.global.init_remix_list)

end
