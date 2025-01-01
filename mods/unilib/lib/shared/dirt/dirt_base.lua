---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- dirt_base.lua
--      Base API functions for dirts
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Base API functions for dirts
---------------------------------------------------------------------------------------------------

function unilib.dirt._register_fertile_dirt(data_table)

    -- Original to unilib
    -- Registers a dirt node on which turf can be grown
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "dirt_ordinary" (in almost all cases, this will be the full
    --          item_name for the node)
    --      orig_name (str): e.g. "default:dirt"
    --      def_table (table): Full definition table for the node
    --
    -- data_table optional fields:
    --      replace_mode (str): e.g. "defer"
    --      compressed_description (str): e.g. "Compressed Ordinary Dirt"
    --      compressed_group_table (table): e.g. {crumbly = 2}, which should follow the uncompressed
    --          dirt's group table, e.g. {crumbly = 3} (i.e. making the compressed form a little
    --          harder to dig). Note that this function automatically adds compresseddirt = 1
    --      dry_soil (str): The dry soil, if required, e.g. "unilib:soil_ordinary". If specified,
    --          .wet_soil must be specified as well
    --      not_super_flag (bool): If true, this dirt is not suitable for use as a super dirt
    --      wet_soil (str): The wet soil, if required, e.g. "unilib:soil_ordinary_wet"
    --
    -- Return values:
    --      The full_name of the new node

    local part_name = data_table.part_name
    local orig_name = data_table.orig_name
    local def_table = data_table.def_table

    local replace_mode = data_table.replace_mode or unilib.default_replace_mode
    local compressed_description = data_table.compressed_description or S("Compressed Dirt")
    local compressed_group_table = data_table.compressed_group_table or {crumbly = 2}
    local dry_soil = data_table.dry_soil or nil
    local not_super_flag = data_table.not_super_flag or false
    local wet_soil = data_table.wet_soil or nil

    local full_name = "unilib:" .. part_name
    local compressed_name = full_name .. "_compressed"

    if dry_soil ~= nil and
            core.registered_nodes[dry_soil] ~= nil and
            wet_soil ~= nil and
            core.registered_nodes[wet_soil] ~= nil then

        def_table.soil = {
            base = full_name,
            dry = dry_soil,
            wet = wet_soil,
        }

    end

    unilib.register_node(full_name, orig_name, replace_mode, def_table)

    -- The compressed form of ordinary dirt is handled by the "dirt_ordinary" package directly
    if unilib.setting.squeezed_dirt_flag and part_name ~= "dirt_ordinary" then

        compressed_group_table.compresseddirt = 1

        unilib.register_node(compressed_name, nil, replace_mode, {
            description = compressed_description,
            tiles = {"unilib_" .. part_name .. "_compressed.png"},
            groups = compressed_group_table,
            sounds = unilib.global.sound_table.dirt,

            is_ground_content = false,
            stack_max = unilib.global.squeezed_stack_max,
        })
        unilib.misc.set_squeezed_recipes(full_name, compressed_name)
        unilib.register_stairs(compressed_name)

    end

    -- Update global variables
    unilib.global.fertile_dirt_table[part_name] = full_name
    if not_super_flag then
        unilib.global.super_dirt_table[part_name] = nil
    elseif unilib.global.super_stone_mode == "everything" then
        unilib.global.super_dirt_table[part_name] = true
    end

    return full_name

end

function unilib.dirt._register_other_dirt(part_name)

    -- Original to unilib
    -- Registers a dirt node on which turf cannot be grown, but which is still suitable for use as a
    --      super-dirt
    --
    -- Dirts for which this function is not suitable include mossy dirts, muds, peats, permeables,
    --      composite/compacted/compressed dirts and any dirt nodes with turf/cover/litter
    -- Dirts for which this function IS suitable include most permafrosts
    --
    -- Unlike calls to unilib.register_fertile_dirt(), this function doesn't call
    --      core.register_node(); it merely updates global variables
    -- Like calls to unilib.register_dirt_with_turf(), this function can also be called for non-dirt
    --      nodes which are to be used as super dirts, e.g. "unilib:clay_red"
    --
    -- Args:
    --      part_name (str): e.g. "dirt_ordinary", "clay_red" (in almost all cases, this will be the
    --          full item_name for the node)

    -- Update global variables
    if unilib.global.super_stone_mode == "everything" then
        unilib.global.super_dirt_table[part_name] = true
    end

end

function unilib.dirt._register_dirt_with_turf(data_table)

    -- Original to unilib
    -- Registers a dirt-with-turf node
    -- This function can also be called for non-dirt nodes which are to be combined with turf,
    --      e.g. "unilib:clay_red"
    --
    -- data_table compulsory fields:
    --      dirt_part_name (str): e.g. "dirt_ordinary", "clay_red"
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
    --          unilib.global.dirt_with_turf_table, rather than the equivalent values above. For
    --          example, when the turf cutter is used on "unilib:dirt_ordinary_with_cover_snow", it
    --          needs to create "unilib:dirt_construction_with_turf" (rather than the unwanted
    --          "unilib:dirt_construction_with_snow_cover"); in that case, .turf_part_name should be
    --          "snow_cover", and .alt_turf_part_name should be "turf"
    --      turf_description (str): e.g. "Turf". This value is stored in
    --          unilib.global.dirt_with_turf_table so, if the alternative fields above are used, the
    --          description will be "Turf" not "Snow Cover"
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

    if dry_soil ~= nil and
            core.registered_nodes[dry_soil] ~= nil and
            wet_soil ~= nil and
            core.registered_nodes[wet_soil] ~= nil then

        def_table.soil = {
            base = full_name,
            dry = dry_soil,
            wet = wet_soil,
        }

    end

    -- If required, the turf covers all four sides (leaving the dirt itself visible only on the
    --      bottom)
    if unilib.setting.overgrown_turf_flag then
        def_table.tiles = { def_table.tiles[1] }
    end

    unilib.register_node(full_name, orig_name, replace_mode, def_table)

    -- Update global variables
    local data_table = {
        dirt_part_name = alt_dirt_part_name,
        turf_part_name = alt_turf_part_name,
        turf_description = turf_description,
    }

    unilib.global.dirt_with_turf_table[full_name] = data_table
    if unilib.global.dirt_with_turf_reverse_table[alt_dirt_part_name] == nil then
        unilib.global.dirt_with_turf_reverse_table[alt_dirt_part_name] = {full_name}
    else
        table.insert(unilib.global.dirt_with_turf_reverse_table[alt_dirt_part_name], full_name)
    end

    if turf_seeder ~= nil then

        if unilib.global.turf_seeder_table[turf_seeder] == nil then
            unilib.global.turf_seeder_table[turf_seeder] = {}
        end

        unilib.global.turf_seeder_table[turf_seeder]["unilib:" .. dirt_part_name] = full_name

    end

    return full_name

end
