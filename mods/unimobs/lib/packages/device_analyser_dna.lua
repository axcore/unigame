---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unimobs
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.device_analyser_dna = {}

local S = unimobs.intllib
local F = core.formspec_escape
local FS = function(...) return F(S(...)) end
local mode = unilib.global.imported_mod_table.unimobs.add_mode

-- Localise math functions (for speed)
local floor = math.floor
local random = math.random

local description = S("DNA Analyser")
-- Widget colours, to match those in ../lib/system/petz/petz_formspecs.lua
local dark_bg_colour = "#222222"
-- Gauge colours
local gauge_colour_table = {
    ["0.0"] = "#FF0000",    -- red
    ["0.2"] = "#FF5500",    -- orange
    ["0.4"] = "#FFAA00",    -- orange-ish
    ["0.6"] = "#FFFF00",    -- yellow
    ["0.8"] = "#55FF32",    -- light green
    ["1.0"] = "#00FF00",    -- green
}

-- Formspec layout
local sample_height = 0.8
local fuel_height = 2
local inv_height = 3.5
local analysis_empty_height = 2
local analysis_height = 2.25
local gauge_width = 6.75
local gauge_height = 0.3

-- Tables of materials used as fuel for a simple (approximate) and complex (exact) analysis
-- In a simple analysis, the visible gauges are not exact (and for the same mob, may show slightly
--      different values, every time an analysis is performed)
-- However, breeding mobs is already difficult enough, so the simple analysis is disabled by
--      default. To re-enable it, uncomment the code just below, replacing the example fuel with a
--      more realistic one
--[[
local simple_fuel_table = {
    ["unilib:tree_apple_wood"] = true,
}
]]--
local simple_fuel_table = {}
local complex_fuel_table = {
    ["unilib:mineral_mese_crystal"] = true,
    ["default:mese_crystal"] = true,
}
-- The hint should match the materials in the tables above
local hint = S("Insert mese crystals to complete analysis")

-- Optional flags
-- This device requires fuel to perform an analysis, unless this flag is changed to true (in which
--      case, all of the values just above are ignored)
-- Note that fuel is also not consumed in creative mode, when
--      unimobs.setting.enable_creative_bonus_flag is set
local ignore_fuel_flag = false

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function get_gauge_colour(ratio)

    -- Use an epsilon values and string formatting to prevent floating-point precision errors during
    --      rounding
    local rounded = floor((ratio + 1e-9) / 0.2) * 0.2
    rounded = string.format("%.1f", rounded)

    return gauge_colour_table[rounded] or gauge_colour_table["0.0"]

end

local function obscure_genetic_data(meta)

    -- Update the "genetic_table" metadata field, randomly adding/subtracting 1 to its values in
    --      order to obscure the real values

    local mob_type = meta:get_string("mob_type")
    local data_table = unimobs.petz_global.mob_table[mob_type]
    if data_table == nil then
        return
    end

    -- The ."genetic_table" metadata field contains values such as the mob's skin colour, which we
    --      don't need to display here
    -- Compile a table of "gene_type"s that we do need, one for each visible gauge (remembering that
    --      "gene_name" is nil or an empty string for an invisible gauge)
    local check_table = {}
    -- mini_list in the form { gene_type, gene_name, ... }
    for _, mini_list in ipairs(data_table.genetic_init_list) do

        if mini_list[2] ~= nil and mini_list[2] ~= "" then
            check_table[mini_list[1]] = true
        end

    end

    -- Import values from metadata, and tweak them to obscure the mob's real genetic values
    local genetic_table = core.deserialize(meta:get_string("genetic_table"))
    for gene_type, value in pairs(genetic_table) do

        if check_table[gene_type] ~= nil then

            -- Randomly add 1, subtract 1, or keep the same (but don't exceed min/max values)
            genetic_table[gene_type] = value + random(-1, 1)
            if genetic_table[gene_type] <
                    data_table.genetic_range_table[gene_type]["overall_min"] or
                    genetic_table[gene_type] >
                    data_table.genetic_range_table[gene_type]["overall_max"] then
                genetic_table[gene_type] = value
            end

        end

    end

    meta:set_string("genetic_table", core.serialize(genetic_table))

end

local function get_formspec(pname, meta)

    -- Compile a table of descriptions ("gene_name") matching each "gene_type" for this mob
    -- When no description is available, that gene is not supposed to be visible
    local mob_type = meta:get_string("mob_type")
    local convert_table = {}
    local gauge_count = 0

    local data_table = unimobs.petz_global.mob_table[mob_type]
    if data_table ~= nil then

        for _, mini_list in ipairs(data_table.genetic_init_list) do

            -- mini_list in the form { gene_type, gene_name, ... }
            if mini_list[2] ~= nil and mini_list[2] ~= "" then

                convert_table[mini_list[1]] = mini_list[2]
                gauge_count = gauge_count + 1

            end

        end

    end

    -- Compile the formspec
    local formspec
    if mob_type == "" then

        formspec = "size[4," .. (sample_height + 1) .. "]" ..
            "label[0,0;" .. F(description) .. "]" ..
            "box[0," .. sample_height .. ";0.85,1;" .. dark_bg_colour .. "]" ..
            "label[1.25," .. (sample_height + 0.25) .. ";" .. FS("Awaiting sample") .. "]"

    else

        local analysis_type = meta:get_string("analysis_type")
        local analysis_text

        if analysis_type == "" then

            formspec = "size[8," .. (inv_height + 4) .. "]"
            analysis_text = S("Sample acquired")

        elseif gauge_count == 0 then

            formspec = "size[8," .. (analysis_empty_height) .. "]"
            analysis_text = S("Sample acquired, no genetic data found")

        else

            formspec = "size[8," .. (analysis_height + gauge_count) .. "]"
            analysis_text = S("Sample acquired, analysis complete")

        end

        formspec = formspec ..
            "label[0,0;" .. F(description) .. "]" ..
            "box[0," .. sample_height .. ";0.85,1;" .. dark_bg_colour .. "]" ..
            "image[0.025," .. (sample_height + 0.075) ..
                ";1,1;unilib_spawnegg_" .. mob_type .. ".png]" ..
            "label[1.25," .. (sample_height + 0.25) .. ";" .. F(analysis_text) .. "]"

        if analysis_type == "" then

            formspec = formspec ..
                "list[detached:device_analyser_dna_" .. pname .. ";fuel;0," .. fuel_height ..
                    ";1," .. fuel_height .. ";]" ..
                "label[1.25," .. (fuel_height + 0.15) .. ";" .. F(hint) .. "]" ..
                "list[current_player;main;0," .. inv_height .. ";8,4;]"

        else

            -- Display a gauge for each visible gene_type
            local row_count = 0
            local genetic_table = core.deserialize(meta:get_string("genetic_table"))
            -- Show gauges in alphabetical order of their description ("gene_name"), not by
            --      alphabetical order of their types ("gene_type")
            for _, gene_type in ipairs(unimobs.mobkit_api.sort_keys_by_values(convert_table)) do

                if genetic_table[gene_type] ~= nil then

                    local range_table = data_table.genetic_range_table[gene_type]
                    local genetic_value = genetic_table[gene_type]

                    local ratio
                    -- If not a continuous "range" of values (e.g. 0-10), just fill the gauge
                    if range_table == nil then

                        ratio = 1

                    else

                        ratio = (genetic_value - range_table.overall_min) /
                            (range_table.overall_max - range_table.overall_min)

                    end

                    if analysis_type ~= "complex" then

                        formspec = formspec ..
                            "label[0.5," .. (analysis_height + row_count) .. ";" ..
                                F(convert_table[gene_type]) .. "]"

                    else

                        formspec = formspec ..
                            "label[0.5," .. (analysis_height + row_count) .. ";" ..
                                F(convert_table[gene_type]) .. " (" .. genetic_value .. "/" ..
                                range_table.overall_max .. ")]"

                    end

                    formspec = formspec ..
                        "box[0.5," .. (analysis_height + row_count + 0.5) .. ";" ..
                            gauge_width .. "," .. gauge_height .. ";" ..
                            dark_bg_colour .. "]" ..
                        "box[0.5," .. (analysis_height + row_count + 0.5) .. ";" ..
                            (gauge_width * ratio) .. "," .. gauge_height .. ";" ..
                            get_gauge_colour(ratio) .. "]"

                    row_count = row_count + 1

                end

            end

        end

    end

    -- Display the formspec
    return formspec

end

local function use_tool(user, itemstack, luaent)

    -- Called when the player right-clicks a mob while wielding this tool
    -- "Collects a sample" from the mob by storing values in the tool's metadata, and then opens
    --      the formspec so the user can insert fuel

    -- Basic checks. This tool will work only on mobs compatible with the Petz API
    if not luaent or not unimobs.mobkit_api.is_object_alive(luaent.object) then
        return
    end

    -- Store details about the mob in the tool's metadata; they're available until the "display" is
    --      cleared (or until the device is used on another mob)
    local meta = itemstack:get_meta()

    meta:set_string("mob_type", luaent.mob_type)
    meta:set_string("mob_description", luaent.description)
    meta:set_string("genetic_table", core.serialize(luaent.genetic_table))

    -- If no fuel is required, we can skip a stage
    local pname = user:get_player_name()
    if ignore_fuel_flag or (
        unilib.utils.is_creative(pname) and unimobs.setting.enable_creative_bonus_flag
    ) then
        meta:set_string("analysis_type", "complex")
    else

        -- Otherwise, the player must insert some fuel before the analysis can be performed
        meta:set_string("analysis_type", "")

        -- Register a detached inventory for inserting fuel
        local inv = core.create_detached_inventory("device_analyser_dna_" .. pname, {

            allow_put = function(inv, listname, index, stack, player)

                -- Accept only one item of fuel, returning everything else to the player's inventory
                local fuel_name = stack:get_name()
                if simple_fuel_table[fuel_name] == nil and complex_fuel_table[fuel_name] == nil then

                    if not unilib.utils.is_creative(pname) then

                        core.after(0, function()
                            player:get_inventory():add_item("main", stack)
                        end)

                    end

                    return 0

                end

                stack:take_item(1)

                core.after(0, function()

                    inv:set_stack(listname, index, nil)
                    if simple_fuel_table[fuel_name] ~= nil then

                        meta:set_string("analysis_type", "simple")
                        -- Update the "genetic_table" metadata field, randomly adding/subtracting 1
                        --      to its values in order to obscure the real values
                        obscure_genetic_data(meta)

                    else

                        -- Don't update the "genetic_table" metadata field; show its actual value
                        --      in the formspec
                        meta:set_string("analysis_type", "complex")

                    end

                    -- Re-open the formspec to show the analysis
                    core.show_formspec(
                        pname,
                        "unilib:formspec_device_analyser_dna",
                        get_formspec(pname, meta)
                    )

                end)

                return 1

            end,

            allow_take = function(inv, listname, index, stack, player)
                return stack:get_count()
            end,
        })

        inv:set_size("fuel", 1)

    end

    -- Open the formspec
    core.show_formspec(
        pname,
        "unilib:formspec_device_analyser_dna",
        get_formspec(pname, meta)
    )

end

local function consult_tool(user, itemstack)

    -- Called when the player right-clicks something other than a mob while wielding this tool
    -- Show the results of the most recent analysis (if any)

    -- Open the formspec
    local meta = itemstack:get_meta()
    local pname = user:get_player_name()

    core.show_formspec(
        pname,
        "unilib:formspec_device_analyser_dna",
        get_formspec(pname, meta)
    )

end

local function on_rightclick_mob_callback(self, clicker, wielded_item, wielded_name, is_owner_flag)

    -- Original to unimobs

    if not self.petz_compat_flag then

        -- This override was not applied; apply the standard behaviour instead
        return false

    end

    use_tool(clicker, wielded_item, self)
    -- Preserve the itemstack's metadata
    clicker:set_wielded_item(wielded_item)

    -- Do not apply the standard behaviour
    return true

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.device_analyser_dna.init()

    return {
        description = "DNA analyser",
        notes = "When used on a mob, displays the mob's genetic traits, consuming some amount of" ..
                " mese as a fuel. If you want to make the process of breeding mobs a bit easier" ..
                " or harder, then the package code can be tweaked. For example, you can" ..
                " eliminate the need to use fuel, changes the fuels used, or enable different" ..
                " analysis modes (one approximate, one precise). This tool only works on unimobs" ..
                " creatures associated with the \"petz\" API",
        depends = {"metal_copper", "metal_steel", "mineral_diamond", "mineral_mese"},
    }

end

function unilib.pkg.device_analyser_dna.exec()

    local c_copper = "unilib:metal_copper_ingot"
    local c_crystal = "unilib:mineral_mese_crystal"
    local c_steel = "unilib:metal_steel_ingot"

    unilib.register_craftitem("unilib:device_analyser_dna", nil, mode, {
        -- Original to unimobs
        description = unilib.utils.hint(description, S("right-click mobs")),
        inventory_image = "unilib_device_analyser_dna.png",
        -- (no groups)

        -- The craftitem has metadata, so a stack limit is required
        stack_max = 1,

        on_place = function(itemstack, user, pointed_thing)

            -- This callback handles right-clicking nodes, etc. Right-clicking a mob is handled by
            --      the override callback below
            if user ~= nil then

                -- Re-display data from the previous sample
                consult_tool(user, itemstack)

            end

            return itemstack

        end,
    })
    unilib.register_craft({
        -- Original to unimobs
        output = "unilib:device_analyser_dna",
        recipe = {
            {c_steel, c_crystal, c_steel},
            {c_copper, "unilib:mineral_diamond_gem", c_copper},
            {c_steel, c_crystal, c_steel},
        },
    })

    -- Override the standard behaviour when a mob is right-clicked while wielding this item
    unimobs.petz_api.register_rightclick_override(
        "unilib:device_analyser_dna", on_rightclick_mob_callback
    )

end
