---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- register_support_deco_ore.lua
--      Support functions (decorations and ores)
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Support functions (decorations and ores)
---------------------------------------------------------------------------------------------------

function unilib.register._parse_flags(flags)

    -- Called by unilib.register_decoration_from_csv() and unilib.register_ore_from_csv() to parse
    --      a whitespace-separated string in the form "place_center_x place_center_z" (etc) into a
    --      comma-separated string in the from "place_center_x, place_center_z"

    if flags ~= nil and flags ~= "" then

        if string.find(flags, ",") then

            -- If unilib's CSV separator is not a comma, then commas may be used in the field
            --      (although that is not recommended)
            return flags

        else

            return table.concat(
                unilib.utils.split_string_by_whitespace(flags, true), ", "
            )

        end

    end

    return nil

end

function unilib.register._check_biomes_in_decoration(def_table)

    -- Called by unilib.register_decoration_complete(), unilib.register_decoration_from_csv() and
    --      unilib.register_decoration_simple()
    -- If biome filters have been enabled (unilib.setting.debug_biome_filter), then any decoration
    --      whose biomes don't match the filter, must not be created (otherwise, Minetest ignores
    --      the non-existent biome, and places the decoration in all biomes)
    -- If biome filters have not been enabled, or if the decoration doesn't specify any biomes,
    --      then the decoration can be created without changes to its definition table
    --
    -- Args:
    --      def_table (table): The definition table that's about to be used in a
    --          core.register_decoration() call
    --
    -- Return values:
    --      The specified def_table, with any non-matching biomes filtered out; or nil if all
    --          biomes have been filtered out (and thus the decoration must not be created)

    if def_table.biomes == nil or
            def_table.biomes == "" or
            unilib.setting.debug_biome_filter == nil or
            unilib.setting.debug_biome_filter == "" then

        -- No biomes specified, or biome filter not in place
        return def_table

    end

    local biome_list = unilib.utils.split_string_by_whitespace(def_table.biomes, true)
    if #biome_list == 1 and not string.find(biome_list[1], unilib.setting.debug_biome_filter) then

        -- Single biome does not exist, so do not create this decoration
        return nil

    else

        local adj_biome_list = {}
        for _, this_biome in ipairs(biome_list) do

            if string.find(this_biome, unilib.setting.debug_biome_filter) then
                table.insert(adj_biome_list, this_biome)
            end

        end

        if #adj_biome_list == 0 then

            -- None of the specified biomes exist, so do not create this decoration
            return nil

        end

    end

    return def_table

end
