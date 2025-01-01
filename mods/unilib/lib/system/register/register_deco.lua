---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- register_deco.lua
--      Register decorations
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

-- Local storage for the decoration/ore seed offsets
local storage_random_seed_offset = unilib.utils.get_mod_attribute("storage_random_seed_offset")

---------------------------------------------------------------------------------------------------
-- Register decorations
---------------------------------------------------------------------------------------------------

function unilib.register._register_decoration_generic(generic_name, generic_def_table)

    -- Original to unilib
    -- For details about creating decorations, see the explanatory notes in global.lua
    -- This function is called by a package like "tree_aspen", which creates a generic definition
    --      table stored in a global variable
    -- Later, packages like "deco_default_tree_aspen" will call
    --      unilib.register_decoration_complete() with a specific definition table. The generic and
    --      specific tables are combined in the eventual call to core.register_decoration()
    --
    -- Args:
    --      generic_name (str): Name in the form REMIX-NAME_ITEM-NAME_N; see the notes in global.lua
    --      generic_def_table (table): The generic definition table itself. If specified, the fields
    --          .biomes, .place_on, .spawn_by, .num_spawn_by, .y_max and .y_min are overwritten with
    --          default values

    if unilib.global.generic_deco_table[generic_name] ~= nil then

        unilib.utils.show_warning(
            "unilib.register_decoration_generic(): Duplicate generic decoration name", generic_name
        )

    end

    -- Set generic values which should not appear in "generic_def_table"
    generic_def_table.biomes = nil       -- Place anywhere
    generic_def_table.place_on = nil     -- Place anywhere
    generic_def_table.spawn_by = nil     -- Spawn next to any node
    generic_def_table.num_spawn_by = -1
    generic_def_table.y_max = unilib.constant.y_max
    generic_def_table.y_min = 1

    -- Apply the random seed offset, if required
    if generic_def_table.noise_params ~= nil and generic_def_table.noise_params.seed ~= nil then

        generic_def_table.noise_params.seed = generic_def_table.noise_params.seed +
                storage_random_seed_offset

    end

    -- Store the generic definition table until it can be retrieved by a later call to
    --      unilib.register_decoration_complete()
    unilib.global.generic_deco_table[generic_name] = generic_def_table

    -- Store the .place_offset_y field, if present, for the benefit of any code that needs it
    if generic_def_table.deco_type == "schematic" and
            generic_def_table.place_offset_y ~= nil and
            generic_def_table.place_offset_y ~= 0 then

        unilib.global.deco_schem_offset_table[generic_def_table.schematic] =
                generic_def_table.place_offset_y

    end

end

function unilib.register._register_decoration_spare(full_name, fill_ratio)

    -- Original to unilib
    -- Generates a generic decoration definition for any suitable items (plants, flowers etc) which
    --      otherwise would not have one (usually because the original code did not specify one)
    -- This function is for the benefit of package writers, perhaps those who are creating many
    --      different decorations in a single packge
    -- In that situation, it might be annoying to have to call unilib.register_decoration_generic()
    --      for some items, and not others; this function guarantees that there's a generic
    --      definition already available for all suitable items, so the package writer only needs to
    --      call unilib.register_decoration_complete() for each one
    --
    -- Given an item whose name is in the form
    --      unilib:plant_heath_gold or mymod:plant_heath_gold
    -- ...this function creates a generic decoration definition called
    --      "unilib_plant_heath_gold"
    --
    -- Args:
    --      full_name (str): e.g. "unilib:plant_heath_gold"
    --
    -- Optional args:
    --      fill_ratio (float): If not specified, a value of 0.01 is used
    --
    -- Return values:
    --      Returns the name of the generic decoration definition created

    local generic_deco_name = unilib.utils.get_unique_deco_name(
        "unilib_" .. unilib.utils.get_item_name(full_name)
    )

    if fill_ratio == nil then
        fill_ratio = 0.01
    end

    unilib.register_decoration_generic(generic_deco_name, {
        deco_type = "simple",
        decoration = full_name,

        fill_ratio = fill_ratio,
        sidelen = 16,
    })

    return generic_deco_name

end

function unilib.register._register_decoration_complete(
    generic_name, specific_name, specific_def_table
)
    -- Original to unilib
    -- The earlier call to unilib.register_decoration created a generic definition table, with
    --      the name "generic_name"
    -- This call supplies a specific definition table, whose values override the generic table.
    --      The combined table is used in the call to core.register_decoration()
    -- Registers the decoration in the specified biome
    --
    -- Args:
    --      generic_name (str): Name in the form REMIX-NAME_ITEM-NAME_N; see the notes in
    --          global.lua. A key in unilib.global.generic_deco_table
    --      specific_name (str or nil): If specified, the decoration is registered with the .name
    --          "unilib:SPECIFIC_NAME". If not specified, the decoration is registered with the
    --          .name "unilib:GENERIC_NAME". Note that any .name field in "specific_def_table"
    --          will be ignored
    --      specific_def_table (table): A partial definition table containing any number of fields
    --          (including none at all) to be used in the core.register_decoration() call. The
    --          specified fields will overwrite one of the generic values for the fields .biomes,
    --          .place_on, .spawn_by, .num_spawn_by, .y_max and .y_min

    -- Basic checks
    if unilib.global.generic_deco_table[generic_name] == nil then

        unilib.utils.show_error(
            "unilib.register_decoration_complete(): Missing generic decoration definition",
            generic_name
        )

        return

    elseif unilib.setting.debug_check_heights_flag and
            not unilib.utils.check_heights(specific_def_table.y_max, specific_def_table.y_min) then

        unilib.utils.show_warning(
            "unilib.register_decoration_complete(): Invalid height values in decoration" ..
                    " registration",
            generic_name,
            specific_def_table.y_max,
            specific_def_table.y_min
        )

    end

    local deco_name = specific_name
    if deco_name == nil then
        deco_name = generic_name
    end

    if core.registered_decorations["unilib:" .. deco_name] ~= nil or
            unilib.global.deco_name_check_table[deco_name] ~= nil then

        unilib.utils.show_error(
            "unilib.register_decoration_complete(): Decoration already registered",
            deco_name,
            generic_name
        )

        return

    end

    -- The default behaviour is to register the decoration in the specified biome(s)
    local adj_def_table = {}

    for k, v in pairs(unilib.global.generic_deco_table[generic_name]) do
        adj_def_table[k] = v
    end

    specific_def_table.auto = nil
    for k, v in pairs(specific_def_table) do
        adj_def_table[k] = v
    end

    adj_def_table["name"] = unilib.utils.get_unique_deco_name("unilib:" .. deco_name)

    -- When biome showcase mode is enabled, all decorations must spawn at all heights
    if unilib.setting.debug_biome_showcase_flag then

        adj_def_table.y_max = unilib.constant.y_max
        adj_def_table.y_min = unilib.constant.y_min

    end

    -- If biome filters are enabled, and apply to all biomes specified by the decoration, then the
    --      decoration is not viable, and must not be registered
    adj_def_table = unilib.register.check_biomes_in_decoration(adj_def_table)
    if adj_def_table == nil then
        return
    end

    -- The decoration definition is now ready to be registered with the engine
--  core.register_decoration(adj_def_table)
    table.insert(unilib.global.deco_other_final_list, adj_def_table)
    if adj_def_table.name ~= nil then
        unilib.global.deco_name_check_table[adj_def_table.name] = true
    end

end
