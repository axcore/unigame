---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.meta_deco_optimise = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.meta_deco_optimise.do_optimise(remix_name)

    local biome_list = {}
    local output_table = {}
    local multiple_table = {}

    local original_count = 0
    local optimised_count = 0

    local remix_dir = unilib.utils.get_remix_dir(remix_name)
    local input_path = remix_dir .. "/decorations.csv"
    local output_path = remix_dir .. "/decorations_optimised.csv"

    if unilib.utils.is_file(input_path) then

        for i, csv_table in ipairs(unilib.utils.read_csv(input_path)) do

            local key = unpack(csv_table)
            if key ~= nil then

                local biome_name = csv_table[5]
                if biome_name ~= "" and csv_table[2] ~= "" and csv_table[9] ~= "" then

                    original_count = original_count + 1

                    -- To eliminate wasted time, only compare two decorations in the same biome
                    if output_table[biome_name] == nil then

                        output_table[biome_name] = {}
                        multiple_table[biome_name] = {}

                    end

                    if #output_table[biome_name] == 0 then

                        -- First occurence of this biome. Logic below doesn't work until
                        --      output_table contains at least one decoration
                        table.insert(output_table[biome_name], csv_table)
                        table.insert(multiple_table[biome_name], 1)
                        optimised_count = optimised_count + 1

                        -- At the end, show biomes in the same order they were read
                        table.insert(biome_list, biome_name)

                    else

                        -- csv_table represents a row in the .csv, specifying a single Minetest
                        --      decoration
                        -- Look for a matching row that we've already processed (i.e. a row in the
                        --      same biome that's identical, apart from the decoration name in
                        --      column 2)
                        local match_flag = false
                        for j, row_list in ipairs(output_table[biome_name]) do

                            if not match_flag then

                                local this_mismatch_flag = false
                                for k, column in ipairs(row_list) do

                                    if not this_mismatch_flag and
                                            k ~= 2 and
                                            column ~= csv_table[k] then
                                        this_mismatch_flag = true
                                    end

                                end

                                if not this_mismatch_flag then

                                    -- Match found; update the row that was already added to
                                    --  "output_table"
                                    output_table[biome_name][j][2] =
                                            output_table[biome_name][j][2] .. " " .. csv_table[2]
                                    multiple_table[biome_name][j] =
                                            multiple_table[biome_name][j] + 1
                                    match_flag = true

                                end

                            end

                        end

                        if not match_flag then

                            -- No matches found; add a new row to output_table
                            table.insert(output_table[biome_name], csv_table)
                            table.insert(multiple_table[biome_name], 1)
                            optimised_count = optimised_count + 1

                        end

                    end

                end

            end

        end

    end

    -- Prepare the contents of the output file
    local line_list = {
        "# Output from the \"meta_deco_optimise\" package, optimising a decorations.csv file,",
        "#    by combining identical decorations on a single line",
        "# Original file: " .. input_path,
        "# Original decorations: " .. tostring(original_count),
        "# Optimised file: " .. output_path,
        "# Optimised decorations: " .. tostring(optimised_count),
        "# ",
    }

    for _, biome_name in ipairs(biome_list) do

        table.insert(line_list, "# " .. biome_name)

        for i, row_list in ipairs(output_table[biome_name]) do

            -- For schematics/treelogs, code in ..lib/system/register/ calls
            --      core.register_decoration() separately for each item in the list, so we don't
            --      multiply the probability
            if row_list[1] == "simple" then
                row_list[9] = row_list[9] * multiple_table[biome_name][i]
            end

            table.insert(line_list, table.concat(row_list, "|"))

        end

    end

    -- Write the output file, using the default separator
    unilib.utils.write_csv(output_path, nil, line_list)
    unilib.utils.show_msg(
        "meta_deco_optimise package: optimised decorations file written to " .. output_path
    )

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.meta_deco_optimise.init()

    return {
        description = "Experimental (but tested and working) package which reads from a" ..
                " decorations.csv file, and attempts to optimise it, for example combining five" ..
                " separate ordinary grass decorations (of various lengths) into a single" ..
                " decoration, containing all five lengths. Writes the output to" ..
                " decorations_optimised.csv",
        notes = "One of the packages executed by the remix should check whether this package has" ..
                " been executed and, if so, call the shared function above (for a working" ..
                " example, see the \"base_gaia\" package). Then, simply add this package to the" ..
                " remix whenever you want to generate an optimised decorations.csv file",
    }

end
