---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.meta_atomic_optimise = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.meta_atomic_optimise.init()

    return {
        description = "Experimental (but tested and working) package which reads from the" ..
                " vapourise.csv file in the \"atomic\" remix, and attempts to optimise it," ..
                " combining all items with identical proportions into a single line. Writes the" ..
                " output to vapourise_optimised.csv",
        notes = "Unlike the comparable \"meta_deco_optimise\", this package has no shared" ..
                " functions; the optimisation is done whenever the package is loaded",
    }

end

function unilib.pkg.meta_atomic_optimise.exec()

    local output_table = {}
    local original_count = 0
    local optimised_count = 0

    local remix_dir = unilib.utils.get_remix_dir("atomic")
    local input_path = remix_dir .. "/vapourise.csv"
    local output_path = remix_dir .. "/vapourise_optimised.csv"

    if unilib.utils.is_file(input_path) then

        for i, csv_table in ipairs(unilib.utils.read_csv(input_path)) do

            local input_item, vapourise_factor, proportion_str = unpack(csv_table)
            if input_item ~= nil and vapourise_factor ~= nil and proportion_str ~= nil then

                original_count = original_count + 1

                local comb_str = vapourise_factor .. " " .. proportion_str
                if output_table[comb_str] == nil then

                    output_table[comb_str] = {input_item}
                    optimised_count = 1

                else

                    table.insert(output_table[comb_str], input_item)

                end

            end

        end

    end

    -- Prepare the contents of the output file
    local line_list = {
        "# Output from the \"meta_atomic_optimise\" package, optimising the vapourise.csv file",
        "#    in the \"atomic\" remix by combining identical outputs into a single line",
        "# Original file: " .. input_path,
        "# Original outputs: " .. tostring(original_count),
        "# Optimised file: " .. output_path,
        "# Optimised outputs: " .. tostring(optimised_count),
        "# ",
    }

    for comb_str, mini_list in pairs(output_table) do

        local factor, proportion_str = comb_str:match("^([^%s]+)%s(.*)")
        table.insert(
            line_list,
            table.concat(mini_list, " ") .. "|" .. factor .. "|" .. proportion_str
        )

    end

    -- Write the output file, using the default separator
    unilib.utils.write_csv(output_path, nil, line_list)
    unilib.utils.show_msg(
        "meta_atomic_optimise package: optimised vapourisation file written to " .. output_path
    )

end
