---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- dirts.lua
--      Set up shared functions for dirt and turf nodes
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Register dirts (with and without turf)
---------------------------------------------------------------------------------------------------

function unilib.register_fertile_dirt(data_table)

    -- Original to unilib
    -- Registes a dirt node on which turf can be grown (does not include any dirts on which turf
    --      can't be grown, such as "unilib:dirt_ordinary_with_litter_coniferous")
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "dirt_ordinary" (in almost all cases, this will be the full
    --          item_name for the node)
    --      orig_name (str): e.g. "default:dirt"
    --      def_table (table): Full definition table for the node
    --
    -- data_table optional fields:
    --      replace_mode (str): e.g. "defer"
    --      dry_soil (str): The dry soil, if required, e.g. "unilib:soil_ordinary". If specified,
    --          .wet_soil must be specified as well
    --      wet_soil (str): The wet soil, if required, e.g. "unilib:soil_ordinary_wet"
    --
    -- Return values:
    --      The full_name of the new node

    local part_name = data_table.part_name
    local orig_name = data_table.orig_name
    local def_table = data_table.def_table

    local replace_mode = data_table.replace_mode or unilib.default_replace_mode
    local dry_soil = data_table.dry_soil or nil
    local wet_soil = data_table.wet_soil or nil

    local full_name = "unilib:" .. part_name

    if dry_soil ~= nil and minetest.registered_nodes[dry_soil] ~= nil and
            wet_soil ~= nil and minetest.registered_nodes[wet_soil] ~= nil then

        def_table.soil = {
            base = full_name,
            dry = dry_soil,
            wet = wet_soil,
        }

    end

    unilib.register_node(full_name, orig_name, replace_mode, def_table)

    -- Update global variables
    unilib.fertile_dirt_table[part_name] = full_name

    return full_name

end

function unilib.register_dirt_with_turf(data_table)

    -- Original to unilib
    -- Registes a dirt node on which turf can be grown (does not include any dirts on which turf
    --      can't be grown, such as "unilib:dirt_ordinary_with_litter_coniferous")
    --
    -- data_table compulsory fields:
    --      dirt_part_name (str): e.g. "dirt_ordinary"
    --      turf_part_name (str): e.g. "turf" (from "unilib:dirt_ordinary_with_turf"), "turf_dry"
    --          (from unilib:dirt_ordinary_with_turf_dry)
    --      orig_name (str): e.g. "default:dirt_with_grass"
    --      def_table (table): Full definition table for the node
    --
    -- data_table optional fields:
    --      replace_mode (str): e.g. "defer"
    --      dry_soil (str): The dry soil, if required, e.g. "unilib:soil_ordinary". If specified,
    --          .wet_soil must be specified as well
    --      wet_soil (str): The wet soil, if required, e.g. "unilib:soil_ordinary_wet"
    --      alt_dirt_part_name, alt_turf_part_name (str): If specified, these values are used in
    --          unilib.dirt_with_turf_table, rather than the equivalent values above. For example,
    --          when the turf cutter is used on "unilib:dirt_ordinary_with_cover_snow", it needs to
    --          create "unilib:dirt_construction_with_turf" (rather than the unwanted
    --          "unilib:dirt_construction_with_snow_cover"); in that case, .turf_part_name should be
    --          "snow_cover", and .alt_turf_part_name should be "turf"
    --      turf_description (str): e.g. "Turf". This value is stored in unilib.dirt_with_turf_table
    --          so, if the alternative fields above are used, the description will be "Turf" not
    --          "Snow Cover"
    --      turf_seeder (str): e.g. "unilib:snow_ordinary", "group:dry_grass". An item that, due to
    --          the action of the "turf_spread" ABM, convert the dirt node into the dirt-with-turf
    --          node
    --
    -- Return values:
    --      The full_name of the new node

    local dirt_part_name = data_table.dirt_part_name
    local turf_part_name = data_table.turf_part_name
    local orig_name = data_table.orig_name
    local def_table = data_table.def_table

    local replace_mode = data_table.replace_mode or unilib.default_replace_mode
    local dry_soil = data_table.dry_soil or nil
    local wet_soil = data_table.wet_soil or nil
    local alt_dirt_part_name = data_table.alt_dirt_part_name or dirt_part_name
    local alt_turf_part_name = data_table.alt_turf_part_name or turf_part_name
    local turf_description = data_table.turf_description or S("Turf")
    local turf_seeder = data_table.turf_seeder or nil

    local full_name = "unilib:" .. dirt_part_name .. "_with_" .. turf_part_name

    if dry_soil ~= nil and minetest.registered_nodes[dry_soil] ~= nil and
            wet_soil ~= nil and minetest.registered_nodes[wet_soil] ~= nil then

        def_table.soil = {
            base = full_name,
            dry = dry_soil,
            wet = wet_soil,
        }

    end

    -- If required, the turf covers all four sides (leaving the dirt itself visible only on the
    --      bottom)
    if unilib.overgrown_turf_flag then
        def_table.tiles = { def_table.tiles[1] }
    end

    unilib.register_node(full_name, orig_name, replace_mode, def_table)

    -- Update global variables
    local data_table = {
        dirt_part_name = alt_dirt_part_name,
        turf_part_name = alt_turf_part_name,
        turf_description = turf_description,
    }

    unilib.dirt_with_turf_table[full_name] = data_table

    if turf_seeder ~= nil then

        if unilib.turf_seeder_table[turf_seeder] == nil then
            unilib.turf_seeder_table[turf_seeder] = {}
        end

        unilib.turf_seeder_table[turf_seeder]["unilib:" .. dirt_part_name] = full_name

    end

    return full_name

end

---------------------------------------------------------------------------------------------------
-- Update global variables
---------------------------------------------------------------------------------------------------

function unilib.update_turf_seeder_items()

    -- Called by code in ../lib/system/import_pkg.lua
    -- Updates the table of turf seeder items, unilib.turf_seeder_table, replacing items represented
    --      as groups (e.g. "group:dry_grass") with actual node names (e.g. "unilib:grass_dry_1")

    local new_table = {}

    for seeder_name, data_table in pairs(unilib.turf_seeder_table) do

        if string.sub(seeder_name, 1, 6) ~= "group:" then

            new_table[seeder_name] = data_table

        else

            local group = string.sub(seeder_name, 7)
            for full_name, def_table in pairs(minetest.registered_nodes) do

                if minetest.get_item_group(full_name, group) ~= 0 then

                    new_table[full_name] = {}
                    for k, v in pairs(data_table) do
                        new_table[full_name][k] = v
                    end

                end

            end

        end

    end

    unilib.turf_seeder_table = new_table

end
